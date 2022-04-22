<template>
  <div
    class="container"
    data-bs-toggle="tooltip"
    data-bs-placement="left"
    title="地図上に表示する温泉の状態を選択できます。"
  >
    <p />
    <div v-for="(status, index) in statuses" :key="status">
      <button
        class="btn" 
        @click="setVisible(status, index)"
      >
        <img :src="icons[status]"> :
        <img v-if="visible[index]" :src="icons['visible']">
        <img v-else :src="icons['invisible']">
      </button>
      <div />
    </div>
  </div>
</template>

<script>
import status from '../ol/hotspring_status.js'
import icons from '../ol/status_icons/icon_loader'

export default{
  data(){
    return{
      statuses: Object.keys(status),
      icons: icons,
      visible: [true, true, true, true, true],
    }
  },
  methods:{
    setVisible(name, index){
      this.visible[index] = !this.visible[index]
      const map = this.$parent.$refs.map.map
      map.getLayers().forEach(layer => {
        if(layer.get('name')==name){layer.setVisible(!layer.getVisible())}
      })
    }
  }
}
</script>