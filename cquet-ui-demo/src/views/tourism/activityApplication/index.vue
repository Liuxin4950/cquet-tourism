<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="活动名称" prop="name">
        <el-input v-model="queryParams.name" placeholder="请输入活动名称" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="所属场馆" prop="venueId">
        <el-select v-model="queryParams.venueId" placeholder="选择场馆" clearable filterable style="width: 240px">
          <el-option v-for="v in venueOptions" :key="v.id" :label="v.name" :value="v.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="审核状态" prop="auditStatus">
        <el-select v-model="queryParams.auditStatus" placeholder="审核状态" clearable style="width: 240px">
          <el-option label="待审核" value="0" />
          <el-option label="通过" value="1" />
          <el-option label="拒绝" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table
      v-loading="loading"
      :data="activityList"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" prop="id" width="90" align="center" />
      <el-table-column label="活动名称" prop="name" width="150" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="所属场馆" width="150">
        <template slot-scope="scope">{{ venueName(scope.row.venueId) }}</template>
      </el-table-column>
      <el-table-column label="申报人" prop="applicantName" width="150" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="申报理由" prop="applyReason" width="250" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="审核状态" prop="auditStatus" width="150" align="center">
        <template slot-scope="scope">
          <el-tag :type="auditTagType(scope.row.auditStatus)">{{ auditText(scope.row.auditStatus) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="审核人" prop="auditor" width="150" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="审核意见" prop="auditReason" width="250" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="审核时间" prop="auditTime" align="center" width="190">
        <template slot-scope="scope"><span>{{ scope.row.auditTime ? parseTime(scope.row.auditTime) : '暂无...' }}</span></template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right" width="190">
        <template slot-scope="scope">
          <template v-if="scope.row.auditStatus === '0'">
            <el-button size="mini" type="text" icon="el-icon-circle-check" @click="approve(scope.row)" v-hasPermi="['tourism:activityApplication:approve']">通过</el-button>
            <el-button size="mini" type="text" icon="el-icon-circle-close" @click="reject(scope.row)" v-hasPermi="['tourism:activityApplication:reject']">拒绝</el-button>
        </template>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
  </div>
</template>

<script>
import { listScenicActivityApplication, passScenicActivityApplication, rejectScenicActivityApplication, delScenicActivity } from '@/api/tourism/scenicActivity'
import { listScenicVenue } from '@/api/tourism/scenicVenue'
import Pagination from '@/components/Pagination'

export default {
  name: 'TourismActivityApplication',
  components: { Pagination },
  data() {
    return {
      activityList: [],
      total: 0,
      single: true,
      multiple: true,
      ids: [],
      queryParams: { pageNum: 1, pageSize: 10, name: undefined, venueId: undefined, auditStatus: '0' },
      showSearch: true,
      loading: false,
      venueOptions: [],
      venueMap: {}
    }
  },
  created() {
    this.getList()
    listScenicVenue({ pageNum: 1, pageSize: 1000 }).then(res => {
      this.venueOptions = res.rows || []
      this.venueMap = (this.venueOptions || []).reduce((m, v) => { m[v.id] = v.name; return m }, {})
    })
  },
  methods: {
    handleQuery() { this.getList() },
    getList() {
      this.loading = true
      listScenicActivityApplication(this.queryParams).then(response => {
        this.loading = false
        this.activityList = response.rows
        this.total = response.total
      })
    },
    resetQuery() { this.queryParams = { pageNum: 1, pageSize: 10, name: undefined, venueId: undefined, auditStatus: '0' }; this.getList() },
    handleSelectionChange(selection) { this.ids = selection.map(item => item.id); this.single = selection.length != 1; this.multiple = !selection.length },
    formatText(row, column, cellValue) { return cellValue || '暂无...' },
    approve(row) {
      this.$prompt('请输入审核意见（可选）', '审核通过', { confirmButtonText: '确定', cancelButtonText: '取消' }).then(({ value }) => {
        passScenicActivityApplication(row.id, value).then(() => { this.$modal.msgSuccess('审核通过'); this.getList() })
      }).catch(() => {})
    },
    reject(row) {
      this.$prompt('请输入审核不通过原因（必填）', '审核拒绝', { confirmButtonText: '确定', cancelButtonText: '取消', inputValidator: v => !!(v && v.trim()), inputErrorMessage: '原因不能为空' }).then(({ value }) => {
        rejectScenicActivityApplication(row.id, value).then(() => { this.$modal.msgSuccess('审核已拒绝'); this.getList() })
      }).catch(() => {})
    },
    auditText(s) { if (s === '1') return '通过'; if (s === '2') return '拒绝'; return '待审核' },
    auditTagType(s) { if (s === '1') return 'success'; if (s === '2') return 'danger'; return 'warning' },
    venueName(id) { const name = this.venueMap[id]; return name ? name : '暂无...' }
  }
}
</script>

<style lang="scss" scoped>
.app-container { padding: 20px; }
</style>
