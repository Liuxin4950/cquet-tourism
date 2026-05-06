<template>
  <div class="login-page">
    <!-- 左侧：品牌展示区 -->
    <div class="login-brand">
      <!-- 装饰元素 -->
      <div class="brand-decoration">
        <div class="decoration-circle circle-1"></div>
        <div class="decoration-circle circle-2"></div>
        <div class="decoration-circle circle-3"></div>
        <div class="decoration-line line-1"></div>
        <div class="decoration-line line-2"></div>
        <div class="decoration-line line-3"></div>
      </div>

      <div class="brand-content">
        <!-- Logo -->
        <div class="brand-logo">
          <div class="logo-icon">
            <svg-icon icon-class="dashboard" />
          </div>
          <span class="logo-text">文旅管理系统</span>
        </div>

        <!-- 主标题 -->
        <h1 class="brand-title">智慧文旅管理平台</h1>
        <p class="brand-subtitle">重庆文旅资源一站式管理与数据服务平台</p>

        <!-- 说明文案 -->
        <p class="brand-desc">
          集中管理景区、场馆、特色活动、新闻公告与图片资源，<br>
          让文旅内容维护、活动审核和数据统计更加清晰高效。
        </p>

        <!-- 功能标签 -->
        <div class="brand-tags">
          <span class="tag-item">文旅资源管理</span>
          <span class="tag-item">活动审核</span>
          <span class="tag-item">数据看板</span>
          <span class="tag-item">地图定位</span>
        </div>

        <!-- 底部英文 -->
        <div class="brand-footer">
          Chongqing Cultural Tourism Management System
        </div>
      </div>
    </div>

    <!-- 右侧：登录表单区 -->
    <div class="login-panel">
      <div class="login-card">
        <!-- 移动端 Logo -->
        <div class="mobile-logo">
          <div class="logo-icon">
            <svg-icon icon-class="dashboard" />
          </div>
          <span class="logo-text">文旅管理系统</span>
        </div>

        <!-- 标题 -->
        <div class="login-header">
          <h1 class="login-title">欢迎登录</h1>
          <p class="login-subtitle">请使用管理员账号进入文旅管理后台</p>
        </div>

        <!-- 登录表单 -->
        <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form">
          <el-form-item prop="username">
            <div class="input-label">账号</div>
            <el-input
              v-model="loginForm.username"
              type="text"
              auto-complete="off"
              placeholder="请输入管理员账号"
            >
              <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
            </el-input>
          </el-form-item>

          <el-form-item prop="password">
            <div class="input-label">密码</div>
            <el-input
              v-model="loginForm.password"
              :type="showPassword ? 'text' : 'password'"
              auto-complete="off"
              placeholder="请输入密码"
              @keyup.enter.native="handleLogin"
            >
              <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
              <div slot="suffix" class="password-toggle" @click="showPassword = !showPassword">
                <svg-icon v-if="!showPassword" icon-class="eye" class="el-input__icon" />
                <svg-icon v-else icon-class="eye-open" class="el-input__icon" />
              </div>
            </el-input>
          </el-form-item>

          <el-form-item prop="code" v-if="captchaEnabled">
            <div class="input-label">验证码</div>
            <div class="code-input-wrapper">
              <el-input
                v-model="loginForm.code"
                auto-complete="off"
                placeholder="请输入验证码"
                @keyup.enter.native="handleLogin"
              >
                <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
              </el-input>
              <div class="login-code" @click="getCode">
                <img :src="codeUrl" class="login-code-img" alt="验证码"/>
              </div>
            </div>
          </el-form-item>

          <div class="login-options">
            <el-checkbox v-model="loginForm.rememberMe">记住密码</el-checkbox>
          </div>

          <el-form-item>
            <el-button
              :loading="loading"
              class="login-button"
              @click.native.prevent="handleLogin"
            >
              <span v-if="!loading">登 录 系 统</span>
              <span v-else>登 录 中...</span>
            </el-button>
          </el-form-item>

          <div class="login-register" v-if="register">
            <span>没有账号？</span>
            <router-link :to="'/register'">立即注册</router-link>
          </div>
        </el-form>

        <!-- 底部版权 -->
        <div class="login-copyright">
          <p>Copyright &copy; 2026 重庆文旅管理系统</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getCodeImg } from "@/api/login";
import Cookies from "js-cookie";
import { encrypt, decrypt } from '@/utils/jsencrypt'

export default {
  name: "Login",
  data() {
    return {
      codeUrl: "",
      loginForm: {
        username: "admin",
        password: "admin123",
        rememberMe: false,
        code: "",
        uuid: ""
      },
      loginRules: {
        username: [
          { required: true, trigger: "blur", message: "请输入您的账号" }
        ],
        password: [
          { required: true, trigger: "blur", message: "请输入您的密码" }
        ],
        code: [{ required: true, trigger: "change", message: "请输入验证码" }]
      },
      loading: false,
      showPassword: false,
      // 验证码开关
      captchaEnabled: true,
      // 注册开关
      register: true,
      redirect: undefined
    };
  },
  watch: {
    $route: {
      handler: function(route) {
        this.redirect = route.query && route.query.redirect;
      },
      immediate: true
    }
  },
  created() {
    this.getCode();
    this.getCookie();
  },
  methods: {
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled;
        if (this.captchaEnabled) {
          this.codeUrl = "data:image/gif;base64," + res.img;
          this.loginForm.uuid = res.uuid;
        }
      });
    },
    getCookie() {
      const username = Cookies.get("username");
      const password = Cookies.get("password");
      const rememberMe = Cookies.get('rememberMe')
      this.loginForm = {
        username: username === undefined ? this.loginForm.username : username,
        password: password === undefined ? this.loginForm.password : decrypt(password),
        rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
      };
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true;
          if (this.loginForm.rememberMe) {
            Cookies.set("username", this.loginForm.username, { expires: 30 });
            Cookies.set("password", encrypt(this.loginForm.password), { expires: 30 });
            Cookies.set('rememberMe', this.loginForm.rememberMe, { expires: 30 });
          } else {
            Cookies.remove("username");
            Cookies.remove("password");
            Cookies.remove('rememberMe');
          }
          this.$store.dispatch("Login", this.loginForm).then(() => {
            this.$router.push({ path: this.redirect || "/" }).catch(()=>{});
          }).catch(() => {
            this.loading = false;
            if (this.captchaEnabled) {
              this.getCode();
            }
          });
        }
      });
    }
  }
};
</script>

<style rel="stylesheet/scss" lang="scss">
// 主色调
$brand-dark: #0B3A75;
$brand-mid: #0F6E9E;
$brand-light: #13B8A6;
$text-dark: #1a2a3a;
$text-body: #4a5568;
$text-muted: #718096;
$border-color: #e2e8f0;

// 容器
.login-page {
  display: flex;
  min-height: 100vh;
  background: #f0f4f8;
}

// 左侧品牌展示区
.login-brand {
  width: 54%;
  background: linear-gradient(135deg, $brand-dark 0%, $brand-mid 48%, $brand-light 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
  padding: 60px;

  @media (max-width: 1200px) {
    width: 50%;
  }

  @media (max-width: 992px) {
    display: none;
  }
}

// 装饰元素
.brand-decoration {
  position: absolute;
  inset: 0;
  pointer-events: none;

  .decoration-circle {
    position: absolute;
    border-radius: 50%;
    border: 1px solid rgba(255, 255, 255, 0.1);

    &.circle-1 {
      width: 400px;
      height: 400px;
      top: -100px;
      right: -100px;
      animation: float 20s ease-in-out infinite;
    }

    &.circle-2 {
      width: 300px;
      height: 300px;
      bottom: -50px;
      left: -50px;
      animation: float 15s ease-in-out infinite reverse;
    }

    &.circle-3 {
      width: 200px;
      height: 200px;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      animation: pulse 10s ease-in-out infinite;
    }
  }

  .decoration-line {
    position: absolute;
    height: 1px;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);

    &.line-1 {
      width: 80%;
      top: 30%;
      left: 10%;
      animation: shimmer 8s ease-in-out infinite;
    }

    &.line-2 {
      width: 60%;
      top: 50%;
      left: 20%;
      animation: shimmer 6s ease-in-out infinite 2s;
    }

    &.line-3 {
      width: 70%;
      top: 70%;
      left: 15%;
      animation: shimmer 7s ease-in-out infinite 4s;
    }
  }
}

@keyframes float {
  0%, 100% { transform: translate(0, 0); }
  50% { transform: translate(20px, 20px); }
}

@keyframes pulse {
  0%, 100% { transform: translate(-50%, -50%) scale(1); opacity: 0.5; }
  50% { transform: translate(-50%, -50%) scale(1.1); opacity: 0.8; }
}

@keyframes shimmer {
  0%, 100% { opacity: 0.3; transform: translateX(-10%); }
  50% { opacity: 0.6; transform: translateX(10%); }
}

.brand-content {
  position: relative;
  z-index: 10;
  color: #ffffff;
  max-width: 520px;
}

.brand-logo {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 48px;

  .logo-icon {
    width: 48px;
    height: 48px;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #ffffff;
    font-size: 24px;
    backdrop-filter: blur(10px);
  }

  .logo-text {
    font-size: 18px;
    font-weight: 600;
    letter-spacing: 2px;
  }
}

.brand-title {
  font-size: 38px;
  font-weight: 700;
  margin-bottom: 12px;
  letter-spacing: 2px;
  line-height: 1.2;
}

.brand-subtitle {
  font-size: 18px;
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 28px;
  font-weight: 500;
}

.brand-desc {
  font-size: 15px;
  color: rgba(255, 255, 255, 0.75);
  line-height: 1.8;
  margin-bottom: 36px;
}

.brand-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-bottom: 60px;

  .tag-item {
    padding: 10px 20px;
    background: rgba(255, 255, 255, 0.15);
    border-radius: 100px;
    font-size: 14px;
    font-weight: 500;
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.2);
    transition: all 0.3s ease;

    &:hover {
      background: rgba(255, 255, 255, 0.25);
      transform: translateY(-2px);
    }
  }
}

.brand-footer {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.5);
  letter-spacing: 1px;
}

// 右侧登录面板
.login-panel {
  width: 46%;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 40px;
  background: linear-gradient(135deg, #f6fbff 0%, #eef7ff 100%);

  @media (max-width: 1200px) {
    width: 50%;
  }

  @media (max-width: 992px) {
    width: 100%;
  }
}

.login-card {
  width: 100%;
  max-width: 440px;
  background: rgba(255, 255, 255, 0.92);
  border-radius: 24px;
  padding: 48px 40px;
  box-shadow: 0 24px 60px rgba(15, 58, 107, 0.16);
  backdrop-filter: blur(12px);
}

// 移动端 Logo
.mobile-logo {
  display: none;
  align-items: center;
  justify-content: center;
  gap: 10px;
  margin-bottom: 32px;

  @media (max-width: 992px) {
    display: flex;
  }

  .logo-icon {
    width: 44px;
    height: 44px;
    background: linear-gradient(135deg, $brand-dark, $brand-mid);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #ffffff;
    font-size: 22px;
  }

  .logo-text {
    font-size: 20px;
    font-weight: 600;
    color: $brand-dark;
  }
}

// 登录头部
.login-header {
  text-align: center;
  margin-bottom: 36px;
}

.login-title {
  font-size: 28px;
  font-weight: 700;
  color: $text-dark;
  margin-bottom: 8px;
}

.login-subtitle {
  font-size: 14px;
  color: $text-muted;
}

// 表单样式
.login-form {
  .el-form-item {
    margin-bottom: 24px;
  }

  .input-label {
    font-size: 14px;
    font-weight: 600;
    color: $text-dark;
    margin-bottom: 10px;
  }

  .el-input {
    height: 50px;

    ::v-deep .el-input__inner {
      height: 50px;
      border-radius: 12px;
      border: 1px solid $border-color;
      padding: 0 16px 0 44px;
      font-size: 14px;
      color: $text-dark;
      transition: all 0.3s ease;
      background: #ffffff;

      &::placeholder {
        color: #a0aec0;
      }

      &:focus {
        border-color: $brand-mid;
        box-shadow: 0 0 0 3px rgba($brand-mid, 0.1);
      }
    }

    ::v-deep .el-input__prefix {
      left: 14px;
      color: #a0aec0;
    }

    ::v-deep .el-input__icon {
      &.input-icon {
        font-size: 18px;
      }
    }

    ::v-deep .el-input__suffix {
      right: 14px;
    }
  }

  .password-toggle {
    cursor: pointer;
    color: #a0aec0;
    transition: color 0.2s ease;
    display: flex;
    align-items: center;
    height: 100%;

    &:hover {
      color: $brand-mid;
    }

    .svg-icon {
      font-size: 18px;
    }
  }
}

// 验证码
.code-input-wrapper {
  display: flex;
  gap: 12px;

  .el-input {
    flex: 1;
  }

  .login-code {
    width: 120px;
    height: 50px;
    border-radius: 12px;
    overflow: hidden;
    cursor: pointer;
    border: 1px solid $border-color;
    transition: all 0.3s ease;
    flex-shrink: 0;

    &:hover {
      border-color: $brand-mid;
      box-shadow: 0 4px 12px rgba($brand-mid, 0.15);
    }

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  }
}

// 表单选项
.login-options {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 28px;

  .el-checkbox {
    ::v-deep .el-checkbox__label {
      font-size: 14px;
      color: $text-body;
    }

    ::v-deep .el-checkbox__input {
      .el-checkbox__inner {
        border-color: $border-color;
        border-radius: 4px;

        &:hover {
          border-color: $brand-mid;
        }
      }

      &.is-checked .el-checkbox__inner {
        background: linear-gradient(135deg, $brand-mid, $brand-light);
        border-color: $brand-mid;
      }
    }
  }
}

// 登录按钮
.login-button {
  width: 100%;
  height: 50px;
  border-radius: 12px;
  background: linear-gradient(135deg, $brand-dark 0%, $brand-mid 50%, $brand-light 100%);
  border: none;
  color: #ffffff;
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 4px;
  transition: all 0.3s ease;
  margin-top: 8px;

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 28px rgba($brand-light, 0.35);
  }

  &:active {
    transform: translateY(0);
    box-shadow: 0 4px 12px rgba($brand-light, 0.2);
  }

  &.is-loading {
    opacity: 0.8;
    transform: none;
    box-shadow: none;
  }
}

// 注册链接
.login-register {
  text-align: center;
  font-size: 14px;
  color: $text-muted;
  margin-top: 20px;

  span {
    color: $text-muted;
  }

  a {
    color: $brand-mid;
    text-decoration: none;
    font-weight: 600;
    margin-left: 4px;
    transition: color 0.2s ease;

    &:hover {
      color: $brand-light;
    }
  }
}

// 底部版权
.login-copyright {
  margin-top: 40px;
  text-align: center;

  p {
    font-size: 12px;
    color: #a0aec0;
  }
}

// 响应式调整
@media (max-width: 576px) {
  .login-panel {
    padding: 20px;
  }

  .login-card {
    padding: 32px 24px;
    border-radius: 20px;
  }

  .login-title {
    font-size: 24px;
  }

  .login-form {
    .el-input {
      height: 46px;

      ::v-deep .el-input__inner {
        height: 46px;
      }
    }

    .code-input-wrapper {
      .login-code {
        height: 46px;
      }
    }
  }

  .login-button {
    height: 48px;
  }
}
</style>
