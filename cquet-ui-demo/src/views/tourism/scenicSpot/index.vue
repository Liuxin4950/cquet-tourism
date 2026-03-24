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
      <el-table-column label="编号" prop="id" width="90" sortable="custom" />
      <el-table-column
        label="景区名称"
        prop="name"
        :show-overflow-tooltip="true"
        min-width="180"
        :formatter="formatText"
      />
      <el-table-column
        label="景区等级"
        prop="level"
        width="100"
        align="center"
        :formatter="formatText"
      />
      <el-table-column
        label="所在城市"
        prop="city"
        width="120"
        :show-overflow-tooltip="true"
        :formatter="formatText"
      />
      <el-table-column
        label="门票价格"
        prop="ticketPrice"
        width="110"
        align="center"
      >
        <template slot-scope="scope">
          <span>{{ Number(scope.row.ticketPrice) === 0 ? '免费' : (scope.row.ticketPrice != null ? ('¥' + scope.row.ticketPrice) : '暂无...') }}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="联系电话"
        prop="contactPhone"
        width="140"
        :show-overflow-tooltip="true"
        :formatter="formatText"
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
          <span v-else>暂无</span>
        </template>
      </el-table-column>
      <el-table-column
        label="创建时间"
        align="center"
        prop="createTime"
        width="170"
      >
        <template slot-scope="scope">
          <span>{{ scope.row.createTime ? parseTime(scope.row.createTime) : '暂无' }}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="操作"
        align="center"
        class-name="small-padding fixed-width"
        fixed="right"
        width="220"
      >
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-document"
            @click="viewScenicDetail(scope.row)"
            v-hasPermi="['tourism:scenicSpot:query']"
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
    <el-dialog :title="title" :visible.sync="open" width="900px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <!-- 基本信息区块 -->
        <div class="form-section">
          <div class="section-title"><i class="el-icon-info"></i> 基本信息</div>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="景区名称" prop="name">
                <el-input v-model="form.name" placeholder="请输入景区名称" clearable />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="景区等级" prop="level">
                <el-select v-model="form.level" placeholder="请选择景区等级" style="width: 100%" clearable>
                  <el-option label="A级" value="A" />
                  <el-option label="AA级" value="AA" />
                  <el-option label="AAA级" value="AAA" />
                  <el-option label="AAAA级" value="AAAA" />
                  <el-option label="AAAAA级" value="AAAAA" />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="8">
              <el-form-item label="票务">
                <el-radio-group v-model="form.feeType" @change="onFeeTypeChange" size="small">
                  <el-radio-button label="free">免费</el-radio-button>
                  <el-radio-button label="paid">收费</el-radio-button>
                </el-radio-group>
              </el-form-item>
            </el-col>
            <el-col :span="8" v-if="form.feeType === 'paid'">
              <el-form-item label="门票价格">
                <el-input-number v-model="form.ticketPrice" :min="0" :precision="2" controls-position="right" style="width: 100%" />
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-form-item label="联系电话">
                <el-input v-model="form.contactPhone" placeholder="请输入联系电话" clearable />
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 位置信息区块 -->
        <div class="form-section">
          <div class="section-title"><i class="el-icon-location"></i> 位置信息</div>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="所在地区">
                <el-cascader
                  :options="areaOptions"
                  v-model="areaValue"
                  :props="{ checkStrictly: true }"
                  clearable
                  style="width: 100%"
                  @change="onAreaChange"
                  placeholder="请选择省市区"
                />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="详细地址">
                <el-input v-model="form.address" placeholder="详细地址（地图选点后自动填充）" clearable />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="24">
              <el-form-item label="地图定位">
                <div class="location-picker-row">
                  <el-tag v-if="form.longitude && form.latitude" type="success" effect="plain" closable @close="onLocationClear" style="margin-right: 10px;">
                    <i class="el-icon-check"></i> 已定位
                  </el-tag>
                  <el-button type="primary" size="small" @click="openMapPicker">
                    <i class="el-icon-location"></i> {{ form.longitude && form.latitude ? '重新选择位置' : '在地图上选择位置' }}
                  </el-button>
                  <span v-if="form.longitude && form.latitude" class="coord-display">
                    ({{ form.longitude }}, {{ form.latitude }})
                  </span>
                </div>
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 其他信息区块 -->
        <div class="form-section">
          <div class="section-title"><i class="el-icon-more"></i> 其他信息</div>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="开放时间">
                <el-select v-model="form.openingHours" placeholder="请选择开放时间" clearable style="width: 100%">
                  <el-option v-for="opt in openingHoursOptions" :key="opt" :label="opt" :value="opt" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="官方网站">
                <el-input v-model="form.website" placeholder="请输入官方网站" clearable />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="24">
              <el-form-item label="景区介绍">
                <el-input v-model="form.description" type="textarea" :rows="3" placeholder="请输入景区介绍" />
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 图片区块 -->
        <div class="form-section">
          <div class="section-title"><i class="el-icon-picture"></i> 图片资料</div>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="封面图片">
                <image-upload v-model="form.coverImage" :limit="1" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="内容图片">
                <image-upload v-model="form.imageUrls" :limit="9" />
              </el-form-item>
            </el-col>
          </el-row>
        </div>

        <!-- 备注区块 -->
        <div class="form-section">
          <el-form-item label="备注">
            <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注信息" />
          </el-form-item>
        </div>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 地图位置选择对话框 -->
    <el-dialog
      title="在地图上选择位置"
      :visible.sync="mapPickerVisible"
      width="1000px"
      top="5vh"
      append-to-body
      :close-on-click-modal="false"
    >
      <map-location-picker
        v-if="mapPickerVisible"
        :longitude="form.longitude"
        :latitude="form.latitude"
        @update:longitude="form.longitude = $event"
        @update:latitude="form.latitude = $event"
        @select="onLocationSelect"
        @clear="onLocationClear"
      />
      <div v-else class="map-loading">正在加载地图...</div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="mapPickerVisible = false">确 定</el-button>
        <el-button @click="mapPickerVisible = false">取 消</el-button>
      </div>
    </el-dialog>


    <el-dialog title="景区详情" :visible.sync="scenicDetailOpen" width="1000px" append-to-body>
      <div class="detail-module">
        <div class="main-img-wrapper">
          <el-image
            v-if="scenicDetail.coverImage"
            :src="imageUrl(scenicDetail.coverImage)"
            :preview-src-list="[imageUrl(scenicDetail.coverImage)]"
            class="main-img"
            fit="cover"
          />
          <div v-else class="empty-tip">暂无图片</div>
        </div>
      </div>

      <div class="detail-card">
        <div class="detail-row">
          <div class="detail-item">
            <div class="label">名称</div>
            <div class="value">{{ scenicDetail.name || '暂无' }}</div>
          </div>
          <div class="detail-item">
            <div class="label">等级</div>
            <div class="value">{{ scenicDetail.level || '暂无' }}</div>
          </div>
          <div class="detail-item">
            <div class="label">城市</div>
            <div class="value">{{ scenicDetail.city || '暂无' }}</div>
          </div>
          <div class="detail-item">
            <div class="label">区县</div>
            <div class="value">{{ scenicDetail.district || '暂无' }}</div>
          </div>
          <div class="detail-item">
            <div class="label">票价</div>
            <div class="value">{{ Number(scenicDetail.ticketPrice) === 0 ? '免费' : (scenicDetail.ticketPrice != null ? ('¥' + scenicDetail.ticketPrice) : '暂无') }}</div>
          </div>
          <div class="detail-item">
            <div class="label">电话</div>
            <div class="value">{{ scenicDetail.contactPhone || '暂无' }}</div>
          </div>
          <div class="detail-item">
            <div class="label">开放时间</div>
            <div class="value">{{ scenicDetail.openingHours || '暂无' }}</div>
          </div>
          <div class="detail-item">
            <div class="label">官网</div>
            <div class="value">{{ scenicDetail.website || '暂无' }}</div>
          </div>
        </div>
      </div>

      <div class="detail-card">
        <div class="detail-row single">
          <div class="detail-item">
            <div class="label">详细地址</div>
            <div class="value">{{ scenicDetail.address || '暂无' }}</div>
          </div>
          <div class="detail-item">
            <div class="label">景区介绍</div>
            <div class="value">{{ scenicDetail.description || '暂无' }}</div>
          </div>
        </div>
      </div>

      <div class="detail-card">
        <div class="content-img-group" v-if="scenicDetail.images && scenicDetail.images.length">
          <el-image
            v-for="(img, idx) in scenicDetail.images"
            :key="idx"
            :src="imageUrl(img.url)"
            class="content-img-item"
            fit="cover"
          />
        </div>
        <div v-else class="empty-tip">暂无图片</div>
      </div>

      <div slot="footer" class="dialog-footer">
        <el-button class="detail-close-btn" @click="scenicDetailOpen = false">关 闭</el-button>
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

// 引入地图位置选择组件
import MapLocationPicker from "@/components/MapLocationPicker";

export default {
  name: "TourismScenicSpot",
  // 注册分页组件
  components: {
    Pagination,
    ImageUpload,
    MapLocationPicker,
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
      areaOptions: [],
      areaValue: [],
      scenicDetailOpen: false,
      scenicDetail: {},
      scenicDetailImagesPreview: [],
      openingHoursOptions: ['全天','6:00-18:30','7:30-17:30','9:00-17:00','9:00-21:00','10:00-18:00'],
      // 地图选点对话框
      mapPickerVisible: false,
      // 新增或修改表单的数据校验规则
      rules: {
        name: [
          { required: true, message: "景区名称不能为空", trigger: "blur" },
        ],
        level: [
          { required: true, message: "景区等级不能为空", trigger: "change" },
        ],
        ticketPrice: [
          { validator: (rule, value, callback) => {
              const isPaid = this && this.form && this.form.feeType === 'paid'
              if (isPaid && (!value || Number(value) <= 0)) return callback(new Error('请填写有效票价'))
              callback()
            }, trigger: 'blur' }
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
    this.initAreaOptions();
  },
  methods: {
    formatText(row, column, cellValue) {
      return cellValue || '暂无';
    },
    // 打开地图选点对话框
    openMapPicker() {
      this.mapPickerVisible = true
    },
    // 位置选择完成 - 自动填充表单
    onLocationSelect(location) {
      // 自动填充详细地址
      if (location.address) {
        this.form.address = location.address
      }

      // 如果返回了区县信息，尝试设置级联选择器
      if (location.district) {
        this.form.district = location.district

        // 根据区县名称查找对应的级联选项
        // 由于级联选择器的值是完整的路径数组，这里需要特殊处理
        this.setAreaByDistrict(location.district)
      }

      // 如果返回了城市信息
      if (location.city) {
        this.form.city = location.city
      }

      this.$message.success('已选择位置: ' + location.address)
    },
    // 根据区县名称设置级联选择器的值
    setAreaByDistrict(districtName) {
      try {
        const provinces = this.areaOptions || []
        for (const p of provinces) {
          const pLabel = p.label || ''
          // 匹配重庆市（直辖市）
          if (pLabel.indexOf('重庆') !== -1 || p.value === '50') {
            const children = p.children || []
            for (const c of children) {
              const cChildren = c.children || []
              for (const d of cChildren) {
                const dLabel = d.label || ''
                // 匹配区县名称（去掉"区"或"县"后缀比较）
                if (dLabel === districtName ||
                    dLabel.replace('区', '').replace('县', '') === districtName.replace('区', '').replace('县', '')) {
                  // 设置完整的路径值 [省份码, 城市码, 区县码]
                  this.areaValue = [p.value, c.value, d.value]
                  return
                }
              }
              // 如果城市直接匹配（比如万州区等）
              const cityLabel = c.label || ''
              if (cityLabel === districtName ||
                  cityLabel.replace('区', '').replace('县', '') === districtName.replace('区', '').replace('县', '')) {
                this.areaValue = [p.value, c.value]
                return
              }
            }
          }
        }
      } catch (e) {
        console.warn('设置区县失败:', e)
      }
    },
    // 清除位置选择
    onLocationClear() {
      this.form.longitude = null
      this.form.latitude = null
    },
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
        this.$set(this.form, 'feeType', Number(this.form.ticketPrice || 0) > 0 ? 'paid' : 'free')
        this.setAreaValueFromForm(this.form.city, this.form.district)
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
        feeType: 'free',
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
      this.areaValue = [];
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
          if (formData.feeType === 'free') { formData.ticketPrice = 0 } else { if (!(Number(formData.ticketPrice) > 0)) { this.$modal.msgError('请填写有效票价'); return } }
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
    onFeeTypeChange(val) {
      if (val === 'free') this.form.ticketPrice = 0
    },
    setAreaValueFromForm(cityStr, districtLabel) {
      try {
        const provinces = this.areaOptions || []
        for (const p of provinces) {
          const pLabel = p.label || ''
          // 匹配省份（直辖市或市）
          if (!pLabel || !cityStr) continue
          const provinceMatch = cityStr.indexOf(pLabel) !== -1
          if (!provinceMatch) continue

          const children = p.children || []
          // 首先尝试直接匹配区县名（对于直辖市的永川区、合川区等直接区县）
          if (districtLabel) {
            for (const c of children) {
              const cLabel = c.label || ''
              if (cLabel === districtLabel) {
                // 区县直接作为市的下一级
                this.areaValue = [p.value, c.value]
                return
              }
              // 检查区县是否在"市辖区"或"县"下
              if (c.children && c.children.length) {
                const d = c.children.find(x => x.label === districtLabel)
                if (d) {
                  this.areaValue = [p.value, c.value, d.value]
                  return
                }
              }
            }
          }

          // 然后尝试传统匹配：省份+城市
          for (const c of children) {
            const cLabel = c.label || ''
            const cityMatch = (pLabel + cLabel) === cityStr ||
                            (cityStr.indexOf(cLabel) !== -1 && cLabel.length > 0)
            if (!cityMatch) continue

            const path = [p.value, c.value]
            // 如果有区县标签，查找并添加
            if (districtLabel && c.children && c.children.length) {
              const d = c.children.find(x => x.label === districtLabel)
              if (d) path.push(d.value)
            }
            this.areaValue = path
            return
          }
        }
      } catch (e) {
        console.warn('设置所在地区失败:', e)
      }
    },
    imageUrl(u) {
      const base = process.env.VUE_APP_BASE_API || '';
      if (!u) return '';
      return u.indexOf('http') === 0 ? u : base + u;
    },
    initAreaOptions() {
      try {
        const data = require('china-area-data/data.json');
        const provinces = data['86'] || {};
        const toChildren = (code) => {
          const obj = data[code] || {};
          return Object.keys(obj).map(c => ({ label: obj[c], value: c, children: (data[c] ? toChildren(c) : undefined) })).filter(Boolean);
        };
        this.areaOptions = Object.keys(provinces).map(p => ({ label: provinces[p], value: p, children: toChildren(p) }));
      } catch (e) {
        this.areaOptions = [];
      }
    },
    onAreaChange(value) {
      const labels = [];
      const find = (opts, idx) => {
        if (!opts || idx >= (value ? value.length : 0)) return;
        const code = value[idx];
        const node = opts.find(o => o.value === code);
        if (node) {
          labels.push(node.label);
          find(node.children || [], idx + 1);
        }
      };
      find(this.areaOptions, 0);
      const province = labels[0] || '';
      let city = labels[1] || '';
      const district = labels[2] || undefined;
      if (city === '市辖区' || city === '县' || city === '省直辖县级行政区划') {
        city = '';
      }
      this.form.city = (province || '') + (city || '');
      this.form.district = district;
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

.detail-module { margin-bottom: 16px; }
.main-img-wrapper { width: 100%; max-width: 1200px;  overflow: hidden; border-radius: 8px; margin: 0 auto 24px; }
.main-img { width: 100%; height: 350px; }
::v-deep .main-img .el-image__inner { width: 100%; height: 350px; object-fit: cover; }
.detail-card { padding: 16px; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); margin-bottom: 16px; transition: box-shadow .2s ease; }
.detail-card:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.12); }
.detail-row { display: flex; flex-wrap: wrap; gap: 24px; }
.detail-row.single .detail-item { flex: 1 1 100%; }
.detail-item { flex: 0 0 calc((100% - 24px * 3) / 4); }
.detail-item .label { font-size: 12px; color: #909399; margin-bottom: 4px; }
.detail-item .value { font-size: 14px; color: #303133; font-weight: 500; word-break: break-word; }
.content-img-group { display: flex; gap: 16px; max-width: 1200px; margin: 20px auto 0; }
.content-img-item { flex: 1; aspect-ratio: 4/3; overflow: hidden; border-radius: 8px; }
::v-deep .content-img-item .el-image__inner { width: 100%; height: 100%; object-fit: cover; }
.empty-tip { text-align: center; color: #909399; font-size: 12px; }
.detail-close-btn { display: inline-block; margin: 0 auto; }
.detail-close-btn:hover { color: #409eff; border-color: #409eff; }
.map-loading { text-align: center; padding: 50px; color: #909399; }
.form-section {
  margin-bottom: 20px;
  padding: 15px;
  background: #f5f7fa;
  border-radius: 4px;
  border: 1px solid #ebeef5;
}
.section-title {
  font-size: 14px;
  font-weight: 600;
  color: #303133;
  margin-bottom: 15px;
  padding-bottom: 10px;
  border-bottom: 1px solid #dcdfe6;
}
.section-title i {
  margin-right: 6px;
  color: #409eff;
}
.coord-display {
  font-size: 12px;
  color: #909399;
  margin-left: 5px;
}
</style>