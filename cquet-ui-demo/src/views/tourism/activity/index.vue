<template>
  <div class="app-container tourism-page">
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

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['tourism:activity:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['tourism:activity:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['tourism:activity:remove']">删除</el-button>
      </el-col>
    </el-row>

    <el-table
      v-loading="loading"
      class="tourism-data-table"
      border
      stripe
      fit
      highlight-current-row
      :data="activityList"
      @selection-change="handleSelectionChange"
      @sort-change="handleSortChange"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" prop="id" width="90" align="center" sortable="custom" />
      <el-table-column label="活动名称" prop="name" min-width="160" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="所属场馆" min-width="150" :show-overflow-tooltip="true">
        <template slot-scope="scope">{{ venueName(scope.row.venueId) }}</template>
      </el-table-column>
      <el-table-column label="类别" prop="category" min-width="110" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="活动时间" min-width="210" align="center">
        <template slot-scope="scope">
          <span>{{ formatActivityTime(scope.row) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="人数" prop="currentParticipants" min-width="110" align="center">
        <template slot-scope="scope">
          <span>{{ (scope.row.currentParticipants != null && scope.row.maxParticipants != null) ? (scope.row.currentParticipants + ' / ' + scope.row.maxParticipants) : '暂无...' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="申报人" prop="applicantName" min-width="100" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="审核状态" prop="auditStatus" min-width="110" align="center">
        <template slot-scope="scope">
          <span v-if="scope.row.auditStatus === undefined || scope.row.auditStatus === null || scope.row.auditStatus === ''">暂无...</span>
          <el-tag v-else :type="auditTagType(scope.row.auditStatus)">{{ auditText(scope.row.auditStatus) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="运行状态" prop="status" min-width="100" align="center">
        <template slot-scope="scope">
          <span v-if="scope.row.status === undefined || scope.row.status === null || scope.row.status === ''">暂无...</span>
          <el-tag v-else :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="230">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-document" @click="viewDetail(scope.row)" v-hasPermi="['tourism:activity:query']">详情</el-button>
          <el-button size="mini" type="text" icon="el-icon-video-play" @click="toggleStatus(scope.row)" :disabled="scope.row.auditStatus !== '1'" v-hasPermi="['tourism:activity:edit']">{{ scope.row.status === '0' ? '停用' : '启用' }}</el-button>
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['tourism:activity:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['tourism:activity:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

      <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body custom-class="tourism-form-dialog">
        <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12"><el-form-item label="活动名称" prop="name"><el-input v-model="form.name" placeholder="请输入活动名称" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="类别" prop="category"><el-select v-model="form.category" placeholder="请选择类别" filterable clearable style="width: 100%"><el-option v-for="opt in categoryOptions" :key="opt" :label="opt" :value="opt" /></el-select></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="12"><el-form-item label="所属场馆" prop="venueId"><el-select v-model="form.venueId" placeholder="选择场馆" style="width: 100%"><el-option v-for="v in venueOptions" :key="v.id" :label="v.name" :value="v.id" /></el-select></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="联系电话" prop="contactPhone"><el-input v-model="form.contactPhone" placeholder="请输入联系电话" /></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="24"><el-form-item label="主办方" prop="organizer"><el-input v-model="form.organizer" placeholder="请输入主办方" /></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="12"><el-form-item label="封面图片" prop="coverImage"><image-upload v-model="form.coverImage" :limit="1" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="运行状态" prop="status"><el-select v-model="form.status" placeholder="选择状态" style="width: 100%"><el-option label="正常" value="0" /><el-option label="停用" value="1" /></el-select></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="12"><el-form-item label="当前人数" prop="currentParticipants"><el-input-number v-model="form.currentParticipants" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="最大人数" prop="maxParticipants"><el-input-number v-model="form.maxParticipants" :min="1" style="width: 100%" /></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="12"><el-form-item label="开始时间" prop="startTime"><el-date-picker v-model="form.startTime" type="datetime" value-format="yyyy-MM-dd'T'HH:mm:ss" placeholder="选择开始时间" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="结束时间" prop="endTime"><el-date-picker v-model="form.endTime" type="datetime" value-format="yyyy-MM-dd'T'HH:mm:ss" placeholder="选择结束时间" style="width: 100%" /></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="24"><el-form-item label="活动介绍" prop="description"><el-input v-model="form.description" type="textarea" :rows="4" placeholder="请输入活动介绍" /></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="24"><el-form-item label="申报理由" prop="applyReason"><el-input v-model="form.applyReason" type="textarea" :rows="3" placeholder="请输入申报理由" /></el-form-item></el-col>
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

    <el-dialog title="活动详情" :visible.sync="detailOpen" width="900px" append-to-body custom-class="tourism-detail-dialog">
      <div class="detail-module">
        <div class="main-img-wrapper">
          <el-image
            v-if="detail.coverImage"
            :src="imageUrl(detail.coverImage)"
            :preview-src-list="[imageUrl(detail.coverImage)]"
            class="main-img"
            fit="cover"
          />
          <div v-else class="empty-tip">暂无图片</div>
        </div>
      </div>
      <div class="detail-card">
        <div class="detail-row">
          <div class="detail-item"><div class="label">活动名称</div><div class="value">{{ detail.name || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">类别</div><div class="value">{{ detail.category || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">主办方</div><div class="value">{{ detail.organizer || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">联系电话</div><div class="value">{{ detail.contactPhone || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">开始时间</div><div class="value">{{ detail.startTime ? parseTime(detail.startTime) : '暂无' }}</div></div>
          <div class="detail-item"><div class="label">结束时间</div><div class="value">{{ detail.endTime ? parseTime(detail.endTime) : '暂无' }}</div></div>
          <div class="detail-item"><div class="label">审核状态</div><div class="value"><el-tag :type="auditTagType(detail.auditStatus)">{{ auditText(detail.auditStatus) }}</el-tag></div></div>
          <div class="detail-item"><div class="label">状态</div><div class="value"><el-tag :type="detail.status === '0' ? 'success' : 'info'">{{ detail.status === '0' ? '正常' : '停用' }}</el-tag></div></div>
        </div>
      </div>
      <div class="detail-card">
        <div class="detail-row single">
          <div class="detail-item"><div class="label">申报人</div><div class="value">{{ detail.applicantName || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">申报时间</div><div class="value">{{ detail.applyTime ? parseTime(detail.applyTime) : '暂无' }}</div></div>
          <div class="detail-item"><div class="label">申报理由</div><div class="value">{{ detail.applyReason || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">人数</div><div class="value">{{ (detail.currentParticipants != null && detail.maxParticipants != null) ? (detail.currentParticipants + ' / ' + detail.maxParticipants) : '暂无' }}</div></div>
          <div class="detail-item"><div class="label">活动介绍</div><div class="value">{{ detail.description || '暂无' }}</div></div>
        </div>
      </div>
      <div slot="footer" class="dialog-footer"><el-button class="detail-close-btn" @click="detailOpen = false">关 闭</el-button></div>
    </el-dialog>
  </div>
</template>

<script>
import { listScenicActivity, getScenicActivity, addScenicActivity, updateScenicActivity, updateScenicActivityStatus, approveScenicActivity, rejectScenicActivity, delScenicActivity } from '@/api/tourism/scenicActivity'
import { listScenicVenue } from '@/api/tourism/scenicVenue'
import Pagination from '@/components/Pagination'
import ImageUpload from '@/components/ImageUpload'

export default {
  name: 'TourismActivity',
  components: { Pagination, ImageUpload },
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
        endTime: [{ required: true, message: '结束时间不能为空', trigger: 'change' }],
        maxParticipants: [{ required: true, message: '最大人数不能为空', trigger: 'blur' }],
        applyReason: [{ required: true, message: '申报理由不能为空', trigger: 'blur' }]
      },
      venueOptions: [],
      venueMap: {},
      categoryOptions: ['展览', '演出', '讲座'],
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
      this.form = { id: undefined, name: undefined, category: undefined, venueId: undefined, organizer: undefined, contactPhone: undefined, startTime: undefined, endTime: undefined, coverImage: undefined, status: '0', currentParticipants: 0, maxParticipants: 1, description: undefined, applyReason: undefined, remark: undefined }
      this.resetForm && this.resetForm('form')
    },
    handleAdd() {
      this.open = true
      this.title = '新增特色活动'
      this.reset()
    },
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal
        .confirm('是否确认删除活动编号为"' + ids + '"的数据项？')
        .then(function () { return delScenicActivity(ids) })
        .then(() => { this.getList(); this.$modal.msgSuccess('删除成功') })
        .catch(() => { this.$modal.msgError('删除失败') })
    },
    submitForm() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          if (Number(this.form.currentParticipants || 0) > Number(this.form.maxParticipants || 0)) { this.$modal.msgError('当前人数不能大于最大人数'); return }
          const payload = { ...this.form }
          delete payload.applyTime
          delete payload.auditTime
          delete payload.auditStatus
          delete payload.auditor
          delete payload.auditReason
          delete payload.createTime
          delete payload.updateTime
          delete payload.createBy
          delete payload.updateBy
          delete payload.delFlag
          if (this.form.id != undefined) {
            updateScenicActivity(payload).then(() => { this.$modal.msgSuccess('修改成功'); this.open = false; this.getList() })
          } else {
            delete payload.id
            addScenicActivity(payload).then(() => { this.$modal.msgSuccess('新增成功'); this.open = false; this.getList() })
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
    imageUrl(u) {
      const base = process.env.VUE_APP_BASE_API || ''
      if (!u) return ''
      return u.indexOf('http') === 0 ? u : base + u
    },
    formatActivityTime(row) {
      const start = row.startTime ? this.parseTime(row.startTime) : ''
      const end = row.endTime ? this.parseTime(row.endTime) : ''
      if (start && end) return start + ' 至 ' + end
      return start || end || '暂无...'
    },
    venueName(id) { const name = this.venueMap[id]; return name ? name : '暂无...' },
    formatText(row, column, cellValue) { return cellValue || '暂无...' },
    auditText(s) { if (s === '1') return '通过'; if (s === '2') return '拒绝'; return '待审核' },
    auditTagType(s) { if (s === '1') return 'success'; if (s === '2') return 'danger'; return 'warning' }
    }
  }
</script>

<style lang="scss" scoped>
.app-container { padding: 20px; }
.detail-module { margin-bottom: 16px; }
.main-img-wrapper { width: 100%; max-width: 1200px; overflow: hidden; border-radius: 8px; margin: 0 auto 24px; }
.main-img { width: 100%; height: 350px; }
::v-deep .main-img .el-image__inner { width: 100%; height: 350px; object-fit: cover; }
.detail-card { padding: 16px; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); margin-bottom: 16px; transition: box-shadow .2s ease; }
.detail-card:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.12); }
.detail-row { display: flex; flex-wrap: wrap; gap: 24px; }
.detail-row.single .detail-item { flex: 0 0 calc((100% - 24px) / 2); }
.detail-item { flex: 0 0 calc((100% - 24px * 3) / 4); }
.detail-item .label { font-size: 12px; color: #909399; margin-bottom: 4px; }
.detail-item .value { font-size: 14px; color: #303133; font-weight: 500; word-break: break-word; }
.content-img-group { display: flex; gap: 16px; max-width: 1200px; margin: 20px auto 0; }
.content-img-item { flex: 1; aspect-ratio: 4/3; overflow: hidden; border-radius: 8px; }
::v-deep .content-img-item .el-image__inner { width: 100%; height: 100%; object-fit: cover; }
.empty-tip { text-align: center; color: #909399; font-size: 12px; }
.detail-close-btn { display: inline-block; margin: 0 auto; }
.detail-close-btn:hover { color: #409eff; border-color: #409eff; }
</style>
