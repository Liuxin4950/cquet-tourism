<template>
  <div class="app-container tourism-page">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="通知标题" prop="title">
        <el-input v-model="queryParams.title" placeholder="请输入通知标题" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="创建时间">
        <el-date-picker v-model="dateRange" style="width: 240px" value-format="yyyy-MM-dd" type="daterange" range-separator="-" start-placeholder="开始日期" end-placeholder="结束日期" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetButton">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['tourism:notice:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['tourism:notice:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['tourism:notice:remove']">删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>

    <el-table
      v-loading="loading"
      class="tourism-data-table"
      border
      stripe
      fit
      highlight-current-row
      :data="noticeList"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" prop="id" width="100" align="center" />
      <el-table-column label="标题" prop="title" min-width="260" :show-overflow-tooltip="true" />
      <el-table-column label="创建人" prop="createBy" min-width="120" :show-overflow-tooltip="true" />
      <el-table-column label="创建时间" prop="createTime" width="180" align="center">
        <template slot-scope="scope"><span>{{ parseTime(scope.row.createTime) }}</span></template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="220">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-document" @click="viewDetail(scope.row)" v-hasPermi="['tourism:notice:query']">详情</el-button>
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['tourism:notice:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['tourism:notice:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" :visible.sync="open" width="1000px" append-to-body custom-class="tourism-form-dialog">
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="公告标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入公告标题" />
        </el-form-item>
        <el-form-item label="公告内容" prop="content">
          <editor v-model="form.content" :height="300" placeholder="请输入公告内容" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog title="公告详情" :visible.sync="detailOpen" width="900px" append-to-body custom-class="tourism-detail-dialog">
      <el-descriptions :border="true" :column="3" size="small">
        <el-descriptions-item label="标题">{{ detail.title }}</el-descriptions-item>
        <el-descriptions-item label="创建人">{{ detail.createBy }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ parseTime(detail.createTime) }}</el-descriptions-item>
      </el-descriptions>
      <div class="detail-article" v-html="detail.content"></div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="detailOpen = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listNotice, getNotice, addNotice, updateNotice, delNotice } from '@/api/tourism/notice'
import Pagination from '@/components/Pagination'

export default {
  name: 'TourismNotice',
  components: { Pagination },
  data() {
    return {
      noticeList: [],
      total: 0,
      single: true,
      multiple: true,
      ids: [],
      queryParams: { pageNum: 1, pageSize: 10, startDate: undefined, endDate: undefined, title: undefined },
      dateRange: [],
      showSearch: true,
      loading: false,
      title: '',
      open: false,
      form: {},
      detailOpen: false,
      detail: {},
      rules: {
        title: [{ required: true, message: '标题不能为空', trigger: 'blur' }]
      }
    }
  },
  created() { this.getList() },
  methods: {
    handleQuery() { this.getList() },
    getList() {
      this.loading = true
      const s = this.dateRange && this.dateRange[0] ? (this.dateRange[0] + ' 00:00:00') : undefined
      const e = this.dateRange && this.dateRange[1] ? (this.dateRange[1] + ' 23:59:59') : undefined
      this.queryParams.startDate = s
      this.queryParams.endDate = e
      listNotice(this.queryParams).then(response => { this.loading = false; this.noticeList = response.rows; this.total = response.total })
    },
    resetQuery() { this.queryParams = { pageNum: 1, pageSize: 10, title: undefined, startDate: undefined, endDate: undefined }; this.dateRange = []; this.getList() },
    resetButton() { this.dateRange = []; this.resetForm('queryForm'); this.queryParams = { pageNum: 1, pageSize: 10, title: undefined, startDate: undefined, endDate: undefined }; this.getList() },
    handleSelectionChange(selection) { this.ids = selection.map(item => item.id); this.single = selection.length != 1; this.multiple = !selection.length },
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids[0]
      getNotice(id).then(response => { this.form = response.data; this.open = true; this.title = '修改通知公告' })
    },
    reset() { this.form = { id: undefined, title: undefined, content: undefined, remark: undefined }; this.resetForm && this.resetForm('form') },
    handleAdd() { this.open = true; this.title = '新增通知公告'; this.reset() },
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除公告编号为"' + ids + '"的数据项？').then(function() { return delNotice(ids) }).then(() => { this.getList(); this.$modal.msgSuccess('删除成功') }).catch(() => { this.$modal.msgError('删除失败') })
    },
    submitForm() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateNotice(this.form).then(() => { this.$modal.msgSuccess('修改成功'); this.open = false; this.getList() })
          } else {
            addNotice(this.form).then(() => { this.$modal.msgSuccess('新增成功'); this.open = false; this.getList() })
          }
        }
      })
    },
    viewDetail(row) {
      getNotice(row.id).then(res => { this.detail = res.data || {}; this.detailOpen = true })
    },
    cancel() { this.open = false; this.resetForm && this.resetForm('form') }
  }
}
</script>

<style lang="scss" scoped>
.app-container { padding: 20px; }
.detail-article { padding: 12px 0; line-height: 1.8; }
</style>
