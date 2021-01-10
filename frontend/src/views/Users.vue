<template>
  <ul>
    <li v-for="user in users" :key="user.username">
      <user-index :user="user"/>
    </li>
  </ul>
  <pagination  :pageNumber="pageNumber" :pageSize="pageSize" :totalPages="totalPages" :totalEntries="totalEntries" @get-page="getPage"/>
</template>

<script>
import axios from 'axios'
import UserIndex from '@/components/UserIndex.vue'
import Pagination from '@/components/Pagination.vue'

export default {
  data() {
    return({
    users: [],
    pageNumber: 1,
    pageSize: 5,
    totalPages: 0,
    totalEntries: 0
    })
  },
  mounted() {
    this.getPage(this.pageNumber, this.pageSize)
  },
  components: {
    UserIndex, Pagination
  },
  methods: {
    getPage(pageNumber, pageSize) {
      const currentUserId = localStorage.getItem('currentUserId')
      axios
        .get('/users', {params: {page: pageNumber, pageSize: pageSize, currentUserId: currentUserId}})
        .then((response) => {
          this.users = response.data.users;
          this.pageNumber = response.data.page_number;
          this.totalPages = response.data.total_pages;
          this.totalEntries = response.data.total_entries;
        });
    }
  }
}
</script>

