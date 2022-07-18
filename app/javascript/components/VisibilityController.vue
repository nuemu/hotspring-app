<template>
  <div class="container">
    <p />
    <div
      class="bg-transparent"
      data-bs-toggle="tooltip"
      data-bs-placement="left"
      title="地図上のアイコン表示を切り替えられます。"
    >
      <div
        v-for="(status, index) in statuses"
        :key="status"
      >
        <button
          class="btn w-100 d-flex" 
          @click="setVisible(status, index)"
        >
          <span class="text-start w-100">
            <img :src="icons[status]"> : {{ t_status[status] }}
          </span>
          <span class="text-end">
            <img
              v-if="visible[index]"
              :src="icons['visible']"
            >
            <img
              v-else
              :src="icons['invisible']"
            >
          </span>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import status from '../ol/hotspring_status.js'
import icons from '../ol/status_icons/icon_loader'

export default{
  data(){
    return{
      t_status: status,
      statuses: Object.keys(status),
      icons: icons,
      visible: [true, true, true, true, true],
      tooltip: null,
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