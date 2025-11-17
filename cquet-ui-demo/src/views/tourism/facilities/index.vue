<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="设备名称" prop="facilitiesName">
        <el-input v-model="queryParams.facilitiesName" placeholder="请输入设备名称" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['tourism:facilities:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['tourism:facilities:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['tourism:facilities:remove']">删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>

    <el-table
      v-loading="loading"
      :data="facilitiesList"
      @selection-change="handleSelectionChange"
      border
      stripe
      size="small"
      highlight-current-row
      :header-cell-style="{ background: '#fafafa', color: '#606266' }"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" prop="id" width="90" align="center" />
      <el-table-column label="设备名称" prop="facilitiesName" min-width="240" :show-overflow-tooltip="true" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right" width="160">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['tourism:facilities:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['tourism:facilities:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="设备名称" prop="facilitiesName">
          <el-input v-model="form.facilitiesName" placeholder="请输入设备名称" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listFacilities, getFacilities, addFacilities, updateFacilities, delFacilities } from '@/api/tourism/facilities'
import Pagination from '@/components/Pagination'

export default {
  name: 'TourismFacilities',
  components: { Pagination },
  data() {
    return {
      facilitiesList: [],
      total: 0,
      single: true,
      multiple: true,
      ids: [],
      queryParams: { pageNum: 1, pageSize: 10, facilitiesName: undefined },
      showSearch: true,
      loading: false,
      title: '',
      open: false,
      form: {},
      rules: { facilitiesName: [{ required: true, message: '设备名称不能为空', trigger: 'blur' }] }
    }
  },
  created() { this.getList() },
  methods: {
    handleQuery() { this.getList() },
    getList() { this.loading = true; listFacilities(this.queryParams).then(response => { this.loading = false; this.facilitiesList = response.rows; this.total = response.total }) },
    resetQuery() { this.queryParams = { pageNum: 1, pageSize: 10, facilitiesName: undefined }; this.getList() },
    handleSelectionChange(selection) { this.ids = selection.map(item => item.id); this.single = selection.length != 1; this.multiple = !selection.length },
    handleUpdate(row) { this.reset(); const id = row.id || this.ids[0]; getFacilities(id).then(response => { this.form = response.data; this.open = true; this.title = '修改设备' }) },
    reset() { this.form = { id: undefined, facilitiesName: undefined }; this.resetForm && this.resetForm('form') },
    handleAdd() { this.open = true; this.title = '新增设备'; this.reset() },
    handleDelete(row) { const ids = row.id || this.ids; this.$modal.confirm('是否确认删除设备编号为"' + ids + '"的数据项？').then(function() { return delFacilities(ids) }).then(() => { this.getList(); this.$modal.msgSuccess('删除成功') }).catch(() => { this.$modal.msgError('删除失败') }) },
    submitForm() { this.$refs['form'].validate(valid => { if (valid) { if (this.form.id != undefined) { updateFacilities(this.form).then(() => { this.$modal.msgSuccess('修改成功'); this.open = false; this.getList() }) } else { addFacilities(this.form).then(() => { this.$modal.msgSuccess('新增成功'); this.open = false; this.getList() }) } } }) },
    cancel() { this.open = false; this.resetForm && this.resetForm('form') }
  }
}
</script>

<style lang="scss" scoped>
.app-container { padding: 20px; }
</style>