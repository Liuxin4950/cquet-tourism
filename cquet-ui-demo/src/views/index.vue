<template>
  <div class="app-container tourism-home">
    <section class="hero">
      <div class="hero__content">
        <div class="hero__eyebrow">重庆文旅后台总览</div>
        <h1 class="hero__title">{{ greeting }}，{{ name || '管理员' }}</h1>
        <p class="hero__desc">
          把景区、场馆、活动和内容运营放到同一个首页里，进入系统就能先看到今天最值得处理的事项。
        </p>
        <div class="hero__meta">
          <span>{{ currentDateText }}</span>
          <span>系统版本 v{{ version }}</span>
          <span>{{ dashboardSummary }}</span>
        </div>
      </div>
      <div class="hero__panel">
        <div class="hero__panel-label">今日关注</div>
        <div class="hero__panel-number">{{ pendingCount }}</div>
        <div class="hero__panel-title">待处理活动审批</div>
        <p class="hero__panel-tip">
          {{ pendingTip }}
        </p>
        <el-button
          v-if="canVisit('/tourism/activityApplication')"
          type="primary"
          size="mini"
          round
          @click="goPage('/tourism/activityApplication')"
        >
          立即处理
        </el-button>
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
        <count-to
          class="metric-card__value"
          :start-val="0"
          :end-val="Number(card.value || 0)"
          :duration="900"
        />
        <div class="metric-card__foot">{{ card.note }}</div>
      </article>
    </section>

    <section class="main-grid">
      <div class="panel panel--wide">
        <div class="panel__header">
          <div>
            <div class="panel__eyebrow">Quick Access</div>
            <h3 class="panel__title">常用管理入口</h3>
          </div>
          <span class="panel__hint">根据当前账号权限自动显示</span>
        </div>
        <div class="quick-grid">
          <button
            v-for="item in availableQuickLinks"
            :key="item.path"
            class="quick-card"
            type="button"
            @click="goPage(item.path)"
          >
            <div class="quick-card__icon">
              <i :class="item.icon" />
            </div>
            <div class="quick-card__body">
              <div class="quick-card__title">{{ item.title }}</div>
              <div class="quick-card__desc">{{ item.desc }}</div>
            </div>
          </button>
        </div>
      </div>

      <div class="panel">
        <div class="panel__header">
          <div>
            <div class="panel__eyebrow">Hot Ranking</div>
            <h3 class="panel__title">热门景区排行</h3>
          </div>
        </div>
        <div v-if="hotSpotList.length" class="rank-list">
          <div
            v-for="(item, index) in hotSpotList"
            :key="item.name + index"
            class="rank-item"
          >
            <div class="rank-item__head">
              <span class="rank-item__index">{{ index + 1 }}</span>
              <div class="rank-item__main">
                <div class="rank-item__name">{{ item.name }}</div>
                <div class="rank-item__meta">{{ item.level || '未评级' }} · 收藏 {{ item.collectionCount || 0 }}</div>
              </div>
              <div class="rank-item__value">{{ item.viewCount || 0 }}</div>
            </div>
            <div class="rank-item__bar">
              <span :style="{ width: rankBarWidth(item.viewCount) }" />
            </div>
          </div>
        </div>
        <el-empty v-else :image-size="84" description="暂无热度数据" />
      </div>

      <div class="panel">
        <div class="panel__header">
          <div>
            <div class="panel__eyebrow">District Pulse</div>
            <h3 class="panel__title">区县分布概览</h3>
          </div>
        </div>
        <div v-if="districtList.length" class="district-list">
          <div
            v-for="item in districtPreview"
            :key="item.district"
            class="district-item"
          >
            <div>
              <div class="district-item__name">{{ item.district }}</div>
              <div class="district-item__meta">景区 {{ item.scenicCount || 0 }} · 场馆 {{ item.venueCount || 0 }}</div>
            </div>
            <div class="district-item__total">{{ districtTotal(item) }}</div>
          </div>
        </div>
        <el-empty v-else :image-size="84" description="暂无区县分布数据" />
      </div>

      <div class="panel">
        <div class="panel__header">
          <div>
            <div class="panel__eyebrow">Activity Trend</div>
            <h3 class="panel__title">近月活动趋势</h3>
          </div>
        </div>
        <div v-if="trendPreview.length" class="trend-list">
          <div
            v-for="item in trendPreview"
            :key="item.month"
            class="trend-item"
          >
            <span class="trend-item__month">{{ item.month }}</span>
            <div class="trend-item__bar">
              <span :style="{ width: trendBarWidth(item.count) }" />
            </div>
            <span class="trend-item__count">{{ item.count || 0 }}</span>
          </div>
        </div>
        <el-empty v-else :image-size="84" description="暂无趋势数据" />
      </div>

      <div class="panel">
        <div class="panel__header">
          <div>
            <div class="panel__eyebrow">System Snapshot</div>
            <h3 class="panel__title">系统状态</h3>
          </div>
        </div>
        <div class="snapshot-list">
          <div class="snapshot-item">
            <span>当前登录</span>
            <strong>{{ name || '管理员' }}</strong>
          </div>
          <div class="snapshot-item">
            <span>账号角色</span>
            <strong>{{ roleSummary }}</strong>
          </div>
          <div class="snapshot-item">
            <span>可用权限数</span>
            <strong>{{ permissionCount }}</strong>
          </div>
          <div class="snapshot-item">
            <span>可访问模块</span>
            <strong>{{ availableQuickLinks.length }}</strong>
          </div>
        </div>
        <div class="notice-box">
          <div class="notice-box__title">运营建议</div>
          <p>{{ operationTip }}</p>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import CountTo from 'vue-count-to'
import auth from '@/plugins/auth'
import {
  getActivityTrend,
  getDashboardStatistics,
  getDistrictDistribution,
  getHotSpotRanking
} from '@/api/tourism/dashboard'

export default {
  name: 'Index',
  components: {
    CountTo
  },
  data() {
    return {
      version: '1.0.0',
      statistics: {
        scenicCount: 0,
        venueCount: 0,
        activityCount: 0,
        pendingCount: 0
      },
      hotSpotList: [],
      districtList: [],
      trendList: [],
      quickLinks: [
        {
          title: '景区管理',
          desc: '维护 A 级景区资料、封面与详情',
          path: '/tourism/scenicSpot',
          perm: 'tourism:scenicSpot:list',
          icon: 'el-icon-location-outline'
        },
        {
          title: '场馆管理',
          desc: '管理文化场馆、预约与空间信息',
          path: '/tourism/venue',
          perm: 'tourism:venue:list',
          icon: 'el-icon-school'
        },
        {
          title: '活动管理',
          desc: '查看特色活动、启停状态与详情',
          path: '/tourism/activity',
          perm: 'tourism:activity:list',
          icon: 'el-icon-date'
        },
        {
          title: '活动审核',
          desc: '集中处理待审活动和审批意见',
          path: '/tourism/activityApplication',
          perm: 'tourism:activityApplication:list',
          icon: 'el-icon-document-checked'
        },
        {
          title: '新闻管理',
          desc: '发布重庆文旅资讯和运营内容',
          path: '/tourism/news',
          perm: 'tourism:news:list',
          icon: 'el-icon-reading'
        },
        {
          title: '通知管理',
          desc: '维护公告、通知和重要提醒',
          path: '/tourism/notice',
          perm: 'tourism:notice:list',
          icon: 'el-icon-message'
        },
        {
          title: '图片管理',
          desc: '统一维护景区与场馆图片素材',
          path: '/tourism/images',
          perm: 'tourism:image:list',
          icon: 'el-icon-picture-outline'
        },
        {
          title: '设施管理',
          desc: '配置场馆配套设施与基础能力',
          path: '/tourism/facilities',
          perm: 'tourism:facilities:list',
          icon: 'el-icon-office-building'
        }
      ]
    }
  },
  computed: {
    ...mapGetters(['name', 'roles', 'permissions']),
    greeting() {
      const hour = new Date().getHours()
      if (hour < 12) return '上午好'
      if (hour < 18) return '下午好'
      return '晚上好'
    },
    currentDateText() {
      const now = new Date()
      const weekMap = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六']
      return `${now.getFullYear()}年${now.getMonth() + 1}月${now.getDate()}日 ${weekMap[now.getDay()]}`
    },
    pendingCount() {
      return Number(this.statistics.pendingCount || 0)
    },
    dashboardSummary() {
      return `已接入 ${this.statistics.scenicCount || 0} 个景区、${this.statistics.venueCount || 0} 个场馆`
    },
    pendingTip() {
      if (!this.pendingCount) {
        return '当前没有积压审批，适合继续完善内容和基础数据。'
      }
      if (this.pendingCount > 8) {
        return '待处理数量较高，建议优先清理审核队列，避免活动发布延迟。'
      }
      return '审批量处于可控区间，建议今天优先处理最近提交的活动。'
    },
    metricCards() {
      return [
        {
          key: 'scenic',
          label: '景区总量',
          value: this.statistics.scenicCount,
          note: '覆盖 A 级景区与重点景点资料',
          icon: 'el-icon-location',
          theme: 'metric-card--blue'
        },
        {
          key: 'venue',
          label: '场馆总量',
          value: this.statistics.venueCount,
          note: '含文化馆、博物馆与综合场地',
          icon: 'el-icon-school',
          theme: 'metric-card--green'
        },
        {
          key: 'activity',
          label: '活动总量',
          value: this.statistics.activityCount,
          note: '活动内容、运营状态与时间安排',
          icon: 'el-icon-date',
          theme: 'metric-card--amber'
        },
        {
          key: 'pending',
          label: '待审活动',
          value: this.statistics.pendingCount,
          note: '建议优先处理影响上线的待审内容',
          icon: 'el-icon-warning-outline',
          theme: 'metric-card--rose'
        }
      ]
    },
    availableQuickLinks() {
      return this.quickLinks.filter(item => auth.hasPermi(item.perm))
    },
    districtPreview() {
      return this.districtList.slice(0, 6)
    },
    trendPreview() {
      return this.trendList.slice(-6)
    },
    roleSummary() {
      if (!this.roles || !this.roles.length) return '未识别'
      return this.roles.join(' / ')
    },
    permissionCount() {
      return (this.permissions || []).length
    },
    operationTip() {
      if (this.pendingCount > 0) {
        return `首页已经识别到 ${this.pendingCount} 条待审活动，建议先处理审核，再检查热门景区内容是否需要更新。`
      }
      if (this.hotSpotList.length) {
        return `当前热度最高的是“${this.hotSpotList[0].name}”，可以围绕热门景区继续补充活动与公告内容。`
      }
      return '首页数据已准备好，建议优先完善景区、场馆和活动基础资料，逐步形成运营节奏。'
    }
  },
  created() {
    this.loadHomeData()
  },
  methods: {
    loadHomeData() {
      if (auth.hasPermi('tourism:dashboard:statistics')) {
        getDashboardStatistics().then(res => {
          this.statistics = res.data || this.statistics
        }).catch(() => {})
      }
      if (auth.hasPermi('tourism:dashboard:hotspot')) {
        getHotSpotRanking().then(res => {
          this.hotSpotList = Array.isArray(res.data) ? res.data : []
        }).catch(() => {})
      }
      if (auth.hasPermi('tourism:dashboard:district')) {
        getDistrictDistribution().then(res => {
          this.districtList = Array.isArray(res.data) ? res.data : []
        }).catch(() => {})
      }
      if (auth.hasPermi('tourism:dashboard:trend')) {
        getActivityTrend().then(res => {
          this.trendList = Array.isArray(res.data) ? res.data : []
        }).catch(() => {})
      }
    },
    goPage(path) {
      if (!path) return
      this.$router.push(path)
    },
    canVisit(path) {
      return this.availableQuickLinks.some(item => item.path === path)
    },
    rankBarWidth(value) {
      const max = this.hotSpotList.length
        ? Math.max(...this.hotSpotList.map(item => Number(item.viewCount || 0)), 1)
        : 1
      const percent = (Number(value || 0) / max) * 100
      return `${Math.max(percent, 8)}%`
    },
    trendBarWidth(value) {
      const max = this.trendList.length
        ? Math.max(...this.trendList.map(item => Number(item.count || 0)), 1)
        : 1
      const percent = (Number(value || 0) / max) * 100
      return `${Math.max(percent, 10)}%`
    },
    districtTotal(item) {
      return Number(item.scenicCount || 0) + Number(item.venueCount || 0)
    }
  }
}
</script>

<style scoped lang="scss">
.tourism-home {
  --bg: linear-gradient(180deg, #f4efe6 0%, #f7f9fc 42%, #fcfbf7 100%);
  --panel: rgba(255, 255, 255, 0.9);
  --line: rgba(34, 48, 74, 0.08);
  --text: #23304a;
  --muted: #64748b;
  --shadow: 0 18px 40px rgba(36, 54, 86, 0.08);
  min-height: calc(100vh - 84px);
  padding: 24px;
  background: var(--bg);
  color: var(--text);
}

.hero {
  display: grid;
  grid-template-columns: minmax(0, 1.7fr) minmax(260px, 0.8fr);
  gap: 20px;
  padding: 28px;
  border-radius: 28px;
  background:
    radial-gradient(circle at top right, rgba(227, 96, 54, 0.18), transparent 28%),
    radial-gradient(circle at left bottom, rgba(41, 125, 93, 0.16), transparent 30%),
    linear-gradient(135deg, #fff8ee 0%, #ffffff 58%, #f4f8f7 100%);
  box-shadow: var(--shadow);
  border: 1px solid rgba(228, 102, 59, 0.08);
}

.hero__eyebrow,
.panel__eyebrow,
.hero__panel-label {
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: #b45b33;
}

.hero__title {
  margin: 10px 0 12px;
  font-size: 34px;
  line-height: 1.15;
  color: #1f2a44;
}

.hero__desc {
  max-width: 720px;
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
  background: rgba(255, 255, 255, 0.78);
  border: 1px solid rgba(35, 48, 74, 0.08);
  color: #486078;
  font-size: 13px;
}

.hero__panel {
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 22px;
  border-radius: 22px;
  background: linear-gradient(180deg, #223e63 0%, #172c47 100%);
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

.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 18px;
  margin-top: 20px;
}

.metric-card {
  padding: 20px;
  border-radius: 22px;
  background: var(--panel);
  border: 1px solid var(--line);
  box-shadow: var(--shadow);
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
  font-size: 20px;
}

.metric-card__value {
  display: block;
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

.metric-card--blue .metric-card__icon { color: #2f6fed; }
.metric-card--green .metric-card__icon { color: #2f9d73; }
.metric-card--amber .metric-card__icon { color: #d48522; }
.metric-card--rose .metric-card__icon { color: #d0575d; }

.main-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 18px;
  margin-top: 20px;
}

.panel {
  padding: 22px;
  border-radius: 24px;
  background: var(--panel);
  border: 1px solid var(--line);
  box-shadow: var(--shadow);
}

.panel--wide {
  grid-column: span 2;
}

.panel__header {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 18px;
}

.panel__title {
  margin: 6px 0 0;
  font-size: 22px;
  color: #1f2a44;
}

.panel__hint {
  font-size: 12px;
  color: #8492a6;
}

.quick-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 14px;
}

.quick-card {
  display: flex;
  align-items: flex-start;
  gap: 14px;
  width: 100%;
  padding: 18px;
  border: 1px solid rgba(35, 48, 74, 0.08);
  border-radius: 18px;
  background: linear-gradient(180deg, #ffffff 0%, #f8fafc 100%);
  cursor: pointer;
  text-align: left;
  transition: transform 0.18s ease, box-shadow 0.18s ease, border-color 0.18s ease;
}

.quick-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 16px 28px rgba(36, 54, 86, 0.08);
  border-color: rgba(228, 102, 59, 0.28);
}

.quick-card__icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 46px;
  height: 46px;
  border-radius: 14px;
  background: linear-gradient(135deg, #fbede2 0%, #eef5f3 100%);
  color: #b45b33;
  font-size: 20px;
}

.quick-card__title {
  font-size: 16px;
  font-weight: 600;
  color: #1f2a44;
}

.quick-card__desc {
  margin-top: 5px;
  font-size: 13px;
  line-height: 1.6;
  color: #718096;
}

.rank-list,
.district-list,
.trend-list,
.snapshot-list {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.rank-item__head,
.district-item,
.trend-item,
.snapshot-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
}

.rank-item__index {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background: #f3e5da;
  color: #b45b33;
  font-weight: 700;
  flex-shrink: 0;
}

.rank-item__head {
  align-items: flex-start;
}

.rank-item__main {
  flex: 1;
}

.rank-item__name,
.district-item__name {
  font-size: 15px;
  font-weight: 600;
  color: #22304a;
}

.rank-item__meta,
.district-item__meta {
  margin-top: 4px;
  font-size: 12px;
  color: #7b8798;
}

.rank-item__value,
.district-item__total,
.trend-item__count,
.snapshot-item strong {
  font-weight: 700;
  color: #1f2a44;
}

.rank-item__bar,
.trend-item__bar {
  height: 8px;
  margin-top: 8px;
  border-radius: 999px;
  background: #edf2f7;
  overflow: hidden;
}

.rank-item__bar span,
.trend-item__bar span {
  display: block;
  height: 100%;
  border-radius: inherit;
  background: linear-gradient(90deg, #df6f39 0%, #f0b24b 100%);
}

.trend-item__month {
  width: 42px;
  flex-shrink: 0;
  color: #64748b;
  font-size: 13px;
}

.trend-item__bar {
  flex: 1;
  margin-top: 0;
}

.snapshot-item {
  padding: 12px 0;
  border-bottom: 1px dashed rgba(35, 48, 74, 0.1);
  font-size: 14px;
  color: #64748b;
}

.snapshot-item:last-child {
  border-bottom: none;
}

.notice-box {
  margin-top: 18px;
  padding: 16px 18px;
  border-radius: 18px;
  background: linear-gradient(135deg, #fff4e8 0%, #f7fbfa 100%);
  border: 1px solid rgba(228, 102, 59, 0.12);
}

.notice-box__title {
  font-size: 14px;
  font-weight: 700;
  color: #a74f2d;
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

  .quick-grid {
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
}

@media (max-width: 768px) {
  .tourism-home {
    padding: 16px;
  }

  .hero {
    padding: 20px;
  }

  .hero__title {
    font-size: 28px;
  }

  .stats-grid,
  .quick-grid {
    grid-template-columns: 1fr;
  }

  .panel {
    padding: 18px;
  }
}
</style>
