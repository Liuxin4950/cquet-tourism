<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="场馆名称" prop="name">
        <el-input v-model="queryParams.name" placeholder="请输入场馆名称" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <!-- <el-form-item label="详细地址" prop="address">
        <el-input v-model="queryParams.address" placeholder="请输入详细地址" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="场馆状态" clearable style="width: 240px">
          <el-option label="正常" value="0" />
          <el-option label="停用" value="1" />
        </el-select>
      </el-form-item> -->
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
      <el-table-column label="场馆名称" prop="name" min-width="100" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="类别" prop="category" width="120" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="所在城市" prop="city" width="120" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="所在区县" prop="district" width="120" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="门票价格" prop="ticketPrice" width="110" align="center">
        <template slot-scope="scope">
          <span>{{ Number(scope.row.ticketPrice) === 0 ? '免费' : (scope.row.ticketPrice != null ? ('¥' + scope.row.ticketPrice) : '暂无...') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="联系电话" prop="contactPhone" width="140" :show-overflow-tooltip="true" :formatter="formatText" />
      <el-table-column label="状态" prop="status" width="100" align="center">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="170">
        <template slot-scope="scope">
          <span>{{ scope.row.createTime ? parseTime(scope.row.createTime) : '暂无...' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" fixed="right" width="220">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-document" @click="viewVenueDetail(scope.row)" v-hasPermi="['tourism:venue:query']">详情</el-button>
          <el-button size="mini" type="text" icon="el-icon-video-play" @click="toggleStatus(scope.row)" v-hasPermi="['tourism:venue:edit']">{{ scope.row.status === '0' ? '停用' : '启用' }}</el-button>
          <el-button size="mini" type="text" icon="el-icon-view" @click="viewActivities(scope.row)" v-hasPermi="['tourism:venue:activity:list']">查看活动</el-button>
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
              <el-select v-model="form.category" placeholder="请选择类别" filterable clearable style="width: 100%">
                <el-option v-for="opt in categoryOptions" :key="opt" :label="opt" :value="opt" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="票务" prop="feeType">
              <el-radio-group v-model="form.feeType" @change="onFeeTypeChange">
                <el-radio label="free">免费</el-radio>
                <el-radio label="paid">收费</el-radio>
              </el-radio-group>
            </el-form-item>
            <el-form-item v-if="form.feeType === 'paid'" label="门票价格" prop="ticketPrice">
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
          <el-col :span="24">
            <el-form-item label="所在地区">
              <el-cascader
                :options="areaOptions"
                v-model="areaValue"
                :props="{ checkStrictly: true }"
                clearable
                style="width: 100%"
                @change="onAreaChange"
              />
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
              <el-select v-model="form.openingHours" placeholder="请选择开放时间" clearable style="width: 100%">
                <el-option v-for="opt in openingHoursOptions" :key="opt" :label="opt" :value="opt" />
              </el-select>
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

    <el-dialog title="场馆详情" :visible.sync="venueDetailOpen" width="1000px" append-to-body>
      <div class="detail-module">
        <div class="main-img-wrapper">
          <el-image
            v-if="venueDetail.coverImage"
            :src="imageUrl(venueDetail.coverImage)"
            :preview-src-list="[imageUrl(venueDetail.coverImage)]"
            class="main-img"
            fit="cover"
          />
          <div v-else class="empty-tip">暂无图片</div>
        </div>
      </div>
      <div class="detail-card">
        <div class="detail-row">
          <div class="detail-item"><div class="label">名称</div><div class="value">{{ venueDetail.name || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">类别</div><div class="value">{{ venueDetail.category || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">城市</div><div class="value">{{ venueDetail.city || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">区县</div><div class="value">{{ venueDetail.district || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">票价</div><div class="value">{{ Number(venueDetail.ticketPrice) === 0 ? '免费' : (venueDetail.ticketPrice != null ? ('¥' + venueDetail.ticketPrice) : '暂无') }}</div></div>
          <div class="detail-item"><div class="label">电话</div><div class="value">{{ venueDetail.contactPhone || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">开放时间</div><div class="value">{{ venueDetail.openingHours || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">官网</div><div class="value">{{ venueDetail.website || '暂无' }}</div></div>
        </div>
      </div>
      <div class="detail-card">
        <div class="detail-row single">
          <div class="detail-item"><div class="label">地址</div><div class="value">{{ venueDetail.address || '暂无' }}</div></div>
          <div class="detail-item"><div class="label">场馆介绍</div><div class="value">{{ venueDetail.description || '暂无' }}</div></div>
        </div>
      </div>
      <div class="detail-card">
        <div class="content-img-group" v-if="venueDetail.images && venueDetail.images.length">
          <el-image v-for="(img, idx) in venueDetail.images" :key="idx" :src="imageUrl(img.url)" class="content-img-item" fit="cover" />
        </div>
        <div v-else class="empty-tip">暂无图片</div>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button class="detail-close-btn" @click="venueDetailOpen = false">关 闭</el-button>
      </div>
    </el-dialog>
    
  </div>
</template>

<script>
import { listScenicVenue, getScenicVenue, addScenicVenue, updateScenicVenue, delScenicVenue, listScenicVenueActivity, listVenueImages } from '@/api/tourism/scenicVenue'
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
        ticketPrice: [{ validator: (rule, value, callback) => { const isPaid = this && this.form && this.form.feeType === 'paid'; if (isPaid && (!value || Number(value) <= 0)) return callback(new Error('请填写有效票价')); callback() }, trigger: 'blur' }],
        address: [{ required: true, message: '详细地址不能为空', trigger: 'blur' }],
        city: [{ required: true, message: '所在城市不能为空', trigger: 'blur' }]
      },
      activityOpen: false,
      activityList: [],
      scenicImagesOpen: false,
      scenicImagesList: [],
      scenicImagesPreview: [],
      venueDetailOpen: false,
      venueDetail: {},
      venueDetailImagesPreview: [],
      areaOptions: [],
      areaValue: [],
      openingHoursOptions: ['全天','6:00-18:30','7:30-17:30','9:00-17:00','9:00-21:00','10:00-18:00'],
      categoryOptions: ['体育场馆类','文化艺术类场馆','会议展览类场馆','教育科研类场馆','娱乐休闲类场馆','商业服务类场馆','医疗健康类场馆']
    }
  },
  created() {
    this.getList()
    this.initAreaOptions()
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
    formatText(row, column, cellValue) {
      return cellValue || '暂无...'
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
        this.$set(this.form, 'feeType', Number(this.form.ticketPrice || 0) > 0 ? 'paid' : 'free')
        listVenueImages(id).then(r => { const arr = Array.isArray(r.data) ? r.data : []; const urls = arr.map(it => it.url).filter(Boolean); this.$set(this.form, 'imageUrls', urls) })
        if (!this.areaOptions || this.areaOptions.length === 0) {
          this.initAreaOptions()
          this.$nextTick(() => this.setAreaValueFromForm(this.form.city, this.form.district))
        } else {
          this.setAreaValueFromForm(this.form.city, this.form.district)
        }
        this.open = true
        this.title = '修改场馆信息'
      })
    },
    reset() {
        this.form = {
          id: undefined,
          name: undefined,
          category: undefined,
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
          capacity: 0,
          bookingRequired: '0',
          remark: undefined,
          imageUrls: []
        }
      this.resetForm && this.resetForm('form')
      this.areaValue = []
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
          if (this.form.feeType === 'free') { this.form.ticketPrice = 0 } else { if (!(Number(this.form.ticketPrice) > 0)) { this.$modal.msgError('请填写有效票价'); return } }
          if (this.form.id != undefined) {
            updateScenicVenue(this.form).then(() => {
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
    toggleStatus(row) {
      const target = row.status === '0' ? '1' : '0'
      const payload = { id: row.id, status: target }
      updateScenicVenue(payload).then(() => { this.$modal.msgSuccess('状态已更新'); this.getList() })
    },
    initAreaOptions() {
      try {
        const data = require('china-area-data/data.json')
        const provinces = data['86'] || {}
        const toChildren = (code) => {
          const obj = data[code] || {}
          return Object.keys(obj).map(c => ({ label: obj[c], value: c, children: (data[c] ? toChildren(c) : undefined) })).filter(Boolean)
        }
        this.areaOptions = Object.keys(provinces).map(p => ({ label: provinces[p], value: p, children: toChildren(p) }))
      } catch (e) {
        this.areaOptions = []
      }
    },
    onAreaChange(value) {
      const labels = []
      const find = (opts, idx) => {
        if (!opts || idx >= (value ? value.length : 0)) return
        const code = value[idx]
        const node = opts.find(o => o.value === code)
        if (node) {
          labels.push(node.label)
          find(node.children || [], idx + 1)
        }
      }
      find(this.areaOptions, 0)
      const province = labels[0] || ''
      let city = labels[1] || ''
      const district = labels[2] || undefined
      if (city === '市辖区' || city === '县' || city === '省直辖县级行政区划') {
        city = ''
      }
      this.form.city = (province || '') + (city || '')
      this.form.district = district
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
    },
    onFeeTypeChange(val) {
      if (val === 'free') this.form.ticketPrice = 0
    },
    setAreaValueFromForm(cityStr, districtLabel) {
      try {
        const target = cityStr || ''
        const provinces = this.areaOptions || []
        for (const p of provinces) {
          const pLabel = p.label || ''
          const children = p.children || []
          for (const c of children) {
            const cLabel = c.label || ''
            if (target && ((pLabel + cLabel) === target || cLabel === target)) {
              const path = [p.value, c.value]
              if (districtLabel && c.children && c.children.length) {
                const d = c.children.find(x => x.label === districtLabel)
                if (d) path.push(d.value)
              }
              this.areaValue = path
              return
            }
          }
          if (!target || pLabel === target) {
            if (districtLabel && children && children.length) {
              for (const c of children) {
                const d = (c.children || []).find(x => x.label === districtLabel)
                if (d) { this.areaValue = [p.value, c.value, d.value]; return }
              }
            }
            if (pLabel === target) { this.areaValue = [p.value]; return }
          }
        }
        if (districtLabel) {
          for (const p of provinces) {
            for (const c of (p.children || [])) {
              const d = (c.children || []).find(x => x.label === districtLabel)
              if (d) { this.areaValue = [p.value, c.value, d.value]; return }
            }
          }
        }
      } catch (e) {}
    }
  }
}
</script>

<style lang="scss" scoped>
.app-container {
  padding: 20px;
}

.detail-module { margin-bottom: 16px; }
.main-img-wrapper { width: 100%; max-width: 1200px; overflow: hidden; border-radius: 8px; margin: 0 auto 24px; }
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
</style>