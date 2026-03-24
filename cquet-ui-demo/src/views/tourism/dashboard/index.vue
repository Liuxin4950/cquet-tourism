<template>
  <div class="dashboard-container">
    <!-- 统计卡片区域 -->
    <el-row :gutter="20" class="stat-cards">
      <el-col :xs="12" :sm="8" :md="6">
        <div class="stat-card scenic">
          <div class="stat-icon">
            <i class="el-icon-location-outline"></i>
          </div>
          <div class="stat-info">
            <div class="stat-value">{{ statistics.scenicCount || 0 }}</div>
            <div class="stat-label">景区数量</div>
          </div>
        </div>
      </el-col>
      <el-col :xs="12" :sm="8" :md="6">
        <div class="stat-card venue">
          <div class="stat-icon">
            <i class="el-icon-office-building"></i>
          </div>
          <div class="stat-info">
            <div class="stat-value">{{ statistics.venueCount || 0 }}</div>
            <div class="stat-label">场馆数量</div>
          </div>
        </div>
      </el-col>
      <el-col :xs="12" :sm="8" :md="6">
        <div class="stat-card activity">
          <div class="stat-icon">
            <i class="el-icon-tickets"></i>
          </div>
          <div class="stat-info">
            <div class="stat-value">{{ statistics.activityCount || 0 }}</div>
            <div class="stat-label">活动数量</div>
          </div>
        </div>
      </el-col>
      <el-col :xs="12" :sm="8" :md="6">
        <div class="stat-card pending">
          <div class="stat-icon">
            <i class="el-icon-refresh"></i>
          </div>
          <div class="stat-info">
            <div class="stat-value">{{ statistics.pendingCount || 0 }}</div>
            <div class="stat-label">待审核活动</div>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- 图表区域 -->
    <el-row :gutter="20" class="chart-row">
      <!-- 左侧：重庆地图 -->
      <el-col :xs="24" :md="12">
        <div class="chart-container map-container">
          <div class="chart-header">
            <span class="chart-title">重庆景区分布</span>
          </div>
          <div id="mapChart" class="map-chart" v-loading="mapLoading"></div>
        </div>
      </el-col>

      <!-- 右侧：区县分布柱状图 -->
      <el-col :xs="24" :md="12">
        <div class="chart-container">
          <div class="chart-header">
            <span class="chart-title">各区县景区数量</span>
          </div>
          <div id="districtChart" class="bar-chart" v-loading="chartLoading"></div>
        </div>
      </el-col>
    </el-row>

    <!-- 底部图表区域 -->
    <el-row :gutter="20" class="chart-row">
      <!-- 景区热度排行 -->
      <el-col :xs="24" :md="12">
        <div class="chart-container">
          <div class="chart-header">
            <span class="chart-title">景区热度排行 TOP10</span>
          </div>
          <div id="hotSpotChart" class="hot-chart" v-loading="chartLoading"></div>
        </div>
      </el-col>

      <!-- 活动趋势 -->
      <el-col :xs="24" :md="12">
        <div class="chart-container">
          <div class="chart-header">
            <span class="chart-title">月度活动数量趋势</span>
          </div>
          <div id="trendChart" class="trend-chart" v-loading="chartLoading"></div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import { getDashboardStatistics } from '@/api/tourism/dashboard'

export default {
  name: 'TourismDashboard',
  data() {
    return {
      // 统计数据
      statistics: {
        scenicCount: 0,
        venueCount: 0,
        activityCount: 0,
        pendingCount: 0
      },
      // 加载状态
      mapLoading: true,
      chartLoading: true,
      // 图表实例
      mapChart: null,
      districtChart: null,
      hotSpotChart: null,
      trendChart: null,
      // GeoJSON 数据
      mapData: null
    }
  },
  created() {
    this.loadStatistics()
  },
  mounted() {
    this.initMapChart()
    window.addEventListener('resize', this.handleResize)
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.handleResize)
    this.disposeCharts()
  },
  methods: {
    // 加载统计数据
    loadStatistics() {
      getDashboardStatistics().then(res => {
        if (res.code === 200 && res.data) {
          this.statistics = res.data
        }
        this.loadDistrictData()
        this.loadHotSpotData()
        this.loadTrendData()
      }).catch(() => {
        this.chartLoading = false
        this.mapLoading = false
      })
    },

    // 初始化地图
    initMapChart() {
      this.mapLoading = true
      // 加载重庆GeoJSON
      fetch('/chongqing.json')
        .then(response => response.json())
        .then(data => {
          this.mapData = data
          this.mapChart = echarts.init(document.getElementById('mapChart'))
          echarts.registerMap('chongqing', data)
          this.loadMapData()
        })
        .catch(err => {
          console.error('加载地图数据失败:', err)
          this.mapLoading = false
        })
    },

    // 加载地图数据
    loadMapData() {
      if (!this.mapChart || !this.mapData) return

      const option = {
        tooltip: {
          trigger: 'item',
          formatter: (params) => {
            if (params.data) {
              return `${params.name}<br/>景区: ${params.data.value || 0} 个<br/>场馆: ${params.data.venueValue || 0} 个`
            }
            return params.name
          }
        },
        visualMap: {
          min: 0,
          max: 20,
          text: ['高', '低'],
          realtime: false,
          calculable: true,
          inRange: {
            color: ['#e0f3f8', '#abd9e9', '#74add1', '#4575b4']
          },
          left: 'left',
          bottom: '20'
        },
        series: [{
          name: '景区分布',
          type: 'map',
          map: 'chongqing',
          roam: true,
          zoom: 1.2,
          // 默认不显示标签，避免文字挤在一起
          label: {
            show: false
          },
          // 鼠标悬停时显示高亮和标签
          emphasis: {
            itemStyle: {
              areaColor: '#ffd700'
            },
            label: {
              show: true,
              formatter: '{b}',
              fontSize: 12,
              fontWeight: 'bold',
              color: '#333'
            }
          },
          // 放大到较大级别时显示标签
          zoom: 1.5,
          data: this.generateMapData()
        }]
      }

      this.mapChart.setOption(option)
      this.mapLoading = false
    },

    // 生成地图数据（示例数据，实际从后端获取）
    generateMapData() {
      // 模拟各区县景区数量
      const scenicData = [
        { name: '渝中区', value: 8 },
        { name: '江北区', value: 5 },
        { name: '渝北区', value: 12 },
        { name: '南岸区', value: 6 },
        { name: '沙坪坝区', value: 7 },
        { name: '九龙坡区', value: 4 },
        { name: '大渡口区', value: 2 },
        { name: '巴南区', value: 5 },
        { name: '北碚区', value: 4 },
        { name: '璧山区', value: 3 },
        { name: '永川区', value: 6 },
        { name: '合川区', value: 4 },
        { name: '涪陵区', value: 5 },
        { name: '万州区', value: 7 },
        { name: '黔江区', value: 3 },
        { name: '武隆区', value: 15 },
        { name: '南川区', value: 4 },
        { name: '綦江区', value: 3 },
        { name: '大足区', value: 8 },
        { name: '铜梁区', value: 3 },
        { name: '潼南区', value: 2 },
        { name: '荣昌区', value: 2 },
        { name: '梁平区', value: 3 },
        { name: '城口县', value: 2 },
        { name: '丰都县', value: 4 },
        { name: '垫江县', value: 2 },
        { name: '忠县', value: 3 },
        { name: '开州区', value: 5 },
        { name: '云阳县', value: 3 },
        { name: '奉节县', value: 6 },
        { name: '巫山县', value: 4 },
        { name: '巫溪县', value: 2 },
        { name: '石柱县', value: 5 },
        { name: '秀山县', value: 2 },
        { name: '酉阳县', value: 3 },
        { name: '彭水县', value: 4 }
      ]

      const venueData = [
        { name: '渝中区', venueValue: 12 },
        { name: '江北区', venueValue: 8 },
        { name: '渝北区', venueValue: 15 },
        { name: '南岸区', venueValue: 7 },
        { name: '沙坪坝区', venueValue: 10 },
        { name: '九龙坡区', venueValue: 6 },
        { name: '大渡口区', venueValue: 3 },
        { name: '巴南区', venueValue: 5 },
        { name: '北碚区', venueValue: 6 },
        { name: '璧山区', venueValue: 4 },
        { name: '永川区', venueValue: 8 },
        { name: '合川区', venueValue: 5 },
        { name: '涪陵区', venueValue: 7 },
        { name: '万州区', venueValue: 9 },
        { name: '黔江区', venueValue: 4 },
        { name: '武隆区', venueValue: 6 },
        { name: '南川区', venueValue: 3 },
        { name: '綦江区', venueValue: 4 },
        { name: '大足区', venueValue: 7 },
        { name: '铜梁区', venueValue: 3 },
        { name: '潼南区', venueValue: 2 },
        { name: '荣昌区', venueValue: 2 },
        { name: '梁平区', venueValue: 3 },
        { name: '城口县', venueValue: 1 },
        { name: '丰都县', venueValue: 2 },
        { name: '垫江县', venueValue: 2 },
        { name: '忠县', venueValue: 3 },
        { name: '开州区', venueValue: 5 },
        { name: '云阳县', venueValue: 3 },
        { name: '奉节县', venueValue: 4 },
        { name: '巫山县', venueValue: 3 },
        { name: '巫溪县', venueValue: 2 },
        { name: '石柱县', venueValue: 4 },
        { name: '秀山县', venueValue: 2 },
        { name: '酉阳县', venueValue: 2 },
        { name: '彭水县', venueValue: 3 }
      ]

      // 合并数据
      const mergedData = scenicData.map(s => ({
        ...s,
        venueValue: venueData.find(v => v.name === s.name)?.venueValue || 0
      }))

      return mergedData
    },

    // 加载区县分布数据
    loadDistrictData() {
      this.chartLoading = true
      this.districtChart = echarts.init(document.getElementById('districtChart'))

      const option = {
        tooltip: {
          trigger: 'axis',
          axisPointer: { type: 'shadow' }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          top: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          data: ['渝中', '江北', '渝北', '南岸', '沙坪坝', '九龙坡', '大渡口', '巴南', '北碚', '武隆', '大足', '万州'],
          axisLabel: { rotate: 45, fontSize: 10 },
          axisTick: { alignWithLabel: true }
        },
        yAxis: {
          type: 'value',
          name: '数量',
          axisTick: { show: false }
        },
        series: [
          {
            name: '景区',
            type: 'bar',
            barWidth: '35%',
            itemStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: '#409EFF' },
                { offset: 1, color: '#66b1ff' }
              ])
            },
            data: [8, 5, 12, 6, 7, 4, 2, 5, 4, 15, 8, 7]
          },
          {
            name: '场馆',
            type: 'bar',
            barWidth: '35%',
            itemStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: '#67C23A' },
                { offset: 1, color: '#95d475' }
              ])
            },
            data: [12, 8, 15, 7, 10, 6, 3, 5, 6, 6, 7, 9]
          }
        ]
      }

      this.districtChart.setOption(option)
      this.chartLoading = false
    },

    // 加载热度排行数据
    loadHotSpotData() {
      this.hotSpotChart = echarts.init(document.getElementById('hotSpotChart'))

      const option = {
        tooltip: {
          trigger: 'axis',
          axisPointer: { type: 'shadow' }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          top: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'value',
          axisTick: { show: false }
        },
        yAxis: {
          type: 'category',
          data: ['洪崖洞', '武隆天生三桥', '大足石刻', '长江三峡', '解放碑', '磁器口', '白公馆', '渣滓洞', '仙女山', '金佛山'],
          axisLabel: { fontSize: 10 },
          axisTick: { show: false }
        },
        series: [{
          name: '浏览量',
          type: 'bar',
          barWidth: '60%',
          itemStyle: {
            color: new echarts.graphic.LinearGradient(0, 0, 1, 0, [
              { offset: 0, color: '#fdb462' },
              { offset: 1, color: '#ffbf47' }
            ])
          },
          data: [12580, 9820, 8560, 7890, 7230, 6890, 5420, 4890, 4560, 3980]
        }]
      }

      this.hotSpotChart.setOption(option)
    },

    // 加载趋势数据
    loadTrendData() {
      this.trendChart = echarts.init(document.getElementById('trendChart'))

      const option = {
        tooltip: {
          trigger: 'axis'
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          top: '10%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
          axisTick: { show: false }
        },
        yAxis: {
          type: 'value',
          name: '活动数',
          axisTick: { show: false }
        },
        series: [{
          name: '活动数量',
          type: 'line',
          smooth: true,
          symbol: 'circle',
          symbolSize: 8,
          itemStyle: {
            color: '#409EFF'
          },
          lineStyle: {
            width: 3,
            color: '#409EFF'
          },
          areaStyle: {
            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
              { offset: 0, color: 'rgba(64, 158, 255, 0.3)' },
              { offset: 1, color: 'rgba(64, 158, 255, 0.05)' }
            ])
          },
          data: [12, 18, 25, 32, 45, 52, 48, 55, 42, 38, 28, 15]
        }]
      }

      this.trendChart.setOption(option)
    },

    // 响应式处理
    handleResize() {
      if (this.mapChart) this.mapChart.resize()
      if (this.districtChart) this.districtChart.resize()
      if (this.hotSpotChart) this.hotSpotChart.resize()
      if (this.trendChart) this.trendChart.resize()
    },

    // 销毁图表实例
    disposeCharts() {
      if (this.mapChart) {
        this.mapChart.dispose()
        this.mapChart = null
      }
      if (this.districtChart) {
        this.districtChart.dispose()
        this.districtChart = null
      }
      if (this.hotSpotChart) {
        this.hotSpotChart.dispose()
        this.hotSpotChart = null
      }
      if (this.trendChart) {
        this.trendChart.dispose()
        this.trendChart = null
      }
    }
  }
}
</script>

<style scoped lang="scss">
.dashboard-container {
  padding: 20px;
  background-color: #f5f7fa;
  min-height: calc(100vh - 84px);
}

.stat-cards {
  margin-bottom: 20px;
}

.stat-card {
  display: flex;
  align-items: center;
  padding: 20px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
  margin-bottom: 20px;
  transition: transform 0.3s;

  &:hover {
    transform: translateY(-5px);
  }

  .stat-icon {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 15px;
    font-size: 24px;
    color: #fff;
  }

  &.scenic .stat-icon {
    background: linear-gradient(135deg, #409EFF, #66b1ff);
  }

  &.venue .stat-icon {
    background: linear-gradient(135deg, #67C23A, #95d475);
  }

  &.activity .stat-icon {
    background: linear-gradient(135deg, #E6A23C, #f5c77e);
  }

  &.pending .stat-icon {
    background: linear-gradient(135deg, #F56C6C, #f89f9f);
  }

  .stat-info {
    flex: 1;

    .stat-value {
      font-size: 28px;
      font-weight: 600;
      color: #303133;
      line-height: 1;
    }

    .stat-label {
      font-size: 14px;
      color: #909399;
      margin-top: 5px;
    }
  }
}

.chart-row {
  margin-bottom: 20px;
}

.chart-container {
  background: #fff;
  border-radius: 8px;
  padding: 15px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
  height: 350px;

  .chart-header {
    padding-bottom: 15px;
    border-bottom: 1px solid #ebeef5;

    .chart-title {
      font-size: 16px;
      font-weight: 600;
      color: #303133;
    }
  }

  .map-chart {
    height: 280px;
  }

  .bar-chart,
  .hot-chart,
  .trend-chart {
    height: 280px;
  }
}

@media (max-width: 768px) {
  .stat-card {
    padding: 15px;

    .stat-icon {
      width: 50px;
      height: 50px;
      font-size: 20px;
    }

    .stat-info .stat-value {
      font-size: 22px;
    }
  }

  .chart-container {
    height: 300px;
    margin-bottom: 20px;
  }
}
</style>
