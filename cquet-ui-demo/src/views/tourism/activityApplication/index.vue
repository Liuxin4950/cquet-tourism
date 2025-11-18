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
      border
      stripe
      size="small"
      highlight-current-row
      :header-cell-style="{ background: '#fafafa', color: '#606266' }"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" prop="id" width="90" align="center" />
      <el-table-column label="活动名称" prop="name" min-width="180" :show-overflow-tooltip="true" />
      <el-table-column label="所属场馆" min-width="160">
        <template slot-scope="scope">{{ venueName(scope.row.venueId) }}</template>
      </el-table-column>
      <el-table-column label="审核状态" prop="auditStatus" width="110" align="center">
        <template slot-scope="scope">
          <el-tag :type="auditTagType(scope.row.auditStatus)">{{ auditText(scope.row.auditStatus) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="审核人" prop="auditor" width="120" :show-overflow-tooltip="true" />
      <el-table-column label="审核时间" prop="auditTime" width="170" align="center">
        <template slot-scope="scope"><span>{{ parseTime(scope.row.auditTime) }}</span></template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right" width="220">
        <template slot-scope="scope">
          <template v-if="scope.row.auditStatus === '0'">
            <el-button size="mini" type="text" icon="el-icon-circle-check" @click="approve(scope.row)" v-hasPermi="['tourism:activityApplication:approve']">通过</el-button>
            <el-button size="mini" type="text" icon="el-icon-circle-close" @click="reject(scope.row)" v-hasPermi="['tourism:activityApplication:reject']">拒绝</el-button>
          </template>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['tourism:activity:remove']">删除</el-button>
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
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除活动编号为"' + ids + '"的数据项？').then(function () { return delScenicActivity(ids) }).then(() => { this.getList(); this.$modal.msgSuccess('删除成功') }).catch(() => { this.$modal.msgError('删除失败') })
    },
    auditText(s) { if (s === '1') return '通过'; if (s === '2') return '拒绝'; return '待审核' },
    auditTagType(s) { if (s === '1') return 'success'; if (s === '2') return 'danger'; return 'warning' },
    venueName(id) { return this.venueMap[id] || ('#' + id) }
  }
}
</script>

<style lang="scss" scoped>
.app-container { padding: 20px; }
</style>