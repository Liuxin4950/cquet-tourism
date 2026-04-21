<template>
  <div class="app-container tourism-page">
    <el-form
      :model="queryParams"
      ref="queryForm"
      size="small"
      :inline="true"
      v-show="showSearch"
    >
      <el-form-item label="新闻标题" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入新闻标题"
          clearable
          style="width: 240px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="创建时间">
        <el-date-picker
          v-model="dateRange"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button
          type="primary"
          icon="el-icon-search"
          size="mini"
          @click="handleQuery"
          >搜索</el-button
        >
        <el-button icon="el-icon-refresh" size="mini" @click="resetButton"
          >重置</el-button
        >
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['tourism:news:add']"
          >新增</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['tourism:news:edit']"
          >修改</el-button
        >
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['tourism:news:remove']"
          >删除</el-button
        >
      </el-col>
      <right-toolbar
        :showSearch.sync="showSearch"
        @queryTable="getList"
      ></right-toolbar>
    </el-row>

    <el-table
      v-loading="loading"
      class="tourism-data-table"
      border
      stripe
      fit
      highlight-current-row
      :data="newsList"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="60" align="center" />
      <el-table-column label="编号" prop="id" width="110" />
      <el-table-column
        label="标题"
        prop="title"
        :show-overflow-tooltip="true"
        min-width="260"
      />
      <el-table-column
        label="作者"
        prop="author"
        :show-overflow-tooltip="true"
        min-width="120"
      />
      <el-table-column
        label="创建时间"
        align="center"
        prop="createTime"
        width="180"
      >
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="操作"
        align="center"
        class-name="small-padding fixed-width"
        width="220"
      >
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-document"
            @click="viewDetail(scope.row)"
            v-hasPermi="['tourism:news:query']"
            >详情</el-button
          >
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['tourism:news:edit']"
            >修改</el-button
          >
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['tourism:news:remove']"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页组件 -->
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改角色配置对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body custom-class="tourism-form-dialog">
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="新闻标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入新闻标题" />
        </el-form-item>
        <el-form-item label="作者" prop="author">
          <el-input v-model="form.author" placeholder="请输入作者" />
        </el-form-item>
        <el-form-item label="新闻内容" prop="content">
          <editor v-model="form.content" :height="300" placeholder="请输入新闻内容" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog title="新闻详情" :visible.sync="detailOpen" width="1000px" append-to-body custom-class="tourism-detail-dialog">
      <el-descriptions :border="true" :column="4" size="small">
        <el-descriptions-item label="标题">{{ detail.title }}</el-descriptions-item>
        <el-descriptions-item label="作者">{{ detail.author }}</el-descriptions-item>
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
import {
  listNews,
  getNews,
  addNews,
  updateNews,
  delNews,
} from "@/api/tourism/news";
// 引入分页组件
import Pagination from "@/components/Pagination";
import Editor from "@/components/Editor";

export default {
  name: "TourismNews",
  // 注册分页组件
  components: {
    Pagination,
    Editor,
  },
  data() {
    return {
      // 数据列表
      newsList: [],
      // 总条数
      total: 0,
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 选中的id数组
      ids: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        startDate: undefined,
        endDate: undefined,
        title: undefined,
        status: undefined,
      },
      // 日期范围
      dateRange: [],
      showSearch: true,
      // 表格加载状态
      loading: false,
      // 新增修改对话框的标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 表单数据
      form: {
      },
      detailOpen: false,
      detail: {},
      // 新增或修改表单的数据校验规则
      rules: {
        title: [
          { required: true, message: "标题不能为空", trigger: "blur" },
        ],
        author: [
          { required: true, message: "作者不能为空", trigger: "blur" },
        ],
      }
    };
  },
  // 组件创建时加载数据
  created() {
    // 组件创建时加载数据
    this.getList();
  },
  methods: {
    // 处理查询
    handleQuery() {
      this.getList();
    },
    // 获取数据列表
    getList() {
      this.loading = true;
      const s = this.dateRange && this.dateRange[0] ? (this.dateRange[0] + ' 00:00:00') : undefined;
      const e = this.dateRange && this.dateRange[1] ? (this.dateRange[1] + ' 23:59:59') : undefined;
      this.queryParams.startDate = s;
      this.queryParams.endDate = e;
      this.queryParams.startTime = s;
      this.queryParams.endTime = e;
      listNews(this.queryParams).then((response) => {
        this.loading = false;
        this.newsList = response.rows;
        this.total = response.total;
      });
    },

    // 重置查询条件
    resetQuery() {
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        title: undefined,
        status: undefined,
        startDate: undefined,
        endDate: undefined,
        startTime: undefined,
        endTime: undefined,
      };
      this.getList();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map((item) => item.id);
      this.single = selection.length != 1;
      this.multiple = !selection.length;
    },
    // 重置按钮操作
    resetButton() {
      this.dateRange = [];
      this.resetForm("queryForm");
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        startDate: undefined,
        endDate: undefined,
        title: undefined,
        status: undefined,
      };
      this.getList();
    },
    // 修改方法
    handleUpdate(row) {
      this.reset();
      const newsId = row.id || this.ids[0];
      getNews(newsId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改新闻动态";
      });
    },
    /** 重置新增或修改的表单 */
    reset() {
      this.form = {
        id: undefined,
        title: undefined,
        author: undefined,
        content: undefined,
        remark: undefined,
      };
      this.resetForm("form");
    },
    // 新增方法
    handleAdd() {
      this.open = true;
      this.title = "新增新闻动态";
      // 重置表单数据
      this.reset();
    },
    // 删除方法
    handleDelete(row) {
      const newsIds = row.id || this.ids;
      this.$modal.confirm('是否确认删除新闻编号为"' + newsIds + '"的数据项？').then(function() {
        return delNews(newsIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {
        this.$modal.msgError("删除失败");
      });
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateNews(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
            });
          } else {
            console.log(this.form);
            addNews(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
            });
          }
          this.open = false;
          this.getList();
        }
      })
    },
    viewDetail(row) {
      getNews(row.id).then(res => { this.detail = res.data || {}; this.detailOpen = true })
    },
    /** 取消按钮 */
    cancel: function() {
      this.open = false;
      this.resetForm("form");
    },
  },
};
</script>

<style lang="scss" scoped>
.app-container {
  padding: 20px;

  .news-content {
    margin-top: 10px;
  }
}
.detail-article { padding: 12px 0; line-height: 1.8; }
</style>
