<template>
  <transition name="fade">
    <div v-if="modal_appearance">
      <div
        class="modal"
        @click.self="modal_appearance=false"
      >
        <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">
                お気に入り一覧
              </h5>
              <button
                type="button"
                class="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
                @click="modal_appearance=false"
              />
            </div>
            <div class="modal-body">     
              <table class="table">
                <thead>
                  <tr>
                    <th>#</th>
                    <th>名称</th>
                    <th>緯度</th>
                    <th>経度</th>
                    <th>詳細</th>
                  </tr>
                </thead>
                <tbody>
                  <tr
                    v-for="hotspring in favorite_hotsprings"
                    :key="hotspring.id"
                    @click="JumpToFavorite(hotspring)"
                  >
                    <td>{{ hotspring.id }}</td>
                    <td>{{ hotspring.name }}</td>
                    <td>{{ hotspring.latitude }}</td>
                    <td>{{ hotspring.longtitude }}</td>
                    <td>{{ hotspring.description }}</td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div class="modal-footer">
              <a
                class="btn btn-secondary"
                :href="DownloadURL"
                :download="FileName"
              >CSV出力</a>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-backdrop show" />
    </div>
  </transition>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default{
  data(){
    return{
      modal_appearance: false,
    }
  },
  computed:{
    ...mapGetters('users', ['favorites', 'user_name']),
    ...mapGetters('hotsprings', ['hotsprings']),
    favorite_hotsprings(){
      let hotsprings = []
      this.favorites.forEach(element => {
        let hotspring_id = element.attributes.hotspring_id
        let id = this.hotsprings.findIndex(hotspring => hotspring.id == hotspring_id)
        hotsprings.push(this.hotsprings[id])
      })
      return hotsprings
    },
    DownloadURL(){
      var data = '名称,緯度,経度,状況,説明\n'
      this.favorite_hotsprings.forEach(hotspring => {
        data += hotspring.name+','
        data += hotspring.latitude+','
        data += hotspring.longtitude+','
        data += hotspring.status+','
        data += hotspring.description+'\n'
      })
      const bom = new Uint8Array([0xef, 0xbb, 0xbf]);
      const blob = new Blob([bom, data], { type: "text/csv" })

      return (window.URL || window.webkitURL).createObjectURL(blob);
    },
    FileName(){
      let today = new Date();
 
      let year = today.getFullYear()
      let month = today.getMonth() + 1
      let date = today.getDate()

      return "お気に入り_" + year + '/' + month + '/' + date + ".csv"
    }
  },
  watch:{
    user_name(){
      if(this.user_name){
        this.fetchHotsprings(1)
      }
    }
  },
  methods:{
    ...mapActions('hotsprings',['fetchHotsprings']),
    JumpToFavorite(hotspring){
      window.location.href='/hotspring/'+hotspring.longtitude+','+hotspring.latitude
      this.modal_appearance = false
    },
  }
}
</script>

<style scoped>
.modal {
  display: block;
}
.fade-enter-active, .fade-leave-active {
  transition: opacity .15s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>