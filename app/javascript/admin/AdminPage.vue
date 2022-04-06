<template>
  <div class="wrapper">
    <Sidebar />

    <div v-if="true">
      <Hotspring />
    </div>

    <div v-if="true">
      <User />
    </div>
  
    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
      <!-- Control sidebar content goes here -->
      <div class="p-3">
        <h5>Title</h5>
        <p>Sidebar content</p>
      </div>
    </aside>
  <!-- /.control-sidebar -->
  </div>
</template>

<script>
import Sidebar from './AdminSidebar.vue'
import Hotspring from './HotspringList.vue'
import User from './UserList.vue'

export default {
  components:{
    Sidebar,
    Hotspring,
    User
  }
}
</script>

<style scoped>
@import './adminlte.css'
</style>
