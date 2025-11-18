<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="场馆名称" prop="name">
        <el-input v-model="queryParams.name" placeholder="请输入场馆名称" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="详细地址" prop="address">
        <el-input v-model="queryParams.address" placeholder="请输入详细地址" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="场馆状态" clearable style="width: 240px">
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
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['tourism:venue:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['tourism:venue:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['tourism:venue:remove']">删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>

    <el-table
      v-loading="loading"
      :data="venueList"
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
      <el-table-column label="封面" width="90" align="center">
        <template slot-scope="scope">
          <el-image
            v-if="scope.row._coverUrl"
            :src="imageUrl(scope.row._coverUrl)"
            :preview-src-list="[imageUrl(scope.row._coverUrl)]"
            style="width: 48px; height: 48px; border-radius: 4px"
            fit="cover"
          />
        </template>
      </el-table-column>
      <el-table-column label="场馆名称" prop="name" min-width="100" :show-overflow-tooltip="true" />
      <el-table-column label="类别" prop="category" width="120" :show-overflow-tooltip="true" />
      <el-table-column label="所在城市" prop="city" width="120" :show-overflow-tooltip="true" />
      <el-table-column label="所在区县" prop="district" width="120" :show-overflow-tooltip="true" />
      <el-table-column label="门票价格" prop="ticketPrice" width="110" align="center">
        <template slot-scope="scope">
          <span>¥{{ scope.row.ticketPrice }}</span>
        </template>
      </el-table-column>
      <el-table-column label="联系电话" prop="contactPhone" width="140" :show-overflow-tooltip="true" />
      <el-table-column label="关联景区" width="160" align="center">
        <template slot-scope="scope">{{ scope.row._scenicName || '-' }}</template>
      </el-table-column>
      <el-table-column label="状态" prop="status" width="100" align="center">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="170">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right" width="220">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-document" @click="viewVenueDetail(scope.row)" v-hasPermi="['tourism:venue:query']">详情</el-button>
          <el-button size="mini" type="text" icon="el-icon-video-play" @click="toggleStatus(scope.row)" v-hasPermi="['tourism:venue:edit']">{{ scope.row.status === '0' ? '停用' : '启用' }}</el-button>
          <el-button size="mini" type="text" icon="el-icon-view" @click="viewActivities(scope.row)" v-hasPermi="['tourism:venue:activity:list']">查看活动</el-button>
          <el-button size="mini" type="text" icon="el-icon-location" @click="viewScenicSpots(scope.row)" v-hasPermi="['tourism:venue:scenicSpot:list']">查看景区</el-button>
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['tourism:venue:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['tourism:venue:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="场馆名称" prop="name">
              <el-input v-model="form.name" placeholder="请输入场馆名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="类别" prop="category">
              <el-input v-model="form.category" placeholder="请输入类别" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="门票价格" prop="ticketPrice">
              <el-input-number v-model="form.ticketPrice" :min="0" :precision="2" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="contactPhone">
              <el-input v-model="form.contactPhone" placeholder="请输入联系电话" />
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
          <el-col :span="24">
            <el-form-item label="详细地址" prop="address">
              <el-input v-model="form.address" placeholder="请输入详细地址" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="开放时间" prop="openingHours">
              <el-input v-model="form.openingHours" placeholder="请输入开放时间" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="官方网站" prop="website">
              <el-input v-model="form.website" placeholder="请输入官方网站" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="经度" prop="longitude">
              <el-input-number v-model="form.longitude" :precision="7" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="纬度" prop="latitude">
              <el-input-number v-model="form.latitude" :precision="7" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="容纳人数" prop="capacity">
              <el-input-number v-model="form.capacity" :min="0" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="需预约" prop="bookingRequired">
              <el-switch v-model="form.bookingRequired" active-value="1" inactive-value="0" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="场馆介绍" prop="description">
              <el-input v-model="form.description" type="textarea" :rows="4" placeholder="请输入场馆介绍" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="关联景区" prop="scenicSpotId">
              <el-select v-model="form.scenicSpotId" filterable placeholder="请选择关联景区" style="width: 100%" @change="onScenicSpotChange">
                <el-option v-for="s in scenicSpotOptions" :key="s.id" :label="s.name" :value="s.id" />
              </el-select>
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
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog title="场馆特色活动" :visible.sync="activityOpen" width="800px" append-to-body>
      <el-table :data="activityList">
        <el-table-column label="活动名称" prop="name" width="180" :show-overflow-tooltip="true" />
        <el-table-column label="类别" prop="category" width="120" />
        <el-table-column label="开始时间" prop="startTime" width="180">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.startTime) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="结束时间" prop="endTime" width="180">
          <template slot-scope="scope">
            <span>{{ parseTime(scope.row.endTime) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="审核状态" prop="auditStatus" width="120">
          <template slot-scope="scope">
            <el-tag :type="auditTagType(scope.row.auditStatus)">{{ auditText(scope.row.auditStatus) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="状态" prop="status" width="100">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button @click="activityOpen = false">关 闭</el-button>
      </div>
    </el-dialog>

    <el-dialog title="关联景区" :visible.sync="scenicOpen" width="1000px" append-to-body>
      <el-table :data="scenicList">
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
        <el-table-column label="景区名称" prop="name" min-width="180" :show-overflow-tooltip="true" />
        <el-table-column label="城市" prop="city" width="140" />
        <el-table-column label="等级" prop="level" width="100" align="center" />
        <el-table-column label="票价" prop="ticketPrice" width="120" align="center">
          <template slot-scope="scope"><span>¥{{ scope.row.ticketPrice }}</span></template>
        </el-table-column>
        <el-table-column label="操作" width="120" align="center">
          <template slot-scope="scope">
            <el-button type="text" size="mini" icon="el-icon-view" @click="viewScenicDetail(scope.row)">查看详情</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button @click="scenicOpen = false">关 闭</el-button>
      </div>
    </el-dialog>

    <el-dialog title="景区图片" :visible.sync="scenicImagesOpen" width="900px" append-to-body>
      <div style="display:flex; flex-wrap: wrap; gap: 8px">
        <el-image
          v-for="(img, idx) in scenicImagesList"
          :key="idx"
          :src="imageUrl(img.url)"
          :preview-src-list="scenicImagesPreview"
          style="width: 120px; height: 90px; border-radius: 4px"
          fit="cover"
        />
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="scenicImagesOpen = false">关 闭</el-button>
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
            <el-descriptions-item label="场馆介绍" :span="2">{{ venueDetail.description }}</el-descriptions-item>
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
import { listScenicVenue, getScenicVenue, addScenicVenue, updateScenicVenue, delScenicVenue, listScenicVenueActivity, listVenueScenicSpots, setVenueScenicSpots, listVenueImages } from '@/api/tourism/scenicVenue'
import { listScenicSpot, getScenicSpot } from '@/api/tourism/scenicSpot'
import Pagination from '@/components/Pagination'
import ImageUpload from '@/components/ImageUpload'

export default {
  name: 'TourismVenue',
  components: { Pagination, ImageUpload },
  data() {
    return {
      venueList: [],
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
        address: undefined,
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
        name: [{ required: true, message: '场馆名称不能为空', trigger: 'blur' }],
        category: [{ required: true, message: '类别不能为空', trigger: 'blur' }],
        ticketPrice: [{ required: true, message: '门票价格不能为空', trigger: 'blur' }],
        address: [{ required: true, message: '详细地址不能为空', trigger: 'blur' }],
        city: [{ required: true, message: '所在城市不能为空', trigger: 'blur' }]
      },
      activityOpen: false,
      activityList: [],
      scenicOpen: false,
      scenicList: [],
      scenicImagesOpen: false,
      scenicImagesList: [],
      scenicImagesPreview: [],
      venueDetailOpen: false,
      venueDetail: {},
      venueDetailImagesPreview: [],
      scenicDetailOpen: false,
      scenicDetail: {},
      scenicDetailImagesPreview: [],
      scenicSpotOptions: []
    }
  },
  created() {
    this.getList()
    listScenicSpot({ pageNum: 1, pageSize: 1000 }).then(res => { this.scenicSpotOptions = res.rows || [] })
  },
  methods: {
    handleQuery() {
      this.getList()
    },
    getList() {
      this.loading = true
      this.queryParams.startTime = this.dateRange[0]
      this.queryParams.endTime = this.dateRange[1]
      listScenicVenue(this.queryParams)
        .then(res => {
          const payload = res && res.data && typeof res.data === 'object' ? res.data : res
          const rows = (payload && payload.rows) || []
          const total = (payload && (payload.total || payload.count || rows.length)) || 0
          this.venueList = Array.isArray(rows) ? rows : []
          ;(this.venueList || []).forEach((v, i) => {
            listVenueScenicSpots(v.id).then(r => {
              const arr = Array.isArray(r.data) ? r.data : []
              const name = arr.length ? arr[0].name : '-'
              this.$set(this.venueList[i], '_scenicName', name)
            })
            listVenueImages(v.id).then(r => {
              const arr = Array.isArray(r.data) ? r.data : []
              const cover = v.coverImage || (arr.length ? arr[0].url : '')
              this.$set(this.venueList[i], '_coverUrl', cover)
            })
          })
          this.total = Number(total) || 0
        })
        .catch(() => { this.loading = false })
        .finally(() => { this.loading = false })
    },
    resetQuery() {
      this.queryParams = {
        pageNum: 1,
        pageSize: 10,
        name: undefined,
        address: undefined,
        status: undefined,
        orderByColumn: 'id',
        isAsc: 'asc'
      }
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
      getScenicVenue(id).then(response => {
        this.form = response.data
        listVenueScenicSpots(id).then(r => { const arr = (r.data || []); this.form.scenicSpotId = arr.length ? arr[0].id : undefined })
        listVenueImages(id).then(r => { const arr = Array.isArray(r.data) ? r.data : []; const urls = arr.map(it => it.url).filter(Boolean); this.$set(this.form, 'imageUrls', urls) })
        this.open = true
        this.title = '修改场馆信息'
      })
    },
    reset() {
        this.form = {
          id: undefined,
          name: undefined,
          category: undefined,
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
          capacity: 0,
          bookingRequired: '0',
          remark: undefined,
          scenicSpotId: undefined,
          imageUrls: []
        }
      this.resetForm && this.resetForm('form')
    },
    handleAdd() {
      this.open = true
      this.title = '新增场馆信息'
      this.reset()
    },
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal
        .confirm('是否确认删除场馆编号为"' + ids + '"的数据项？')
        .then(function () {
          return delScenicVenue(ids)
        })
        .then(() => {
          this.getList()
          this.$modal.msgSuccess('删除成功')
        })
        .catch(() => {
          this.$modal.msgError('删除失败')
        })
    },
    submitForm() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateScenicVenue(this.form).then(() => {
              const ids = this.form.scenicSpotId ? [this.form.scenicSpotId] : []
              setVenueScenicSpots(this.form.id, ids).then(() => {})
              import('@/api/tourism/uploadPictures').then((u) => {
                const urls = Array.isArray(this.form.imageUrls)
                  ? this.form.imageUrls
                  : (typeof this.form.imageUrls === 'string' && this.form.imageUrls
                      ? this.form.imageUrls.split(',').filter(Boolean)
                      : []);
                u.batchUploadImageUrls(urls).then((r) => {
                  const imageIds = (r.data || r.rows || []).map((it) => it.id);
                  import('@/api/tourism/scenicVenue').then((m) => { m.setVenueImages(this.form.id, imageIds).then(() => {}) })
                })
              })
              this.$modal.msgSuccess('修改成功')
              this.open = false
              this.getList()
            })
          } else {
            addScenicVenue(this.form).then((res) => {
              const vid = (res && res.data && res.data.id) ? res.data.id : this.form.id
              const ids = this.form.scenicSpotId ? [this.form.scenicSpotId] : []
              setVenueScenicSpots(vid, ids).then(() => {})
              import('@/api/tourism/uploadPictures').then((u) => {
                const urls = Array.isArray(this.form.imageUrls)
                  ? this.form.imageUrls
                  : (typeof this.form.imageUrls === 'string' && this.form.imageUrls
                      ? this.form.imageUrls.split(',').filter(Boolean)
                      : []);
                u.batchUploadImageUrls(urls).then((r) => {
                  const imageIds = (r.data || r.rows || []).map((it) => it.id);
                  import('@/api/tourism/scenicVenue').then((m) => { m.setVenueImages(vid, imageIds).then(() => {}) })
                })
              })
              this.$modal.msgSuccess('新增成功')
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    cancel() {
      this.open = false
      this.resetForm && this.resetForm('form')
    },
    viewActivities(row) {
      listScenicVenueActivity(row.id).then(response => {
        this.activityList = Array.isArray(response.data) ? response.data : []
        this.activityOpen = true
      })
    },
    viewScenicSpots(row) {
      listVenueScenicSpots(row.id).then(response => {
        this.scenicList = Array.isArray(response.data) ? response.data : []
        this.scenicOpen = true
      })
    },
    viewScenicImages(row) {
      import('@/api/tourism/scenicSpot').then((m) => {
        m.listScenicSpotImages(row.id).then((response) => {
          this.scenicImagesList = Array.isArray(response.data) ? response.data : []
          const base = process.env.VUE_APP_BASE_API || ''
          this.scenicImagesPreview = this.scenicImagesList.map(it => {
            const u = it && it.url ? it.url : ''
            return u.indexOf('http') === 0 ? u : base + u
          })
          this.scenicImagesOpen = true
        })
      })
    },
    viewVenueDetail(row) {
      getScenicVenue(row.id).then((response) => {
        this.venueDetail = response && response.data ? response.data : {}
        const base = process.env.VUE_APP_BASE_API || ''
        const imgs = Array.isArray(this.venueDetail.images) ? this.venueDetail.images : []
        this.venueDetailImagesPreview = imgs.map(it => {
          const u = it && it.url ? it.url : ''
          return u.indexOf('http') === 0 ? u : base + u
        })
        this.venueDetailOpen = true
      })
    },
    viewScenicDetail(row) {
      getScenicSpot(row.id).then((response) => {
        this.scenicDetail = response && response.data ? response.data : {}
        const base = process.env.VUE_APP_BASE_API || ''
        const imgs = Array.isArray(this.scenicDetail.images) ? this.scenicDetail.images : []
        this.scenicDetailImagesPreview = imgs.map(it => {
          const u = it && it.url ? it.url : ''
          return u.indexOf('http') === 0 ? u : base + u
        })
        this.scenicDetailOpen = true
      })
    },
    toggleStatus(row) {
      const target = row.status === '0' ? '1' : '0'
      const payload = { id: row.id, status: target }
      updateScenicVenue(payload).then(() => { this.$modal.msgSuccess('状态已更新'); this.getList() })
    },
    onScenicSpotChange(val) {
      if (!val) return
      getScenicSpot(val).then(r => {
        const s = r && r.data ? r.data : {}
        this.form.city = s.city
        this.form.district = s.district
        this.form.address = s.address
        this.form.longitude = s.longitude
        this.form.latitude = s.latitude
      })
    },
    auditText(s) {
      if (s === '1') return '通过'
      if (s === '2') return '拒绝'
      return '待审核'
    },
    auditTagType(s) {
      if (s === '1') return 'success'
      if (s === '2') return 'danger'
      return 'warning'
    },
    imageUrl(u) {
      const base = process.env.VUE_APP_BASE_API || ''
      if (!u) return ''
      return u.indexOf('http') === 0 ? u : base + u
    }
  }
}
</script>

<style lang="scss" scoped>
.app-container {
  padding: 20px;
}
</style>