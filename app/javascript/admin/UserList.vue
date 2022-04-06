<template>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6" /><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-lg-6">
            <table class="table">
              <thead>
                <tr>
                  <th>#</th>
                  <th>名</th>
                  <th>削除</th>
                  <th>編集</th>
                </tr>
              </thead>
              <tbody>
                <tr
                  v-for="user in users"
                  :key="user.id"
                >
                  <td>{{ user.id }}</td>
                  <td>{{ user.name }}</td>
                  <td>
                    <button class="btn">
                      X
                    </button>
                  </td>
                  <td>
                    <button class="btn">
                      E
                    </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <!-- /.col-md-6 -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
</template>

<script>
import { mapActions, mapGetters } from 'vuex'

export default {
  data(){
    return{
      users: []
    }
  },
  created(){
    this.fetchUsers(1)
      .then(response => this.users = response)
  },
  methods:{
    ...mapActions('users',['fetchUsers'])
  }
}
</script>