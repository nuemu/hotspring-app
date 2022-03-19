<template>
<transition name="fade">
  <div v-if="modal_appearance">
    <div class="modal" @click.self="modal_appearance=false">
      <div class="modal-dialog modal-dialog-centered modal-fullscreen">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">お気に入り一覧</h5>
            <button type="button" @click="modal_appearance=false" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                <tr @click="JumpToFavorite(hotspring)" v-for="hotspring in favorite_hotsprings" :key="hotspring.id">
                  <td>{{hotspring.id}}</td>
                  <td>{{hotspring.name}}</td>
                  <td>{{hotspring.latitude}}</td>
                  <td>{{hotspring.longtitude}}</td>
                  <td>{{hotspring.description}}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <div class="modal-backdrop show"></div>
  </div>
</transition>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default{
  data(){
    return{
      modal_appearance: false,
      favorite_hotsprings: [],
    }
  },
  computed:{
    ...mapGetters('users', ['favorites']),
    ...mapGetters('hotsprings', ['hotsprings']),
  },
  mounted(){
    if(this.hotsprings.length == 0){
      this.fetchHotsprings(1)
    }
  },
  watch:{
    hotsprings(){
      this.Favorite()
    },
    favorites(){
      this.Favorite()
    }
  },
  methods:{
    ...mapActions('hotsprings',['fetchHotsprings']),
    JumpToFavorite(hotspring){
      console.log(hotspring)
      window.location.href='/hotspring/'+hotspring.longtitude+','+hotspring.latitude
      this.modal_appearance = false
    },
    Favorite(){
      let hotsprings = []
      this.favorites.forEach(element => {
        let hotspring_id = element.attributes.hotspring_id
        let id = this.hotsprings.findIndex(hotspring => hotspring.id == hotspring_id)
        hotsprings.push(this.hotsprings[id])
      })
      this.favorite_hotsprings = hotsprings
    }
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