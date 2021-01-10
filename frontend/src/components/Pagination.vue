<template>
  <div class="row m5">
    <div class="col s6 offset-s3">
      <ul class="pagination">
        <li style="margin: 10px;" class="waves-effect teal lighten-2" :class="getPreviousPageClass(this.pageNumber, this.totalPages)">
          <a @click="getPreviousPage()">
            <i class="material-icons">chevron_left</i>
          </a>
        </li>
        <li style="margin: 10px;" class="waves-effect teal lighten-2" :class="getNextPageClass(this.pageNumber, this.totalPages)">
          <a @click="getNextPage()">
            <i class="material-icons">chevron_right</i>
          </a>
        </li>
      </ul>
      <span> {{ `${actualStartIndex} - ${actualEndIndex}  из ${totalEntries}` }} </span>
    </div>
  </div>
</template>

<script>
export default {
  emits: ['getPage'],
  computed: {
    actualStartIndex() {
      return ((this.pageSize * this.pageNumber + 1) - this.pageSize)
    },
    actualEndIndex() {
      return Math.min((this.pageSize * this.pageNumber), this.totalEntries)
    }
  },
  props: {
    totalPages: {
      type: Number,
      default: 1
    },
    pageNumber: {
      type: Number,
      default: 1
    },
    pageSize: {
      type: Number,
      default: 5
    },
    totalEntries: {
      type: Number,
      default: 0
    }
  },
  methods: {
    getNextPage() {
      this.$emit('getPage', (this.pageNumber + 1), this.pageSize)
    },
    getPreviousPage() {
      this.$emit('getPage', (this.pageNumber - 1), this.pageSize)
    },
    getNextPageClass(pageNumber, totalPages) {
      if (pageNumber < totalPages) {
        return []
      }
      else{
        return ['disabled']
      }
    },
    getPreviousPageClass(pageNumber, totalPages) {
      if (pageNumber <= totalPages && pageNumber > 1) {
        return []
      }
      else{
        return ['disabled']
      }
    }
  }
}
</script>
