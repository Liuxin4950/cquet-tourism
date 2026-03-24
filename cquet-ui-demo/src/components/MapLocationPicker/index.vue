<template>
  <div class="map-location-picker">
    <!-- 搜索框 -->
    <div class="search-box">
      <el-input
        v-model="keyword"
        placeholder="输入地址搜索地点（如：洪崖洞）"
        clearable
        @keyup.enter.native="searchLocation"
      >
        <i slot="prefix" class="el-input__icon el-icon-search"></i>
        <el-button slot="append" icon="el-icon-search" @click="searchLocation">搜索</el-button>
      </el-input>
    </div>

    <!-- 地图容器 -->
    <div class="map-wrapper">
      <div id="bmap-container" class="map-container" ref="mapContainer"></div>
    </div>

    <!-- 搜索结果列表 -->
    <div v-if="searchResults.length > 0" class="search-results">
      <div class="results-title">搜索结果：</div>
      <div
        v-for="(item, index) in searchResults"
        :key="index"
        class="result-item"
        @click="selectSearchResult(item)"
      >
        <i class="el-icon-location-outline"></i>
        <div class="result-info">
          <div class="result-name">{{ item.title }}</div>
          <div class="result-address">{{ item.address }}</div>
        </div>
      </div>
    </div>

    <!-- 已选位置信息 -->
    <div v-if="selectedLocation" class="selected-info">
      <el-alert
        :title="'已选择: ' + selectedLocation.address"
        type="success"
        :closable="false"
        show-icon
      >
        <div class="selected-coords">
          <span>经度: {{ selectedLocation.lng }}</span>
          <span>纬度: {{ selectedLocation.lat }}</span>
        </div>
      </el-alert>
      <el-button size="small" type="text" @click="clearSelection">清除选择</el-button>
    </div>

    <!-- 点击地图提示 -->
    <div class="map-hint">
      <span>点击地图选择位置，或在上方搜索框输入地址搜索</span>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MapLocationPicker',
  props: {
    longitude: { type: [Number, String], default: null },
    latitude: { type: [Number, String], default: null }
  },
  data() {
    return {
      keyword: '',
      searchResults: [],
      selectedLocation: null,
      map: null,
      marker: null,
      geocoder: null,
      localSearch: null,
      isMapLoaded: false
    }
  },
  watch: {
    longitude(val) { val && this.isMapLoaded && this.updateMarkerFromCoords() },
    latitude(val) { val && this.isMapLoaded && this.updateMarkerFromCoords() }
  },
  mounted() { this.initMap() },
  beforeDestroy() {
    if (this.map) { this.map.destroy(); this.map = null }
  },
  methods: {
    // 初始化地图
    initMap() {
      if (typeof BMap === 'undefined') {
        setTimeout(() => this.initMap(), 100)
        return
      }
      this.$nextTick(() => this.createMap())
    },

    createMap() {
      if (typeof BMap === 'undefined') { setTimeout(() => this.createMap(), 100); return }
      const container = this.$refs.mapContainer
      if (!container) return
      const rect = container.getBoundingClientRect()
      if (rect.width === 0 || rect.height === 0) { setTimeout(() => this.createMap(), 100); return }

      // 重庆中心点
      const center = new BMap.Point(106.551556, 29.56301)
      this.map = new BMap.Map(container)
      this.map.centerAndZoom(center, 12)
      this.map.enableScrollWheelZoom(true)

      // 点击地图选择位置
      this.map.addEventListener('click', (e) => this.handleMapClick(e.point.lng, e.point.lat))

      this.geocoder = new BMap.Geocoder()

      // 如果已有坐标，显示标记
      if (this.longitude && this.latitude) {
        this.updateMarkerFromCoords()
      }

      this.isMapLoaded = true
    },

    // 搜索位置（自动加"重庆"前缀）
    searchLocation() {
      if (!this.keyword.trim()) { this.$message.warning('请输入搜索关键字'); return }
      if (!this.isMapLoaded) { this.$message.error('地图未加载完成'); return }

      this.searchResults = []
      const searchKeyword = '重庆 ' + this.keyword.trim()

      this.localSearch = new BMap.LocalSearch(this.map, {
        renderOptions: { map: this.map, panel: null },
        onSearchComplete: (results) => {
          if (results && results.getCurrentNumPois() > 0) {
            this.searchResults = []
            for (let i = 0; i < results.getCurrentNumPois(); i++) {
              const poi = results.getPoi(i)
              this.searchResults.push({
                title: poi.title,
                address: poi.address,
                lng: poi.point.lng,
                lat: poi.point.lat,
                point: poi.point
              })
            }
          } else {
            this.$message.info('未找到相关地点')
          }
        }
      })
      this.localSearch.search(searchKeyword)
    },

    // 选择搜索结果
    selectSearchResult(item) {
      this.map.panTo(item.point)
      this.map.setZoom(15)
      this.handleMapClick(item.lng, item.lat, item.title + ' ' + item.address)
      this.searchResults = []
      this.keyword = ''
    },

    // 处理位置选择
    handleMapClick(lng, lat, address) {
      const point = new BMap.Point(lng, lat)
      this.geocoder.getLocation(point, (result) => {
        let addressText = address || '未知地址'
        let district = '', city = ''

        if (result) {
          if (!address) addressText = result.address
          if (result.addressComponents) {
            district = result.addressComponents.district || ''
            city = result.addressComponents.city || ''
            // 验证是否在重庆市范围内
            if (city && city.indexOf('重庆') === -1 && district.indexOf('重庆') === -1) {
              this.$message.warning('所选位置不在重庆市范围内')
              return
            }
          }
        }

        this.selectedLocation = { lng, lat, address: addressText, district, city }
        this.addMarker(lng, lat)
        this.$emit('update:longitude', lng)
        this.$emit('update:latitude', lat)
        this.$emit('select', this.selectedLocation)
      })
    },

    // 添加标记
    addMarker(lng, lat) {
      if (!this.map) return
      if (this.marker) this.map.removeOverlay(this.marker)
      this.marker = new BMap.Marker(new BMap.Point(lng, lat))
      this.map.addOverlay(this.marker)
      this.marker.enableDragging()
      this.marker.addEventListener('dragend', (e) => this.handleMapClick(e.point.lng, e.point.lat))
    },

    // 更新标记（编辑时）
    updateMarkerFromCoords() {
      if (!this.longitude || !this.latitude || !this.map) return
      const point = new BMap.Point(this.longitude, this.latitude)
      this.map.panTo(point)
      this.addMarker(this.longitude, this.latitude)
      // 逆解析获取地址
      if (this.geocoder) {
        this.geocoder.getLocation(point, (result) => {
          if (result) {
            this.selectedLocation = {
              lng: this.longitude,
              lat: this.latitude,
              address: result.address,
              district: result.addressComponents?.district || '',
              city: result.addressComponents?.city || ''
            }
          }
        })
      }
    },

    // 清除选择
    clearSelection() {
      if (this.map && this.marker) this.map.removeOverlay(this.marker)
      this.marker = null
      this.selectedLocation = null
      this.$emit('update:longitude', null)
      this.$emit('update:latitude', null)
      this.$emit('clear')
    }
  }
}
</script>

<style scoped lang="scss">
.map-location-picker {
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  padding: 15px;
  background: #f5f7fa;
}

.search-box {
  margin-bottom: 15px;
  .el-input { width: 100%; }
}

.map-wrapper {
  border-radius: 4px;
  overflow: hidden;
  border: 1px solid #dcdfe6;
}

.map-container { width: 100%; height: 400px; }

.search-results {
  max-height: 200px;
  overflow-y: auto;
  margin-top: 15px;
  border: 1px solid #e4e7ed;
  border-radius: 4px;
  background: #fff;

  .results-title {
    padding: 8px 12px;
    font-size: 12px;
    color: #909399;
    background: #f5f7fa;
    border-bottom: 1px solid #ebeef5;
  }

  .result-item {
    display: flex;
    align-items: center;
    padding: 10px 12px;
    cursor: pointer;
    border-bottom: 1px solid #f0f0f0;
    &:hover { background: #f5f7fa; }
    &:last-child { border-bottom: none; }

    i { font-size: 18px; color: #409eff; margin-right: 10px; }

    .result-info {
      flex: 1;
      overflow: hidden;
      .result-name { font-size: 14px; color: #303133; font-weight: 500; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
      .result-address { font-size: 12px; color: #909399; margin-top: 2px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
    }
  }
}

.selected-info {
  margin-top: 15px;
  .el-alert { padding: 8px 12px; }
  .selected-coords { display: flex; gap: 20px; margin-top: 5px; font-size: 12px; color: #606266; }
  .el-button--small { margin-top: 8px; }
}

.map-hint { margin-top: 10px; font-size: 12px; color: #909399; text-align: center; }
</style>
