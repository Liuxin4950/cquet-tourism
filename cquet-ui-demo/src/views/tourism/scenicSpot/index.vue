<template>
  <div class="app-container">
    <el-form
      :model="queryParams"
      ref="queryForm"
      size="small"
      :inline="true"
      v-show="showSearch"
    >
      <el-form-item label="景区名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入景区名称"
          clearable
          style="width: 240px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="景区等级" prop="level">
        <el-select
          v-model="queryParams.level"
          placeholder="景区等级"
          clearable
          style="width: 240px"
        >
          <el-option label="A级" value="A" />
          <el-option label="AA级" value="AA" />
          <el-option label="AAA级" value="AAA" />
          <el-option label="AAAA级" value="AAAA" />
          <el-option label="AAAAA级" value="AAAAA" />
        </el-select>
      </el-form-item>
      <el-form-item label="所在城市" prop="city">
        <el-input
          v-model="queryParams.city"
          placeholder="请输入所在城市"
          clearable
          style="width: 240px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          v-model="queryParams.status"
          placeholder="景区状态"
          clearable
          style="width: 240px"
        >
          <el-option label="正常" value="0" />
          <el-option label="停用" value="1" />
        </el-select>
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
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery"
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
          v-hasPermi="['tourism:scenicSpot:add']"
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
          v-hasPermi="['tourism:scenicSpot:edit']"
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
          v-hasPermi="['tourism:scenicSpot:remove']"
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
      :data="scenicSpotList"
      @selection-change="handleSelectionChange"
      @sort-change="handleSortChange"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" prop="id" width="120" sortable="custom" />
      <el-table-column
        label="景区名称"
        prop="name"
        :show-overflow-tooltip="true"
        width="150"
      />
      <el-table-column
        label="景区等级"
        prop="level"
        width="80"
        align="center"
      />
      <el-table-column
        label="所在城市"
        prop="city"
        width="100"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="门票价格"
        prop="ticketPrice"
        width="100"
        align="center"
      >
        <template slot-scope="scope">
          <span>¥{{ scope.row.ticketPrice }}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="联系电话"
        prop="contactPhone"
        width="120"
        :show-overflow-tooltip="true"
      />
      <el-table-column
        label="封面"
        width="90"
        align="center"
      >
        <template slot-scope="scope">
          <el-image
            v-if="scope.row.coverImage"
            :src="imageUrl(scope.row.coverImage)"
            :preview-src-list="[imageUrl(scope.row.coverImage)]"
            style="width: 48px; height: 48px; border-radius: 4px"
            fit="cover"
          />
        </template>
      </el-table-column>
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
      >
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-office-building"
            @click="viewVenues(scope.row)"
            v-hasPermi="['tourism:scenic-spot:venue:list']"
            >查看场馆</el-button
          >
          <el-button
            size="mini"
            type="text"
            icon="el-icon-document"
            @click="viewScenicDetail(scope.row)"
            v-hasPermi="['tourism:scenic-spot:query']"
            >详情</el-button>

          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['tourism:scenicSpot:edit']"
            >修改</el-button
          >
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['tourism:scenicSpot:remove']"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页组件 -->
    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改景区配置对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="景区名称" prop="name">
              <el-input v-model="form.name" placeholder="请输入景区名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="景区等级" prop="level">
              <el-select
                v-model="form.level"
                placeholder="请选择景区等级"
                style="width: 100%"
              >
                <el-option label="A级" value="A" />
                <el-option label="AA级" value="AA" />
                <el-option label="AAA级" value="AAA" />
                <el-option label="AAAA级" value="AAAA" />
                <el-option label="AAAAA级" value="AAAAA" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="门票价格" prop="ticketPrice">
              <el-input-number
                v-model="form.ticketPrice"
                :min="0"
                :precision="2"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="contactPhone">
              <el-input
                v-model="form.contactPhone"
                placeholder="请输入联系电话"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="所在城市" prop="city">
              <el-input v-model="form.city" placeholder="请输入所在城市" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="所在区县" prop="district">
              <el-input v-model="form.district" placeholder="请输入所在区县" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="开放时间" prop="openingHours">
              <el-input
                v-model="form.openingHours"
                placeholder="请输入开放时间"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="官方网站" prop="website">
              <el-input v-model="form.website" placeholder="请输入官方网站" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="景区地址" prop="address">
              <el-input v-model="form.address" placeholder="请输入景区地址" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="景区介绍" prop="description">
              <el-input
                v-model="form.description"
                type="textarea"
                :rows="4"
                placeholder="请输入景区介绍"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="封面图片" prop="coverImage">
              <image-upload v-model="form.coverImage" :limit="1" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="内容图片">
              <image-upload v-model="form.imageUrls" :limit="9" />

              
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="经度" prop="longitude">
              <el-input-number
                v-model="form.longitude"
                :precision="7"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="纬度" prop="latitude">
              <el-input-number
                v-model="form.latitude"
                :precision="7"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="备注">
              <el-input
                v-model="form.remark"
                type="textarea"
                placeholder="请输入内容"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog title="关联场馆" :visible.sync="venueOpen" width="1000px" append-to-body>
      <el-table :data="venueList">
        <el-table-column label="封面" width="90" align="center">
          <template slot-scope="scope">
            <el-image
              v-if="scope.row.coverImage"
              :src="imageUrl(scope.row.coverImage)"
              :preview-src-list="[imageUrl(scope.row.coverImage)]"
              style="width: 48px; height: 48px; border-radius: 4px"
              fit="cover"
            />
          </template>
        </el-table-column>
        <el-table-column label="场馆名称" prop="name" min-width="180" :show-overflow-tooltip="true" />
        <el-table-column label="城市" prop="city" width="140" />
        <el-table-column label="类别" prop="category" width="120" />
        <el-table-column label="票价" prop="ticketPrice" width="120" align="center">
          <template slot-scope="scope"><span>¥{{ scope.row.ticketPrice }}</span></template>
        </el-table-column>
        <el-table-column label="操作" width="120" align="center">
          <template slot-scope="scope">
            <el-button type="text" size="mini" icon="el-icon-view" @click="viewVenueDetail(scope.row)">查看详情</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button @click="venueOpen = false">关 闭</el-button>
      </div>
    </el-dialog>

    <el-dialog title="场馆图片" :visible.sync="venueImagesOpen" width="900px" append-to-body>
      <div style="display:flex; flex-wrap: wrap; gap: 8px">
        <el-image
          v-for="(img, idx) in venueImagesList"
          :key="idx"
          :src="imageUrl(img.url)"
          :preview-src-list="venueImagesPreview"
          style="width: 120px; height: 90px; border-radius: 4px"
          fit="cover"
        />
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="venueImagesOpen = false">关 闭</el-button>
      </div>
    </el-dialog>

    <el-dialog title="场馆详情" :visible.sync="venueDetailOpen" width="1000px" append-to-body>
      <el-row :gutter="16">
        <el-col :span="8">
          <el-image
            v-if="venueDetail.coverImage"
            :src="imageUrl(venueDetail.coverImage)"
            :preview-src-list="[imageUrl(venueDetail.coverImage)]"
            style="width: 100%; height: 200px; border-radius: 4px"
            fit="cover"
          />
        </el-col>
        <el-col :span="16">
          <el-descriptions :column="2" size="small" border>
            <el-descriptions-item label="名称">{{ venueDetail.name }}</el-descriptions-item>
            <el-descriptions-item label="类别">{{ venueDetail.category }}</el-descriptions-item>
            <el-descriptions-item label="城市">{{ venueDetail.city }}</el-descriptions-item>
            <el-descriptions-item label="区县">{{ venueDetail.district }}</el-descriptions-item>
            <el-descriptions-item label="票价">¥{{ venueDetail.ticketPrice }}</el-descriptions-item>
            <el-descriptions-item label="电话">{{ venueDetail.contactPhone }}</el-descriptions-item>
            <el-descriptions-item label="开放时间">{{ venueDetail.openingHours }}</el-descriptions-item>
            <el-descriptions-item label="官网">{{ venueDetail.website }}</el-descriptions-item>
            <el-descriptions-item label="地址" :span="2">{{ venueDetail.address }}</el-descriptions-item>
          </el-descriptions>
        </el-col>
      </el-row>
      <div style="margin-top: 12px; font-weight: 600">内容图片</div>
      <div style="display:flex; flex-wrap: wrap; gap: 8px">
        <el-image
          v-for="(img, idx) in (venueDetail.images || [])"
          :key="idx"
          :src="imageUrl(img.url)"
          :preview-src-list="venueDetailImagesPreview"
          style="width: 120px; height: 90px; border-radius: 4px"
          fit="cover"
        />
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="venueDetailOpen = false">关 闭</el-button>
      </div>
    </el-dialog>

    <el-dialog title="景区详情" :visible.sync="scenicDetailOpen" width="1000px" append-to-body>
      <el-row :gutter="16">
        <el-col :span="8">
          <el-image
            v-if="scenicDetail.coverImage"
            :src="imageUrl(scenicDetail.coverImage)"
            :preview-src-list="[imageUrl(scenicDetail.coverImage)]"
            style="width: 100%; height: 200px; border-radius: 4px"
            fit="cover"
          />
        </el-col>
        <el-col :span="16">
          <el-descriptions :column="2" size="small" border>
            <el-descriptions-item label="名称">{{ scenicDetail.name }}</el-descriptions-item>
            <el-descriptions-item label="等级">{{ scenicDetail.level }}</el-descriptions-item>
            <el-descriptions-item label="城市">{{ scenicDetail.city }}</el-descriptions-item>
            <el-descriptions-item label="区县">{{ scenicDetail.district }}</el-descriptions-item>
            <el-descriptions-item label="票价">¥{{ scenicDetail.ticketPrice }}</el-descriptions-item>
            <el-descriptions-item label="电话">{{ scenicDetail.contactPhone }}</el-descriptions-item>
            <el-descriptions-item label="开放时间">{{ scenicDetail.openingHours }}</el-descriptions-item>
            <el-descriptions-item label="官网">{{ scenicDetail.website }}</el-descriptions-item>
            <el-descriptions-item label="地址" :span="2">{{ scenicDetail.address }}</el-descriptions-item>
            <el-descriptions-item label="景区介绍" :span="2">{{ scenicDetail.description }}</el-descriptions-item>
          </el-descriptions>
        </el-col>
      </el-row>
      <div style="margin-top: 12px; font-weight: 600">内容图片</div>
      <div style="display:flex; flex-wrap: wrap; gap: 8px">
        <el-image
          v-for="(img, idx) in (scenicDetail.images || [])"
          :key="idx"
          :src="imageUrl(img.url)"
          :preview-src-list="scenicDetailImagesPreview"
          style="width: 120px; height: 90px; border-radius: 4px"
          fit="cover"
        />
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="scenicDetailOpen = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
// TODO: 需要创建对应的API文件
import {
  listScenicSpot,
  getScenicSpot,
  addScenicSpot,
  updateScenicSpot,
  delScenicSpot,
} from "@/api/tourism/scenicSpot";
import ImageUpload from "@/components/ImageUpload";

// 引入分页组件
import Pagination from "@/components/Pagination";
import { listScenicSpotVenues } from "@/api/tourism/scenicSpot";

export default {
  name: "TourismScenicSpot",
  // 注册分页组件
  components: {
    Pagination,
    ImageUpload,
  },
  data() {
    return {
      // 数据列表
      scenicSpotList: [],
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
        startTime: undefined,
        endTime: undefined,
        name: undefined,
        level: undefined,
        city: undefined,
        status: undefined,
        orderByColumn: "id",
        isAsc: "asc",
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
        coverImage: undefined,
        imageUrls: [],
      },
      venueOpen: false,
      venueList: [],
      venueImagesOpen: false,
      venueImagesList: [],
      venueImagesPreview: [],
      venueDetailOpen: false,
      venueDetail: {},
      venueDetailImagesPreview: [],
      scenicDetailOpen: false,
      scenicDetail: {},
      scenicDetailImagesPreview: [],
      // 新增或修改表单的数据校验规则
      rules: {
        name: [
          { required: true, message: "景区名称不能为空", trigger: "blur" },
        ],
        level: [
          { required: true, message: "景区等级不能为空", trigger: "change" },
        ],
        ticketPrice: [
          { required: true, message: "门票价格不能为空", trigger: "blur" },
        ],
        city: [
          { required: true, message: "所在城市不能为空", trigger: "blur" },
        ],
        address: [
          { required: true, message: "景区地址不能为空", trigger: "blur" },
        ],
        // TODO(多表查询改造后恢复)：暂时注释封面图片校验规则
        // coverImage: [
        //   { required: true, message: "封面图片不能为空", trigger: "blur" },
        // ],
      },
    };
  },
  // 组件创建时加载数据
  created() {
    // 组件创建时加载数据
    this.getList();
    console.log(process.env.VUE_APP_BASE_API);
  },
  methods: {
    // 处理查询
    handleQuery() {
      this.getList();
    },
    // 获取数据列表
    getList() {
      this.loading = true;
      this.queryParams.startTime = this.dateRange[0];
      this.queryParams.endTime = this.dateRange[1];

      // TODO: 替换为实际的API调用
      // 临时模拟数据
      listScenicSpot(this.queryParams)
        .then((res) => {
          const rows = (res && res.rows) || (res && res.data && res.data.rows) || [];
          const total = (res && res.total) || (res && res.data && res.data.total) || 0;
          this.scenicSpotList = rows;
          this.total = total;
        })
        .catch(() => { this.loading = false; })
        .finally(() => { this.loading = false; });

      // 实际的API调用应该是：
      // listScenicSpot(this.queryParams).then((response) => {
      //   this.loading = false;
      //   this.scenicSpotList = response.rows;
      //   this.total = response.total;
      // });
    },
    viewVenues(row) {
      const id = row.id;
      listScenicSpotVenues(id).then((response) => {
        this.venueList = Array.isArray(response.data) ? response.data : [];
        this.venueOpen = true;
      });
    },
    viewVenueImages(row) {
      import('@/api/tourism/scenicVenue').then((m) => {
        m.listVenueImages(row.id).then((response) => {
          this.venueImagesList = Array.isArray(response.data) ? response.data : [];
          const base = process.env.VUE_APP_BASE_API || '';
          this.venueImagesPreview = this.venueImagesList.map(it => {
            const u = it && it.url ? it.url : '';
            return u.indexOf('http') === 0 ? u : base + u;
          });
          this.venueImagesOpen = true;
        });
      });
    },
    viewVenueDetail(row) {
      import('@/api/tourism/scenicVenue').then((m) => {
        m.getScenicVenue(row.id).then((response) => {
          this.venueDetail = response && response.data ? response.data : {};
          const base = process.env.VUE_APP_BASE_API || '';
          const imgs = Array.isArray(this.venueDetail.images) ? this.venueDetail.images : [];
          this.venueDetailImagesPreview = imgs.map(it => {
            const u = it && it.url ? it.url : '';
            return u.indexOf('http') === 0 ? u : base + u;
          });
          this.venueDetailOpen = true;
        });
      });
    },
    viewScenicDetail(row) {
      getScenicSpot(row.id).then((response) => {
        this.scenicDetail = response && response.data ? response.data : {};
        const base = process.env.VUE_APP_BASE_API || '';
        const imgs = Array.isArray(this.scenicDetail.images) ? this.scenicDetail.images : [];
        this.scenicDetailImagesPreview = imgs.map(it => {
          const u = it && it.url ? it.url : '';
          return u.indexOf('http') === 0 ? u : base + u;
        });
        this.scenicDetailOpen = true;
      });
    },

    // 重置查询条件
    resetQuery() {
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        name: undefined,
        level: undefined,
        city: undefined,
        status: undefined,
        orderByColumn: "id",
        isAsc: "asc",
      };
      this.getList();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map((item) => item.id);
      this.single = selection.length != 1;
      this.multiple = !selection.length;
    },
    /** 排序触发事件 */
    handleSortChange(column, prop, order) {
      this.queryParams.orderByColumn = column.prop;
      this.queryParams.isAsc = column.order === "ascending" ? "asc" : "desc";
      this.getList();
    },
    // 重置按钮操作
    resetButton() {
      this.dateRange = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 修改方法
    handleUpdate(row) {
      this.reset();
      const scenicSpotId = row.id || this.ids[0];
      getScenicSpot(scenicSpotId).then((response) => {
        this.form = response.data;
        // 加载已关联图片
        import('@/api/tourism/scenicSpot').then((m) => {
          m.listScenicSpotImages(scenicSpotId).then((r) => {
            const arr = Array.isArray(r.data) ? r.data : [];
            const urls = arr.map((it) => it.url || it.imageUrl || '').filter(Boolean);
            this.$set(this.form, 'imageUrls', urls);
            console.log("this.form.imageUrls:", this.form.imageUrls);
          });
        });
        // TODO(多表查询改造后恢复)：暂时注释内容图片字段解析逻辑
        // if (this.form.imageUrls) {
        //   try {
        //     const imageUrlsArray = JSON.parse(this.form.imageUrls);
        //     if (Array.isArray(imageUrlsArray)) {
        //       this.form.imageUrls = imageUrlsArray.join(",");
        //     } else {
        //       this.form.imageUrls = "";
        //     }
        //   } catch (e) {
        //     console.error("Failed to parse imageUrls:", this.form.imageUrls, e);
        //     this.form.imageUrls = "";
        //   }
        // }
        this.open = true;
        this.title = "修改景区信息";
      });
    },
    /** 重置新增或修改的表单 */
    reset() {
      this.form = {
        id: undefined,
        name: undefined,
        level: undefined,
        coverImage: undefined,
        imageUrls: [],
        ticketPrice: 0,
        address: undefined,
        city: undefined,
        district: undefined,
        openingHours: undefined,
        contactPhone: undefined,
        website: undefined,
        description: undefined,
        longitude: undefined,
        latitude: undefined,
        remark: undefined,
      };
      this.resetForm("form");
    },
    // 新增方法
    handleAdd() {
      this.open = true;
      this.title = "新增景区信息";
      // 重置表单数据
      this.reset();
    },
    // 删除方法
    handleDelete(row) {
      const scenicSpotIds = row.id || this.ids;
      this.$modal
        .confirm('是否确认删除景区编号为"' + scenicSpotIds + '"的数据项？')
        .then(function () {
          // TODO: 替换为实际的API调用
          return delScenicSpot(scenicSpotIds);
        })
        .then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        })
        .catch(() => {
          this.$modal.msgError("删除失败");
        });
    },
    /** 提交按钮 */
    submitForm: function () {
      this.$refs["form"].validate((valid) => {
        if (valid) {
          const formData = { ...this.form };
          if (formData.id != undefined) {
            updateScenicSpot(formData).then((response) => {
              // 同步图片关联
              import('@/api/tourism/uploadPictures').then((u) => {
                const urls = Array.isArray(this.form.imageUrls)
                  ? this.form.imageUrls
                  : (typeof this.form.imageUrls === 'string' && this.form.imageUrls
                      ? this.form.imageUrls.split(',').filter(Boolean)
                      : []);
                u.batchUploadImageUrls(urls).then((res) => {
                  const imageIds = (res.data || res.rows || []).map((it) => it.id);
                  import('@/api/tourism/scenicSpot').then((m) => {
                    m.setScenicSpotImages(this.form.id, imageIds).then(() => {
                      this.$modal.msgSuccess('修改成功');
                      this.open = false;
                      this.getList();
                    });
                  });
                });
              });
            });
          } else {
            addScenicSpot(formData).then((response) => {
              const sid = (response && response.data && response.data.id) ? response.data.id : formData.id;
              import('@/api/tourism/uploadPictures').then((u) => {
                const urls = Array.isArray(this.form.imageUrls)
                  ? this.form.imageUrls
                  : (typeof this.form.imageUrls === 'string' && this.form.imageUrls
                      ? this.form.imageUrls.split(',').filter(Boolean)
                      : []);
                u.batchUploadImageUrls(urls).then((res) => {
                  const imageIds = (res.data || res.rows || []).map((it) => it.id);
                  import('@/api/tourism/scenicSpot').then((m) => {
                    m.setScenicSpotImages(sid, imageIds).then(() => {
                      this.$modal.msgSuccess('新增成功');
                      this.open = false;
                      this.getList();
                    });
                  });
                });
              });
            });
          }
        }
      });
    },
    // 使用 ImageUpload 组件，无需手动增删 URL
    /** 取消按钮 */
    cancel: function () {
      this.open = false;
      this.resetForm("form");
    },
    imageUrl(u) {
      const base = process.env.VUE_APP_BASE_API || '';
      if (!u) return '';
      return u.indexOf('http') === 0 ? u : base + u;
    }
  },
};
</script>

<style lang="scss" scoped>
.app-container {
  padding: 20px;

  .scenic-spot-info {
    margin-top: 10px;
  }
}

.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 148px;
  height: 148px;
  line-height: 148px;
  text-align: center;
}
.avatar {
  width: 148px;
  height: 148px;
  display: block;
}
.content-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
</style>