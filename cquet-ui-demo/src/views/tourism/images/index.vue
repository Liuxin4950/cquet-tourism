<template>
  <div class="app-container tourism-page">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="文件名" prop="fileName">
        <el-input v-model="queryParams.fileName" placeholder="请输入文件名" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="图片URL" prop="url">
        <el-input v-model="queryParams.url" placeholder="请输入图片URL" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['tourism:image:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['tourism:image:remove']">删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>

    <el-table
      v-loading="loading"
      class="tourism-data-table"
      :data="imageList"
      @selection-change="handleSelectionChange"
      border
      stripe
      fit
      size="small"
      highlight-current-row
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" prop="id" width="90" align="center" />
      <el-table-column label="图片预览" width="120" align="center">
        <template slot-scope="scope">
          <el-image
            v-if="scope.row.url"
            :src="imageUrl(scope.row.url)"
            :preview-src-list="[imageUrl(scope.row.url)]"
            fit="cover"
            style="width: 80px; height: 60px"
          />
          <span v-else>无图片</span>
        </template>
      </el-table-column>
      <el-table-column label="文件名" min-width="220" :show-overflow-tooltip="true">
        <template slot-scope="scope">
          <span>{{ scope.row.originalName || scope.row.fileName || '暂无...' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="类型" prop="fileExt" width="90" align="center">
        <template slot-scope="scope">
          <span>{{ scope.row.fileExt || '暂无...' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="大小" prop="fileSize" width="100" align="center">
        <template slot-scope="scope">
          <span>{{ formatFileSize(scope.row.fileSize) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="存储" prop="storageType" width="100" align="center">
        <template slot-scope="scope">
          <el-tag size="mini" type="info">{{ scope.row.storageType || 'local' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="图片URL" prop="url" min-width="300" :show-overflow-tooltip="true">
        <template slot-scope="scope">
          <a :href="imageUrl(scope.row.url)" target="_blank" style="color: #409eff">{{ scope.row.url }}</a>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" prop="createTime" width="180" align="center">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="160">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['tourism:image:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <!-- 新增图片对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body custom-class="tourism-form-dialog">
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="图片URL" prop="url">
          <el-input v-model="form.url" placeholder="请输入图片URL" />
        </el-form-item>
        <el-form-item label="图片预览" v-if="form.url">
          <el-image
            :src="imageUrl(form.url)"
            fit="cover"
            style="width: 200px; height: 150px"
          />
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
import { listImages, addImage, delImage } from '@/api/tourism/images'
import Pagination from '@/components/Pagination'

export default {
  name: 'TourismImages',
  components: { Pagination },
  data() {
    return {
      imageList: [],
      total: 0,
      single: true,
      multiple: true,
      ids: [],
      queryParams: { pageNum: 1, pageSize: 10, fileName: undefined, url: undefined },
      showSearch: true,
      loading: false,
      title: '',
      open: false,
      form: {},
      rules: {
        url: [{ required: true, message: '图片URL不能为空', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    handleQuery() { this.getList() },
    getList() {
      this.loading = true
      listImages(this.queryParams).then(response => {
        this.loading = false
        this.imageList = response.rows || []
        this.total = response.total || 0
      })
    },
    resetQuery() {
      this.queryParams = { pageNum: 1, pageSize: 10, fileName: undefined, url: undefined }
      this.getList()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length != 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = '新增图片'
    },
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除图片编号为"' + ids + '"的数据项？').then(function () {
        return delImage(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess('删除成功')
      }).catch(() => { })
    },
    reset() {
      this.form = { id: undefined, url: undefined }
      this.resetForm && this.resetForm('form')
    },
    cancel() {
      this.open = false
      this.reset()
    },
    submitForm() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          addImage(this.form).then(() => {
            this.$modal.msgSuccess('新增成功')
            this.open = false
            this.getList()
          })
        }
      })
    },
    imageUrl(url) {
      const base = process.env.VUE_APP_BASE_API || ''
      if (!url) return ''
      return url.indexOf('http') === 0 ? url : base + url
    },
    formatFileSize(size) {
      const value = Number(size)
      if (!value) return '暂无...'
      if (value < 1024) return value + 'B'
      if (value < 1024 * 1024) return (value / 1024).toFixed(1) + 'KB'
      return (value / 1024 / 1024).toFixed(1) + 'MB'
    }
  }
}
</script>

<style scoped>
.app-container {
  padding: 20px;
}
</style>
