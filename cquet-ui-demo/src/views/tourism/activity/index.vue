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
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="活动状态" clearable style="width: 240px">
          <el-option label="正常" value="0" />
          <el-option label="停用" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item label="创建时间">
        <el-date-picker v-model="dateRange" style="width: 240px" value-format="yyyy-MM-dd" type="daterange" range-separator="-" start-placeholder="开始日期" end-placeholder="结束日期" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['tourism:activity:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['tourism:activity:edit']">修改</el-button>
      </el-col>
    </el-row>

    <el-table
      v-loading="loading"
      :data="activityList"
      @selection-change="handleSelectionChange"
      @sort-change="handleSortChange"
      border
      stripe
      size="small"
      highlight-current-row
      :header-cell-style="{ background: '#fafafa', color: '#606266' }"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" prop="id" width="90" align="center" sortable="custom" />
      <el-table-column label="活动名称" prop="name" min-width="180" :show-overflow-tooltip="true" />
      <el-table-column label="所属场馆" min-width="160">
        <template slot-scope="scope">{{ venueName(scope.row.venueId) }}</template>
      </el-table-column>
      <el-table-column label="类别" prop="category" width="120" :show-overflow-tooltip="true" />
      <el-table-column label="主办方" prop="organizer" width="140" :show-overflow-tooltip="true" />
      <el-table-column label="联系电话" prop="contactPhone" width="140" :show-overflow-tooltip="true" />
      <el-table-column label="开始时间" prop="startTime" width="170" align="center">
        <template slot-scope="scope"><span>{{ parseTime(scope.row.startTime) }}</span></template>
      </el-table-column>
      <el-table-column label="结束时间" prop="endTime" width="170" align="center">
        <template slot-scope="scope"><span>{{ parseTime(scope.row.endTime) }}</span></template>
      </el-table-column>
      <el-table-column label="人数" prop="currentParticipants" width="120" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.currentParticipants }} / {{ scope.row.maxParticipants }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核状态" prop="auditStatus" width="110" align="center">
        <template slot-scope="scope">
          <el-tag :type="auditTagType(scope.row.auditStatus)">{{ auditText(scope.row.auditStatus) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="状态" prop="status" width="100" align="center">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" prop="createTime" width="170" align="center">
        <template slot-scope="scope"><span>{{ parseTime(scope.row.createTime) }}</span></template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right" width="240">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-document" @click="viewDetail(scope.row)" v-hasPermi="['tourism:activity:query']">详情</el-button>
          <el-button size="mini" type="text" icon="el-icon-video-play" @click="toggleStatus(scope.row)" v-hasPermi="['tourism:activity:edit']">{{ scope.row.status === '0' ? '停用' : '启用' }}</el-button>
          <template v-if="scope.row.auditStatus === '0'">
            <el-button size="mini" type="text" icon="el-icon-circle-check" @click="approve(scope.row)" v-hasPermi="['tourism:activity:approve']">通过</el-button>
            <el-button size="mini" type="text" icon="el-icon-circle-close" @click="reject(scope.row)" v-hasPermi="['tourism:activity:reject']">拒绝</el-button>
          </template>
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['tourism:activity:edit']">修改</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

      <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
        <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12"><el-form-item label="活动名称" prop="name"><el-input v-model="form.name" placeholder="请输入活动名称" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="类别" prop="category"><el-input v-model="form.category" placeholder="请输入类别" /></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="12"><el-form-item label="所属场馆" prop="venueId"><el-select v-model="form.venueId" placeholder="选择场馆" style="width: 100%"><el-option v-for="v in venueOptions" :key="v.id" :label="v.name" :value="v.id" /></el-select></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="联系电话" prop="contactPhone"><el-input v-model="form.contactPhone" placeholder="请输入联系电话" /></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="12"><el-form-item label="开始时间" prop="startTime"><el-date-picker v-model="form.startTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="选择开始时间" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="结束时间" prop="endTime"><el-date-picker v-model="form.endTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="选择结束时间" style="width: 100%" /></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="24"><el-form-item label="活动介绍" prop="description"><el-input v-model="form.description" type="textarea" :rows="4" placeholder="请输入活动介绍" /></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="24"><el-form-item label="备注" prop="remark"><el-input v-model="form.remark" type="textarea" placeholder="请输入内容" /></el-form-item></el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog title="活动详情" :visible.sync="detailOpen" width="700px" append-to-body>
      <el-descriptions :border="true" :column="2" size="small">
        <el-descriptions-item label="活动名称">{{ detail.name }}</el-descriptions-item>
        <el-descriptions-item label="类别">{{ detail.category }}</el-descriptions-item>
        <el-descriptions-item label="主办方">{{ detail.organizer }}</el-descriptions-item>
        <el-descriptions-item label="联系电话">{{ detail.contactPhone }}</el-descriptions-item>
        <el-descriptions-item label="开始时间">{{ parseTime(detail.startTime) }}</el-descriptions-item>
        <el-descriptions-item label="结束时间">{{ parseTime(detail.endTime) }}</el-descriptions-item>
        <el-descriptions-item label="审核状态"><el-tag :type="auditTagType(detail.auditStatus)">{{ auditText(detail.auditStatus) }}</el-tag></el-descriptions-item>
        <el-descriptions-item label="状态"><el-tag :type="detail.status === '0' ? 'success' : 'info'">{{ detail.status === '0' ? '正常' : '停用' }}</el-tag></el-descriptions-item>
        <el-descriptions-item label="审核人">{{ detail.auditor }}</el-descriptions-item>
        <el-descriptions-item label="审核意见">{{ detail.auditReason }}</el-descriptions-item>
        <el-descriptions-item label="活动介绍" :span="2">{{ detail.description }}</el-descriptions-item>
      </el-descriptions>
      <div slot="footer" class="dialog-footer">
        <el-button @click="detailOpen = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listScenicActivity, getScenicActivity, addScenicActivity, updateScenicActivity, updateScenicActivityStatus, approveScenicActivity, rejectScenicActivity } from '@/api/tourism/scenicActivity'
import { listScenicVenue } from '@/api/tourism/scenicVenue'
import Pagination from '@/components/Pagination'

export default {
  name: 'TourismActivity',
  components: { Pagination },
  data() {
    return {
      activityList: [],
      total: 0,
      single: true,
      multiple: true,
      ids: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        startTime: undefined,
        endTime: undefined,
        name: undefined,
        venueId: undefined,
        auditStatus: undefined,
        status: undefined,
        orderByColumn: 'id',
        isAsc: 'asc'
      },
      dateRange: [],
      showSearch: true,
      loading: false,
      title: '',
      open: false,
      form: {},
      rules: {
        name: [{ required: true, message: '活动名称不能为空', trigger: 'blur' }],
        category: [{ required: true, message: '类别不能为空', trigger: 'blur' }],
        venueId: [{ required: true, message: '所属场馆不能为空', trigger: 'change' }],
        startTime: [{ required: true, message: '开始时间不能为空', trigger: 'change' }],
        endTime: [{ required: true, message: '结束时间不能为空', trigger: 'change' }]
      },
      venueOptions: [],
      venueMap: {},
      detailOpen: false,
      detail: {}
    }
  },
  created() {
    this.getList()
    listScenicVenue({ pageNum: 1, pageSize: 1000 }).then(res => { this.venueOptions = res.rows || []; this.venueMap = (this.venueOptions || []).reduce((m, v) => { m[v.id] = v.name; return m }, {}) })
  },
  methods: {
    handleQuery() { this.getList() },
    getList() {
      this.loading = true
      this.queryParams.startTime = this.dateRange[0]
      this.queryParams.endTime = this.dateRange[1]
      listScenicActivity(this.queryParams).then(response => {
        this.loading = false
        this.activityList = response.rows
        this.total = response.total
      })
    },
    resetQuery() {
      this.queryParams = { pageNum: 1, pageSize: 10, name: undefined, venueId: undefined, auditStatus: undefined, status: undefined, orderByColumn: 'id', isAsc: 'asc' }
      this.dateRange = []
      this.getList()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    handleSortChange(column) {
      this.queryParams.orderByColumn = column.prop
      this.queryParams.isAsc = column.order === 'ascending' ? 'asc' : 'desc'
      this.getList()
    },
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids[0]
      getScenicActivity(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = '修改特色活动'
      })
    },
    reset() {
      this.form = { id: undefined, name: undefined, category: undefined, venueId: undefined, organizer: undefined, contactPhone: undefined, startTime: undefined, endTime: undefined, description: undefined, remark: undefined }
      this.resetForm && this.resetForm('form')
    },
    handleAdd() {
      this.open = true
      this.title = '新增特色活动'
      this.reset()
    },
    submitForm() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateScenicActivity(this.form).then(() => { this.$modal.msgSuccess('修改成功'); this.open = false; this.getList() })
          } else {
            addScenicActivity(this.form).then(() => { this.$modal.msgSuccess('新增成功'); this.open = false; this.getList() })
          }
        }
      })
    },
    cancel() { this.open = false; this.resetForm && this.resetForm('form') },
    toggleStatus(row) {
      const target = row.status === '0' ? '1' : '0'
      updateScenicActivityStatus(row.id, target).then(() => { this.$modal.msgSuccess('状态已更新'); this.getList() })
    },
    approve(row) {
      this.$prompt('请输入审核意见（可选）', '审核通过', { confirmButtonText: '确定', cancelButtonText: '取消' }).then(({ value }) => {
        approveScenicActivity(row.id, value).then(() => { this.$modal.msgSuccess('审核通过'); this.getList() })
      }).catch(() => {})
    },
    reject(row) {
      this.$prompt('请输入审核不通过原因（必填）', '审核拒绝', { confirmButtonText: '确定', cancelButtonText: '取消', inputValidator: v => !!(v && v.trim()), inputErrorMessage: '原因不能为空' }).then(({ value }) => {
        rejectScenicActivity(row.id, value).then(() => { this.$modal.msgSuccess('审核已拒绝'); this.getList() })
      }).catch(() => {})
    },
    viewDetail(row) {
      getScenicActivity(row.id).then(res => { this.detail = res.data || {}; this.detailOpen = true })
    },
    venueName(id) { return this.venueMap[id] || ('#' + id) },
    auditText(s) { if (s === '1') return '通过'; if (s === '2') return '拒绝'; return '待审核' },
    auditTagType(s) { if (s === '1') return 'success'; if (s === '2') return 'danger'; return 'warning' }
  }
}
</script>

<style lang="scss" scoped>
.app-container { padding: 20px; }
</style>