<template>
  <div class="container">
    <p />
    <div v-for="status in statuses" :key="status">
      <button
        class="btn rounded-circle" 
        @click="setVisible(status)"
        data-bs-toggle="tooltip"
        data-bs-placement="left"
        title="地図上に表示する温泉の状態を選択できます。"
      >
        <Icons :status="status" />
      </button>
      <div />
    </div>
  </div>
</template>

<script>
import status from '../ol/hotspring_status.js'
import icons from './StatusIcons.vue'

export default{
  data(){
    return{
      statuses: Object.keys(status),
    }
  },
  components:{
    Icons: icons
  },
  methods:{
    setVisible(name){
      const map = this.$parent.$refs.map.map
      map.getLayers().forEach(layer => {
        if(layer.get('name')==name){layer.setVisible(!layer.getVisible())}
      })
    }
  }
}
</script>