<template>
  <div class="container my-4">
    <div class="row product-list">
      <div 
        v-for="product in paginatedProducts" 
        :key="product.id" 
        class="col-md-4 col-lg-2 mb-4 product-item"
        @click="goToProductDetail(product.id)">
        <div class="card h-100 shadow-sm">
          <img :src="product.image" :alt="product.name" class="card-img-top">
          <div class="card-body d-flex flex-column">
            <h5 class="card-title">{{ product.name }}</h5>
            <p class="card-text">{{ product.description }}</p>
            <p class="card-text text-primary">{{ product.price.toLocaleString() }} VNĐ</p>
            <p v-if="isOutOfStock(product)" class="text-danger">Hết hàng</p>
            <p v-else class="text-success">Còn {{ getTotalStock(product) }} sản phẩm</p>
            <button class="btn btn-primary mt-auto" @click.stop="goToProductDetail(product.id)">Xem chi tiết</button>
          </div>
        </div>
      </div>
    </div>
    <div class="pagination-container">
      <ul class="pagination">
        <li class="page-item" :class="{ disabled: currentPage === 1 }">
          <button class="page-link" @click="prevPage" :disabled="currentPage === 1">Previous</button>
        </li>
        <li class="page-item" v-for="page in totalPages" :key="page" :class="{ active: currentPage === page }">
          <button class="page-link" @click="goToPage(page)">{{ page }}</button>
        </li>
        <li class="page-item" :class="{ disabled: currentPage === totalPages }">
          <button class="page-link" @click="nextPage" :disabled="currentPage === totalPages">Next</button>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
import { mapState } from 'vuex';

export default {
  name: 'AppProduct',
  data() {
    return {
      currentPage: 1,
      itemsPerPage: 10, // Đặt số sản phẩm mỗi trang là 10
    };
  },
  computed: {
    ...mapState(['items']),
    paginatedProducts() {
      if (Array.isArray(this.items)) {
        const start = (this.currentPage - 1) * this.itemsPerPage;
        const end = start + this.itemsPerPage;
        return this.items.slice(start, end);
      }
      return [];
    },
    totalPages() {
      if (Array.isArray(this.items)) {
        return Math.ceil(this.items.length / this.itemsPerPage);
      }
      return 1;
    }
  },
  methods: {
    goToProductDetail(productId) {
      this.$router.push({ name: 'ProductDetail', params: { id: productId } });
    },
    prevPage() {
      if (this.currentPage > 1) {
        this.currentPage -= 1;
      }
    },
    nextPage() {
      if (this.currentPage < this.totalPages) {
        this.currentPage += 1;
      }
    },
    goToPage(page) {
      this.currentPage = page;
    },
    isOutOfStock(product) {
      return product.sizes.every(size => size.quantity === 0);
    },
    getTotalStock(product) {
      return product.sizes.reduce((total, size) => total + size.quantity, 0);
    }
  }
};
</script>

<style scoped>
.product-list {
  display: flex;
  flex-wrap: wrap;
  gap: 16px; /* khoảng cách giữa các sản phẩm */
  justify-content: center; /* Canh giữa các sản phẩm */
}

.product-item {
  cursor: pointer; /* Thêm con trỏ pointer để biểu thị rằng sản phẩm có thể nhấp vào */
  flex: 1 1 calc(25% - 16px); /* Mỗi sản phẩm chiếm 25% chiều rộng, trừ đi khoảng cách */
  max-width: calc(25% - 16px); /* Đảm bảo không vượt quá chiều rộng */
}

.product-item img {
  width: 100%;
  height: auto;
  border-bottom: 1px solid #ccc;
  margin-bottom: 8px;
}

.product-item-info {
  padding: 8px;
}

.product-item:hover {
  transform: scale(1.05);
}

.pagination-container {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.pagination {
  display: flex;
  list-style: none;
  padding: 0;
}

.page-item {
  margin: 0 5px;
}

.page-link {
  padding: 10px 15px;
  border: 1px solid #ddd;
  border-radius: 5px;
  background-color: white;
  cursor: pointer;
  transition: background-color 0.3s, color 0.3s;
}

.page-link:hover {
  background-color: #007bff;
  color: white;
}

.page-item.active .page-link {
  background-color: #007bff;
  color: white;
  border-color: #007bff;
}

.page-item.disabled .page-link {
  cursor: not-allowed;
  opacity: 0.5;
}

</style>





