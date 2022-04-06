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
                  <th>名称</th>
                  <th>緯度</th>
                  <th>経度</th>
                  <th>詳細</th>
                  <th>削除</th>
                  <th>編集</th>
                </tr>
              </thead>
              <tbody>
                <tr
                  v-for="hotspring in hotsprings"
                  :key="hotspring.id"
                >
                  <td>{{ hotspring.id }}</td>
                  <td>{{ hotspring.name }}</td>
                  <td>{{ hotspring.latitude }}</td>
                  <td>{{ hotspring.longtitude }}</td>
                  <td>{{ hotspring.description }}</td>
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
  computed:{
    ...mapGetters('hotsprings',['hotsprings'])
  },
  created(){
    this.fetchHotsprings(1)
  },
  methods:{
    ...mapActions('hotsprings',['fetchHotsprings'])
  }
}
</script>