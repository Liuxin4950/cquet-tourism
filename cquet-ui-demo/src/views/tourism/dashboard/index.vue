<template>
  <div class="app-container tourism-dashboard">
    <section class="hero">
      <div class="hero__content">
        <div class="hero__eyebrow">Tourism Operations Dashboard</div>
        <h1 class="hero__title">重庆文旅运营大屏</h1>
        <p class="hero__desc">
          这一版不再展示示例数据，景区、场馆、活动趋势和热度排行都直接来自当前管理端真实业务数据。
        </p>
        <div class="hero__meta">
          <span>{{ currentDateText }}</span>
          <span>{{ dashboardSummary }}</span>
          <span>{{ mapSummary }}</span>
        </div>
      </div>

      <div class="hero__panel">
        <div class="hero__panel-label">运营焦点</div>
        <div class="hero__panel-number">{{ statistics.pendingCount || 0 }}</div>
        <div class="hero__panel-title">待审核活动</div>
        <p class="hero__panel-tip">{{ pendingTip }}</p>
        <div class="hero__panel-metrics">
          <div>
            <span>热点景区</span>
            <strong>{{ topHotSpotText }}</strong>
          </div>
          <div>
            <span>资源最集中的区县</span>
            <strong>{{ topDistrictText }}</strong>
          </div>
        </div>
      </div>
    </section>

    <section class="stats-grid">
      <article
        v-for="card in metricCards"
        :key="card.key"
        class="metric-card"
        :class="card.theme"
      >
        <div class="metric-card__head">
          <span class="metric-card__label">{{ card.label }}</span>
          <i :class="card.icon" class="metric-card__icon" />
        </div>
        <div class="metric-card__value">{{ card.value }}</div>
        <div class="metric-card__foot">{{ card.note }}</div>
      </article>
    </section>

    <section class="main-grid">
      <article class="panel panel--map">
        <div class="panel__header">
          <div>
            <div class="panel__eyebrow">Regional Heat</div>
            <h3 class="panel__title">区域资源热力图</h3>
          </div>
          <span class="panel__hint">{{ heatMapHint }}</span>
        </div>
        <div v-loading="mapLoading" class="panel__body panel__body--chart">
          <div ref="heatMapChart" class="chart-surface" :class="{ 'chart-surface--hidden': !hasHeatMapData }" />
          <div v-if="!hasHeatMapData" class="chart-empty">
            <el-empty :image-size="92" description="暂无区县热力数据" />
          </div>
        </div>
      </article>

      <article class="panel panel--map">
        <div class="panel__header">
          <div>
            <div class="panel__eyebrow">Coordinate Points</div>
            <h3 class="panel__title">资源坐标点位</h3>
          </div>
          <span class="panel__hint">{{ pointMapHint }}</span>
        </div>
        <div v-loading="mapLoading" class="panel__body panel__body--chart">
          <div ref="pointMapChart" class="chart-surface" :class="{ 'chart-surface--hidden': !hasPointMapData }" />
          <transition name="point-card-fade">
            <div v-if="selectedMapPoint" class="point-card">
              <button type="button" class="point-card__close" @click="selectedMapPoint = null">&times;</button>
              <div class="point-card__cover">
                <img v-if="selectedMapPoint.coverImage" :src="imageUrl(selectedMapPoint.coverImage)" :alt="selectedMapPoint.name">
                <div v-else class="point-card__placeholder">
                  {{ pointTypeLabel(selectedMapPoint) }}
                </div>
              </div>
              <div class="point-card__content">
                <div class="point-card__meta">
                  <span>{{ pointTypeLabel(selectedMapPoint) }}</span>
                  <span>{{ pointMetaText(selectedMapPoint) }}</span>
                </div>
                <h4>{{ selectedMapPoint.name }}</h4>
                <p>{{ pointDescription(selectedMapPoint) }}</p>
                <div class="point-card__foot">
                  <span>{{ selectedMapPoint.district || '未知区县' }}</span>
                  <span>{{ selectedMapPoint.viewCount || 0 }} 浏览</span>
                </div>
              </div>
            </div>
          </transition>
          <div v-if="!hasPointMapData" class="chart-empty">
            <el-empty :image-size="92" description="暂无可展示的坐标点位" />
          </div>
        </div>
      </article>

      <article class="panel">
        <div class="panel__header">
          <div>
            <div class="panel__eyebrow">District Distribution</div>
            <h3 class="panel__title">区县资源分布</h3>
          </div>
          <span class="panel__hint">{{ districtDistribution.length }} 个区县有数据</span>
        </div>
        <div v-loading="chartLoading" class="panel__body panel__body--chart">
          <div ref="districtChart" class="chart-surface" :class="{ 'chart-surface--hidden': !hasDistrictData }" />
          <div v-if="!hasDistrictData" class="chart-empty">
            <el-empty :image-size="84" description="暂无区县分布数据" />
          </div>
        </div>
      </article>

      <article class="panel">
        <div class="panel__header">
          <div>
            <div class="panel__eyebrow">Hot Ranking</div>
            <h3 class="panel__title">景区热度排行</h3>
          </div>
          <span class="panel__hint">按浏览量排序的真实数据</span>
        </div>
        <div v-loading="chartLoading" class="panel__body panel__body--chart">
          <div ref="hotSpotChart" class="chart-surface" :class="{ 'chart-surface--hidden': !hasHotSpotData }" />
          <div v-if="!hasHotSpotData" class="chart-empty">
            <el-empty :image-size="84" description="暂无热度排行数据" />
          </div>
        </div>
      </article>

      <article class="panel">
        <div class="panel__header">
          <div>
            <div class="panel__eyebrow">Activity Trend</div>
            <h3 class="panel__title">近 12 个月活动趋势</h3>
          </div>
          <span class="panel__hint">{{ trendHint }}</span>
        </div>
        <div v-loading="chartLoading" class="panel__body panel__body--chart">
          <div ref="trendChart" class="chart-surface" :class="{ 'chart-surface--hidden': !hasTrendData }" />
          <div v-if="!hasTrendData" class="chart-empty">
            <el-empty :image-size="84" description="暂无活动趋势数据" />
          </div>
        </div>
      </article>

      <article class="panel">
        <div class="panel__header">
          <div>
            <div class="panel__eyebrow">Operations Notes</div>
            <h3 class="panel__title">运营提示</h3>
          </div>
        </div>
        <div class="insight-list">
          <div class="insight-item">
            <span>当前资源总量</span>
            <strong>{{ resourceTotal }}</strong>
          </div>
          <div class="insight-item">
            <span>热点景区</span>
            <strong>{{ topHotSpotText }}</strong>
          </div>
          <div class="insight-item">
            <span>重点区县</span>
            <strong>{{ topDistrictText }}</strong>
          </div>
          <div class="insight-item">
            <span>坐标标注覆盖</span>
            <strong>{{ mapPoints.length }} 个点位</strong>
          </div>
        </div>
        <div class="notice-box">
          <div class="notice-box__title">建议动作</div>
          <p>{{ operationTip }}</p>
        </div>
      </article>
    </section>
  </div>
</template>

<script>
import * as echarts from 'echarts'
import {
  getActivityTrend,
  getDashboardStatistics,
  getDistrictDistribution,
  getHotSpotRanking,
  getMapDistribution
} from '@/api/tourism/dashboard'

export default {
  name: 'TourismDashboard',
  data() {
    return {
      statistics: {
        scenicCount: 0,
        venueCount: 0,
        activityCount: 0,
        pendingCount: 0
      },
      districtDistribution: [],
      hotSpotRanking: [],
      activityTrend: [],
      mapPoints: [],
      mapGeoJson: null,
      chartLoading: true,
      mapLoading: true,
      heatMapChart: null,
      pointMapChart: null,
      selectedMapPoint: null,
      districtChart: null,
      hotSpotChart: null,
      trendChart: null
    }
  },
  computed: {
    currentDateText() {
      const now = new Date()
      const weekMap = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六']
      return `${now.getFullYear()}年${now.getMonth() + 1}月${now.getDate()}日 ${weekMap[now.getDay()]}`
    },
    metricCards() {
      return [
        {
          key: 'scenic',
          label: '景区总量',
          value: Number(this.statistics.scenicCount || 0),
          note: '当前后台已录入的景区资源数量',
          icon: 'el-icon-location',
          theme: 'metric-card--blue'
        },
        {
          key: 'venue',
          label: '场馆总量',
          value: Number(this.statistics.venueCount || 0),
          note: '包含博物馆、文化馆和综合场地',
          icon: 'el-icon-office-building',
          theme: 'metric-card--green'
        },
        {
          key: 'activity',
          label: '活动总量',
          value: Number(this.statistics.activityCount || 0),
          note: '统计后台已维护的活动数据',
          icon: 'el-icon-date',
          theme: 'metric-card--amber'
        },
        {
          key: 'coordinate',
          label: '坐标点位',
          value: this.mapPoints.length,
          note: '已具备地图标注能力的资源数量',
          icon: 'el-icon-map-location',
          theme: 'metric-card--rose'
        }
      ]
    },
    hasHeatMapData() {
      return this.districtDistribution.length > 0
    },
    hasPointMapData() {
      return this.mapPoints.length > 0
    },
    hasDistrictData() {
      return this.districtDistribution.length > 0
    },
    hasHotSpotData() {
      return this.hotSpotRanking.length > 0
    },
    hasTrendData() {
      return this.activityTrend.length > 0
    },
    dashboardSummary() {
      return `资源总量 ${this.resourceTotal}，待审核活动 ${this.statistics.pendingCount || 0} 条`
    },
    resourceTotal() {
      return Number(this.statistics.scenicCount || 0) + Number(this.statistics.venueCount || 0)
    },
    topHotSpotText() {
      if (!this.hotSpotRanking.length) {
        return '暂无'
      }
      return this.hotSpotRanking[0].name || '暂无'
    },
    topDistrictText() {
      if (!this.districtDistribution.length) {
        return '暂无'
      }
      return this.districtDistribution[0].district || '暂无'
    },
    mapSummary() {
      const scenicPointCount = this.mapPoints.filter(item => item.type === 'scenic').length
      const venuePointCount = this.mapPoints.filter(item => item.type === 'venue').length
      return `地图已标注 ${scenicPointCount} 个景区、${venuePointCount} 个场馆`
    },
    heatMapHint() {
      return this.districtDistribution.length ? `${this.districtDistribution.length} 个区县参与热力统计` : '按区县资源总量自动染色'
    },
    pointMapHint() {
      return this.mapPoints.length ? `${this.mapPoints.length} 个资源点位已完成坐标标注` : '坐标数据不足时会自动展示空态'
    },
    pendingTip() {
      const pending = Number(this.statistics.pendingCount || 0)
      if (!pending) {
        return '当前没有积压审核，适合继续完善基础资料和图片内容。'
      }
      if (pending >= 5) {
        return '待审核活动偏多，建议先清理审批队列，避免运营内容积压。'
      }
      return '待审核数量可控，处理后可继续补充热门资源内容。'
    },
    trendHint() {
      if (!this.activityTrend.length) {
        return '按活动开始时间或创建时间统计'
      }
      const latest = this.activityTrend[this.activityTrend.length - 1]
      return `最新月份 ${this.formatMonthLabel(latest.month)}：${latest.count || 0} 条`
    },
    operationTip() {
      if (Number(this.statistics.pendingCount || 0) > 0) {
        return `当前有 ${this.statistics.pendingCount} 条活动待审核，建议优先清理审批，再检查 ${this.topHotSpotText} 的内容是否需要更新。`
      }
      if (this.districtDistribution.length) {
        return `${this.topDistrictText} 当前资源相对集中，适合继续补充活动与资讯内容，形成更完整的运营闭环。`
      }
      return '目前真实数据还比较少，建议先补齐景区、场馆坐标和内容信息，让大屏能更完整反映业务状态。'
    }
  },
  mounted() {
    this.initDashboard()
    window.addEventListener('resize', this.handleResize)
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.handleResize)
    this.disposeCharts()
  },
  methods: {
    async initDashboard() {
      this.chartLoading = true
      this.mapLoading = true

      const [
        geoJson,
        statisticsRes,
        districtRes,
        hotSpotRes,
        trendRes,
        mapRes
      ] = await Promise.all([
        this.fetchMapJson().catch(() => null),
        getDashboardStatistics().catch(() => null),
        getDistrictDistribution().catch(() => null),
        getHotSpotRanking().catch(() => null),
        getActivityTrend().catch(() => null),
        getMapDistribution().catch(() => null)
      ])

      this.mapGeoJson = geoJson
      this.statistics = statisticsRes && statisticsRes.code === 200 && statisticsRes.data
        ? statisticsRes.data
        : this.statistics
      this.districtDistribution = this.normalizeArrayData(districtRes)
      this.hotSpotRanking = this.normalizeArrayData(hotSpotRes)
      this.activityTrend = this.normalizeArrayData(trendRes)
      this.mapPoints = this.normalizeArrayData(mapRes)
      this.selectedMapPoint = null

      this.chartLoading = false
      this.mapLoading = false

      this.$nextTick(() => {
        this.initCharts()
        this.renderAllCharts()
      })
    },
    fetchMapJson() {
      return window.fetch('/chongqing.json').then(response => {
        if (!response.ok) {
          throw new Error('地图数据加载失败')
        }
        return response.json()
      })
    },
    normalizeArrayData(response) {
      if (response && response.code === 200 && Array.isArray(response.data)) {
        return response.data
      }
      return []
    },
    initCharts() {
      if (this.$refs.heatMapChart && !this.heatMapChart) {
        this.heatMapChart = echarts.init(this.$refs.heatMapChart)
      }
      if (this.$refs.pointMapChart && !this.pointMapChart) {
        this.pointMapChart = echarts.init(this.$refs.pointMapChart)
      }
      if (this.$refs.districtChart && !this.districtChart) {
        this.districtChart = echarts.init(this.$refs.districtChart)
      }
      if (this.$refs.hotSpotChart && !this.hotSpotChart) {
        this.hotSpotChart = echarts.init(this.$refs.hotSpotChart)
      }
      if (this.$refs.trendChart && !this.trendChart) {
        this.trendChart = echarts.init(this.$refs.trendChart)
      }
    },
    renderAllCharts() {
      this.renderHeatMapChart()
      this.renderPointMapChart()
      this.renderDistrictChart()
      this.renderHotSpotChart()
      this.renderTrendChart()
    },
    renderHeatMapChart() {
      if (!this.heatMapChart || !this.mapGeoJson || !this.hasHeatMapData) {
        return
      }

      echarts.registerMap('chongqing-dashboard-heat', this.mapGeoJson)

      const districtMapData = this.districtDistribution.map(item => ({
        name: item.district,
        value: Number(item.scenicCount || 0) + Number(item.venueCount || 0),
        scenicCount: Number(item.scenicCount || 0),
        venueCount: Number(item.venueCount || 0)
      }))
      const maxDistrictValue = Math.max.apply(null, districtMapData.map(item => item.value).concat([1]))

      this.heatMapChart.setOption({
        backgroundColor: 'transparent',
        tooltip: {
          trigger: 'item',
          backgroundColor: 'rgba(27, 41, 61, 0.92)',
          borderWidth: 0,
          textStyle: {
            color: '#eef4ff'
          },
          formatter: params => {
            const data = params.data || {}
            return `${params.name}<br/>热度：${data.value || 0}<br/>景区：${data.scenicCount || 0}<br/>场馆：${data.venueCount || 0}`
          }
        },
        visualMap: {
          min: 0,
          max: maxDistrictValue,
          left: 12,
          bottom: 16,
          calculable: false,
          itemWidth: 12,
          itemHeight: 86,
          text: ['高', '低'],
          textStyle: {
            color: '#64748b'
          },
          inRange: {
            color: ['#f6efe6', '#efc88f', '#df8c56', '#b45b33']
          }
        },
        series: [
          {
            name: '区县资源热力',
            type: 'map',
            map: 'chongqing-dashboard-heat',
            data: districtMapData,
            roam: true,
            zoom: 1.08,
            selectedMode: false,
            itemStyle: {
              borderColor: 'rgba(74, 91, 120, 0.28)',
              borderWidth: 1,
              areaColor: '#f5f6f8'
            },
            emphasis: {
              itemStyle: {
                areaColor: '#e7a66e'
              },
              label: {
                show: true,
                color: '#23304a',
                fontWeight: 700
              }
            },
            label: {
              show: false
            }
          }
        ]
      }, true)
    },
    renderPointMapChart() {
      if (!this.pointMapChart || !this.mapGeoJson || !this.hasPointMapData) {
        return
      }

      echarts.registerMap('chongqing-dashboard-point', this.mapGeoJson)

      const scenicData = this.mapPoints
        .filter(item => item.type !== 'venue')
        .map((item, index) => this.formatMapPoint(item, index))
      const venueData = this.mapPoints
        .filter(item => item.type === 'venue')
        .map((item, index) => this.formatMapPoint(item, index + scenicData.length))

      this.pointMapChart.setOption({
        backgroundColor: 'transparent',
        tooltip: {
          trigger: 'item',
          backgroundColor: 'rgba(27, 41, 61, 0.92)',
          borderWidth: 0,
          textStyle: {
            color: '#eef4ff'
          },
          formatter: params => {
            const data = params.data || {}
            if (!data.name) {
              return params.name || ''
            }
            const typeLabel = data.type === 'venue' ? '场馆' : '景区'
            const extra = data.type === 'venue'
              ? `类型：${data.category || '未分类'}`
              : `等级：${data.level || '未评级'}`
            return `${data.name}<br/>${typeLabel}<br/>${extra}<br/>浏览量：${data.viewCount || 0}`
          }
        },
        legend: {
          top: 6,
          right: 10,
          itemWidth: 10,
          itemHeight: 10,
          textStyle: {
            color: '#64748b'
          }
        },
        geo: {
          map: 'chongqing-dashboard-point',
          roam: true,
          zoom: 1.14,
          itemStyle: {
            borderColor: 'rgba(74, 91, 120, 0.22)',
            borderWidth: 1,
            areaColor: '#f6f2ea'
          },
          emphasis: {
            itemStyle: {
              areaColor: '#ead9c3'
            },
            label: {
              color: '#23304a',
              fontWeight: 700
            }
          },
          label: {
            show: false
          }
        },
        series: [
          {
            name: '景区',
            type: 'effectScatter',
            coordinateSystem: 'geo',
            zlevel: 3,
            rippleEffect: {
              scale: 2.2,
              brushType: 'stroke'
            },
            symbolSize: value => this.pointSymbolSize(value),
            itemStyle: {
              color: '#b86b35',
              shadowBlur: 8,
              shadowColor: 'rgba(184, 107, 53, 0.28)'
            },
            data: scenicData
          },
          {
            name: '场馆',
            type: 'effectScatter',
            coordinateSystem: 'geo',
            zlevel: 3,
            rippleEffect: {
              scale: 2.2,
              brushType: 'stroke'
            },
            symbolSize: value => this.pointSymbolSize(value),
            itemStyle: {
              color: '#1f6a8f',
              shadowBlur: 8,
              shadowColor: 'rgba(31, 106, 143, 0.28)'
            },
            data: venueData
          }
        ]
      }, true)
      this.pointMapChart.off('click')
      this.pointMapChart.on('click', params => {
        if (params.seriesType === 'effectScatter' && params.data) {
          this.selectedMapPoint = params.data
        }
      })
    },
    formatMapPoint(item, index) {
      const offsets = [[0, 0], [8, -6], [-8, 6], [10, 6], [-10, -6], [0, 10], [0, -10], [14, 0], [-14, 0]]
      return {
        id: item.id,
        name: item.name,
        value: [Number(item.longitude), Number(item.latitude), Number(item.viewCount || 0)],
        type: item.type,
        level: item.level,
        category: item.category,
        district: item.district,
        address: item.address,
        description: item.description,
        coverImage: item.coverImage,
        viewCount: Number(item.viewCount || 0),
        symbolOffset: offsets[index % offsets.length]
      }
    },
    pointSymbolSize(value) {
      const base = Number(value[2] || 0)
      return Math.max(8, Math.min(base / 28 + 9, 15))
    },
    pointTypeLabel(point) {
      return point && point.type === 'venue' ? '场馆' : '景区'
    },
    pointMetaText(point) {
      if (!point) {
        return ''
      }
      if (point.type === 'venue') {
        return point.category || '未分类'
      }
      return point.level || '未评级'
    },
    pointDescription(point) {
      if (!point) {
        return ''
      }
      const text = this.plainText(point.description)
      if (text) {
        return text.length > 74 ? `${text.slice(0, 74)}...` : text
      }
      return point.address || '暂无简介，建议在资源详情中补充展示文案。'
    },
    plainText(value) {
      return (value || '').replace(/<[^>]+>/g, '').replace(/\s+/g, ' ').trim()
    },
    imageUrl(url) {
      const base = process.env.VUE_APP_BASE_API || ''
      if (!url) {
        return ''
      }
      if (/^(http|https):\/\//.test(url)) {
        return url
      }
      return `${base}${url}`
    },
    regionColor(value, maxValue) {
      if (!value) {
        return '#f5f6f8'
      }
      const ratio = value / Math.max(maxValue, 1)
      if (ratio >= 0.75) {
        return '#b45b33'
      }
      if (ratio >= 0.5) {
        return '#df8c56'
      }
      if (ratio >= 0.25) {
        return '#efc88f'
      }
      return '#f6efe6'
    },
    renderDistrictChart() {
      if (!this.districtChart || !this.hasDistrictData) {
        return
      }

      const list = this.districtDistribution.slice(0, 10)
      this.districtChart.setOption({
        backgroundColor: 'transparent',
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'shadow'
          }
        },
        legend: {
          top: 0,
          right: 0,
          textStyle: {
            color: '#64748b'
          }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '4%',
          top: 44,
          containLabel: true
        },
        xAxis: {
          type: 'value',
          splitLine: {
            lineStyle: {
              color: 'rgba(100, 116, 139, 0.12)'
            }
          },
          axisLine: {
            show: false
          },
          axisTick: {
            show: false
          },
          axisLabel: {
            color: '#64748b'
          }
        },
        yAxis: {
          type: 'category',
          inverse: true,
          data: list.map(item => item.district),
          axisLine: {
            show: false
          },
          axisTick: {
            show: false
          },
          axisLabel: {
            color: '#475569',
            width: 76,
            overflow: 'truncate'
          }
        },
        series: [
          {
            name: '景区',
            type: 'bar',
            stack: 'total',
            barMaxWidth: 16,
            data: list.map(item => Number(item.scenicCount || 0)),
            itemStyle: {
              borderRadius: [10, 0, 0, 10],
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: '#4f8df5' },
                { offset: 1, color: '#6eb5ff' }
              ])
            }
          },
          {
            name: '场馆',
            type: 'bar',
            stack: 'total',
            barMaxWidth: 16,
            data: list.map(item => Number(item.venueCount || 0)),
            itemStyle: {
              borderRadius: [0, 10, 10, 0],
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: '#36a56c' },
                { offset: 1, color: '#7fd3a5' }
              ])
            }
          }
        ]
      }, true)
    },
    renderHotSpotChart() {
      if (!this.hotSpotChart || !this.hasHotSpotData) {
        return
      }

      const list = this.hotSpotRanking.slice(0, 10)
      this.hotSpotChart.setOption({
        backgroundColor: 'transparent',
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'shadow'
          }
        },
        grid: {
          left: '4%',
          right: '4%',
          bottom: '4%',
          top: 14,
          containLabel: true
        },
        xAxis: {
          type: 'value',
          splitLine: {
            lineStyle: {
              color: 'rgba(100, 116, 139, 0.12)'
            }
          },
          axisLine: {
            show: false
          },
          axisTick: {
            show: false
          },
          axisLabel: {
            color: '#64748b'
          }
        },
        yAxis: {
          type: 'category',
          inverse: true,
          data: list.map(item => item.name),
          axisLine: {
            show: false
          },
          axisTick: {
            show: false
          },
          axisLabel: {
            color: '#475569'
          }
        },
        series: [
          {
            name: '浏览量',
            type: 'bar',
            data: list.map(item => Number(item.viewCount || 0)),
            barMaxWidth: 18,
            itemStyle: {
              borderRadius: [0, 10, 10, 0],
              color: new echarts.graphic.LinearGradient(1, 0, 0, 0, [
                { offset: 0, color: '#f1b24a' },
                { offset: 1, color: '#df6f39' }
              ])
            },
            label: {
              show: true,
              position: 'right',
              color: '#6b7280'
            }
          }
        ]
      }, true)
    },
    renderTrendChart() {
      if (!this.trendChart || !this.hasTrendData) {
        return
      }

      const xData = this.activityTrend.map(item => this.formatMonthLabel(item.month))
      const yData = this.activityTrend.map(item => Number(item.count || 0))

      this.trendChart.setOption({
        backgroundColor: 'transparent',
        tooltip: {
          trigger: 'axis'
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '4%',
          top: 18,
          containLabel: true
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: xData,
          axisLine: {
            lineStyle: {
              color: '#d8dee9'
            }
          },
          axisTick: {
            show: false
          },
          axisLabel: {
            color: '#64748b'
          }
        },
        yAxis: {
          type: 'value',
          splitLine: {
            lineStyle: {
              color: 'rgba(100, 116, 139, 0.12)'
            }
          },
          axisLine: {
            show: false
          },
          axisTick: {
            show: false
          },
          axisLabel: {
            color: '#64748b'
          }
        },
        series: [
          {
            name: '活动数量',
            type: 'line',
            smooth: true,
            symbol: 'circle',
            symbolSize: 8,
            data: yData,
            itemStyle: {
              color: '#2f6fed'
            },
            lineStyle: {
              width: 3,
              color: '#2f6fed'
            },
            areaStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: 'rgba(47, 111, 237, 0.28)' },
                { offset: 1, color: 'rgba(47, 111, 237, 0.02)' }
              ])
            }
          }
        ]
      }, true)
    },
    formatMonthLabel(value) {
      if (!value || typeof value !== 'string') {
        return value || ''
      }
      const match = value.match(/^(\d{4})-(\d{2})$/)
      if (match) {
        return `${match[1]}.${match[2]}`
      }
      return value
    },
    handleResize() {
      if (this.heatMapChart) {
        this.heatMapChart.resize()
      }
      if (this.pointMapChart) {
        this.pointMapChart.resize()
      }
      if (this.districtChart) {
        this.districtChart.resize()
      }
      if (this.hotSpotChart) {
        this.hotSpotChart.resize()
      }
      if (this.trendChart) {
        this.trendChart.resize()
      }
    },
    disposeCharts() {
      if (this.heatMapChart) {
        this.heatMapChart.dispose()
        this.heatMapChart = null
      }
      if (this.pointMapChart) {
        this.pointMapChart.dispose()
        this.pointMapChart = null
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
.tourism-dashboard {
  --bg: var(--tourism-bg);
  --panel: var(--tourism-surface);
  --line: var(--tourism-line);
  --text: var(--tourism-text);
  --muted: var(--tourism-muted);
  --shadow: var(--tourism-shadow);
  min-height: calc(100vh - 84px);
  padding: 24px;
  background: var(--bg);
  color: var(--text);
}

.hero {
  display: grid;
  grid-template-columns: minmax(0, 1.75fr) minmax(280px, 0.82fr);
  gap: 20px;
  padding: 28px;
  border-radius: 18px;
  background:
    radial-gradient(circle at top right, rgba(184, 107, 53, 0.16), transparent 28%),
    radial-gradient(circle at left bottom, rgba(31, 106, 143, 0.12), transparent 30%),
    linear-gradient(135deg, var(--tourism-warm-soft) 0%, #fffdf8 58%, #f3faf7 100%);
  box-shadow: var(--shadow);
  border: 1px solid var(--tourism-line);
}

.hero__eyebrow,
.panel__eyebrow,
.hero__panel-label {
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--tourism-warm);
}

.hero__title {
  margin: 10px 0 12px;
  font-size: 34px;
  line-height: 1.15;
  color: #1f2a44;
}

.hero__desc {
  max-width: 760px;
  margin: 0;
  font-size: 15px;
  line-height: 1.8;
  color: var(--muted);
}

.hero__meta {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 18px;
}

.hero__meta span {
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(35, 48, 74, 0.08);
  color: #486078;
  font-size: 13px;
}

.hero__panel {
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 22px;
  border-radius: 14px;
  background: linear-gradient(180deg, #24425f 0%, #19314b 100%);
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.1);
  color: #eef4ff;
}

.hero__panel-number {
  margin-top: 10px;
  font-size: 48px;
  font-weight: 700;
  line-height: 1;
}

.hero__panel-title {
  margin-top: 8px;
  font-size: 18px;
  font-weight: 600;
}

.hero__panel-tip {
  margin: 10px 0 18px;
  color: rgba(238, 244, 255, 0.76);
  line-height: 1.75;
  font-size: 13px;
}

.hero__panel-metrics {
  display: grid;
  gap: 12px;
}

.hero__panel-metrics div {
  padding: 12px 14px;
  border-radius: 10px;
  background: rgba(255, 255, 255, 0.08);
}

.hero__panel-metrics span {
  display: block;
  font-size: 12px;
  color: rgba(238, 244, 255, 0.7);
}

.hero__panel-metrics strong {
  display: block;
  margin-top: 4px;
  font-size: 15px;
  font-weight: 600;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 18px;
  margin-top: 20px;
}

.metric-card {
  padding: 20px;
  border-radius: 14px;
  background: var(--panel);
  border: 1px solid var(--line);
  box-shadow: var(--tourism-shadow-soft);
}

.metric-card__head {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.metric-card__label {
  font-size: 14px;
  color: var(--muted);
}

.metric-card__icon {
  font-size: 22px;
}

.metric-card__value {
  margin-top: 18px;
  font-size: 34px;
  font-weight: 700;
  color: #1f2a44;
}

.metric-card__foot {
  margin-top: 8px;
  font-size: 13px;
  line-height: 1.6;
  color: #748397;
}

.metric-card--blue .metric-card__icon { color: var(--tourism-accent); }
.metric-card--green .metric-card__icon { color: var(--tourism-green); }
.metric-card--amber .metric-card__icon { color: var(--tourism-warm); }
.metric-card--rose .metric-card__icon { color: var(--tourism-danger); }

.main-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 18px;
  margin-top: 20px;
}

.panel {
  padding: 22px;
  border-radius: 14px;
  background: var(--panel);
  border: 1px solid var(--line);
  box-shadow: var(--tourism-shadow-soft);
  min-width: 0;
  overflow: hidden;
}

.panel--wide {
  grid-column: span 2;
}

.panel--map .chart-surface,
.panel--map .panel__body--chart {
  min-height: 380px;
  height: 380px;
}

.panel__header {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 18px;
  min-width: 0;
}

.panel__title {
  margin: 6px 0 0;
  font-size: 22px;
  color: #1f2a44;
}

.panel__hint {
  font-size: 12px;
  color: #8492a6;
  max-width: 46%;
  text-align: right;
  line-height: 1.5;
}

.panel__body--chart {
  position: relative;
  min-height: 340px;
}

.chart-surface {
  width: 100%;
  height: 340px;
}

.panel--wide .chart-surface,
.panel--wide .panel__body--chart {
  min-height: 420px;
  height: 420px;
}

.chart-surface--hidden {
  visibility: hidden;
}

.chart-empty {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}

.point-card {
  position: absolute;
  right: 14px;
  bottom: 14px;
  width: min(320px, calc(100% - 28px));
  display: grid;
  grid-template-columns: 108px minmax(0, 1fr);
  gap: 12px;
  padding: 12px;
  border-radius: 12px;
  background: rgba(255, 253, 248, 0.96);
  border: 1px solid rgba(184, 107, 53, 0.16);
  box-shadow: 0 18px 42px rgba(42, 58, 86, 0.18);
  backdrop-filter: blur(10px);
  z-index: 4;
}

.point-card__close {
  position: absolute;
  top: 6px;
  right: 8px;
  width: 24px;
  height: 24px;
  border: none;
  border-radius: 50%;
  background: rgba(42, 58, 86, 0.08);
  color: #53627a;
  cursor: pointer;
  line-height: 24px;
  font-size: 18px;
}

.point-card__close:hover {
  background: rgba(184, 107, 53, 0.16);
  color: var(--tourism-warm);
}

.point-card__cover {
  height: 126px;
  border-radius: 10px;
  overflow: hidden;
  background: linear-gradient(135deg, #f6efe6 0%, #e4eef1 100%);
}

.point-card__cover img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.point-card__placeholder {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 700;
  color: var(--tourism-warm);
  letter-spacing: 4px;
}

.point-card__content {
  min-width: 0;
  padding-right: 18px;
}

.point-card__meta,
.point-card__foot {
  display: flex;
  align-items: center;
  gap: 8px;
  flex-wrap: wrap;
  font-size: 12px;
  color: #7b8798;
}

.point-card__meta span:first-child {
  padding: 3px 8px;
  border-radius: 999px;
  background: rgba(31, 106, 143, 0.1);
  color: #1f6a8f;
  font-weight: 700;
}

.point-card h4 {
  margin: 8px 0 6px;
  font-size: 16px;
  line-height: 1.35;
  color: #1f2a44;
}

.point-card p {
  margin: 0;
  min-height: 48px;
  font-size: 13px;
  line-height: 1.6;
  color: #5f6d82;
}

.point-card__foot {
  margin-top: 8px;
  justify-content: space-between;
}

.point-card-fade-enter-active,
.point-card-fade-leave-active {
  transition: opacity 0.18s ease, transform 0.18s ease;
}

.point-card-fade-enter,
.point-card-fade-leave-to {
  opacity: 0;
  transform: translateY(8px);
}

.insight-list {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.insight-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  padding-bottom: 12px;
  border-bottom: 1px dashed rgba(35, 48, 74, 0.1);
  font-size: 14px;
  color: #64748b;
}

.insight-item:last-child {
  border-bottom: none;
}

.insight-item strong {
  color: #1f2a44;
  font-weight: 700;
}

.notice-box {
  margin-top: 18px;
  padding: 16px 18px;
  border-radius: 12px;
  background: linear-gradient(135deg, var(--tourism-warm-soft) 0%, #f7fbfa 100%);
  border: 1px solid rgba(184, 107, 53, 0.16);
}

.notice-box__title {
  font-size: 14px;
  font-weight: 700;
  color: var(--tourism-warm);
}

.notice-box p {
  margin: 8px 0 0;
  font-size: 13px;
  line-height: 1.75;
  color: #5e6b80;
}

@media (max-width: 1200px) {
  .stats-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

@media (max-width: 992px) {
  .hero,
  .main-grid {
    grid-template-columns: 1fr;
  }

  .panel--wide {
    grid-column: span 1;
  }

  .panel--map .chart-surface,
  .panel--map .panel__body--chart,
  .panel--wide .chart-surface,
  .panel--wide .panel__body--chart {
    min-height: 360px;
    height: 360px;
  }
}

@media (max-width: 768px) {
  .tourism-dashboard {
    padding: 16px;
  }

  .hero {
    padding: 20px;
  }

  .hero__title {
    font-size: 28px;
  }

  .stats-grid {
    grid-template-columns: 1fr;
  }

  .panel {
    padding: 18px;
  }

  .chart-surface,
  .panel__body--chart,
  .panel--map .chart-surface,
  .panel--map .panel__body--chart,
  .panel--wide .chart-surface,
  .panel--wide .panel__body--chart {
    min-height: 300px;
    height: 300px;
  }

  .point-card {
    left: 12px;
    right: 12px;
    bottom: 12px;
    width: auto;
    grid-template-columns: 88px minmax(0, 1fr);
  }

  .point-card__cover {
    height: 112px;
  }
}
</style>
