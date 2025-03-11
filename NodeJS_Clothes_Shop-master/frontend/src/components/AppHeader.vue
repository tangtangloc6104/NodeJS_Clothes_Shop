<template>
  <div>
    <!-- Thêm line ngang với animation chạy từ phải sang trái -->
    <div class="top-line">
      <div class="voucher">
        <span class="text">VOUCHER 10% TỐI ĐA 10K</span>
        <span class="text">VOUCHER 50K DÀNH CHO ĐƠN TỪ 699K</span>
        <span class="text">VOUCHER 100K DÀNH CHO ĐƠN TỪ 999K</span>
        <span class="text">FREESHIP CHO ĐƠN TỪ 399K</span>
      </div>
    </div>

    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
      <div class="container-fluid">
        <!-- Logo căn giữa -->
        <a class="navbar-brand mx-auto" @click="goToHome">
          <img src="@/assets/images/Logo.png" alt="Logo" height="60">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <!-- Các mục điều hướng -->
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <router-link class="nav-link" to="/">Trang chủ</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/ao">Áo</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/giay">Giày</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/bo">Bộ</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/lienhe">Liên hệ</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/tintuc">Tin tức</router-link>
            </li>
          </ul>
        </div>
        <div class="d-flex align-items-center ms-auto">
          <!-- Nút tìm kiếm -->
          <button @click="goToSearch" class="btn btn-outline-secondary me-3">
            <svg class="icon" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
              <path stroke="currentColor" stroke-linecap="round" stroke-width="2" d="m21 21-3.5-3.5M17 10a7 7 0 1 1-14 0 7 7 0 0 1 14 0Z"/>
            </svg>
          </button>
          <!-- Nút Đăng nhập/Đăng ký -->
          <span class="user" v-if="!isLoggedIn">
            <router-link to="/login" class="btn btn-outline-primary me-3">
              <svg class="icon" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24">
                <path fill-rule="evenodd" d="M12 4a4 4 0 100 8 4 4 0 000-8zM10 13a4 4 0 00-4 4v1a2 2 0 002 2h8a2 2 0 002-2v-1a4 4 0 00-4-4h-4z" clip-rule="evenodd"/>
              </svg>
              Đăng nhập/Đăng ký
            </router-link>
          </span>
          <!-- Nếu đã đăng nhập, hiển thị tên người dùng và dropdown -->
          <span class="user" v-else>
            <div class="dropdown">
              <button class="btn btn-outline-primary dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                <svg class="icon" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24">
                  <path fill-rule="evenodd" d="M12 4a4 4 0 100 8 4 4 0 000-8zM10 13a4 4 0 00-4 4v1a2 2 0 002 2h8a2 2 0 002-2v-1a4 4 0 00-4-4h-4z" clip-rule="evenodd"/>
                </svg>
                Xin chào, {{ user?.fullName }}
              </button>
              <ul class="dropdown-menu" aria-labelledby="userDropdown">
                <li><button class="dropdown-item" @click="logout">Đăng xuất</button></li>
              </ul>
            </div>
          </span>
          <!-- Nút Giỏ hàng -->
          <router-link to="/cart" class="btn btn-outline-secondary position-relative">
            <svg class="icon" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
              <path fill-rule="evenodd" d="M4 4a1 1 0 0 1 1-1h1.5a1 1 0 0 1 .979.796L7.939 6H19a1 1 0 0 1 .979 1.204l-1.25 6a1 1 0 0 1-.979.796H9.605l.208 1H17a3 3 0 1 1-2.83 2h-2.34a3 3 0 1 1-4.009-1.76L5.686 5H5a1 1 0 0 1-1-1Z" clip-rule="evenodd"/>
            </svg>
            Giỏ hàng
            <span class="badge bg-secondary position-absolute top-0 start-100 translate-middle">{{ cartItemCount }}</span>
          </router-link>
        </div>
      </div>
    </nav>
    <router-view/>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';

export default {
  name: 'AppHeader',
  data() {
    return {
      showDropdown: false
    };
  },
  computed: {
    ...mapGetters(['cartItemCount', 'isLoggedIn', 'user'])
  },
  methods: {
    ...mapActions(['setLoginStatus']),
    goToHome() {
      this.$router.push('/');
    },
    goToSearch() {
      this.$router.push('/search');
    },
    toggleDropdown() {
      this.showDropdown = !this.showDropdown;
    },
    closeDropdown() {
      setTimeout(() => {
        this.showDropdown = false;
      }, 200); // Wait before closing dropdown to allow click
    },
    logout() {
      this.setLoginStatus({ status: false, user: null });
      this.$router.push('/');
    }
  }
};
</script>

<style scoped>
/* Đường kẻ ngang chạy từ phải sang trái */
.top-line {
  background-color: #f8f9fa;  /* Màu nền cho line */
  padding: 5px 0;
  font-weight: bold;
  position: relative;
  overflow: hidden;
}

.voucher {
  display: inline-block;
  white-space: nowrap;
  font-size: 20px;
  color: black;
  animation: scrollLeft 30s linear infinite;  
  padding-left: 100%;
}

.voucher span {
  margin-right: 300px; /* Thêm khoảng cách giữa các voucher */
}

@keyframes scrollLeft {
  0% {
    transform: translateX(0.5%);
  }
  100% {
    transform: translateX(-100%);
  }
}


.navbar {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  background-color: #ffffff; /* White background */
}

.navbar .navbar-nav .nav-link {
  font-size: 20px;
  font-weight: 500;
  color: #495057; /* Dark color for text */
  padding: 10px 20px;
  border-radius: 5px;
  transition: color 0.3s;
}

.navbar .navbar-nav .nav-link:hover {
  color: #007bff;
  text-decoration: none;
}

.navbar .navbar-toggler-icon {
  background-color: #007bff;
}

.btn-outline-secondary {
  border-color: #007bff;
  color: #007bff;
}

.btn-outline-secondary:hover {
  background-color: #007bff;
  color: white;
}

.icon {
  width: 24px;
  height: 24px;
  margin-right: 5px;
}

.user .dropdown-menu {
  min-width: 200px;
}

.cart-count {
  position: absolute;
  top: 1px;
  right: -5px;
  background-color: red;
  color: white;
  border-radius: 50%;
  padding: 5px 8px;
  font-size: 12px;
  font-weight: 700;
}
</style>
