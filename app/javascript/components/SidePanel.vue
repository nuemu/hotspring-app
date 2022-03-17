<template>
<div>
  使い方
</div>
<div>
  モード
  <ul>
    <li>登録</li>
    <li>線を引く</li>
  </ul>
</div>
<div>
  地図
  <ol>
    <li @click="normal">標準地図</li>
    <li @click="thermal">Thermal</li>
    <li @click="photo">航空写真</li>
  </ol>
</div>
</template>

<script>
export default{
  methods:{
    normal(){
      this.$parent.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')=='THERMAL'){
          layer.setVisible(false)
        }
        if(layer.get('name')=='photo'){
          layer.setVisible(false)
        }
      })
    },
    thermal(){
      this.$parent.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')=='THERMAL'){
          layer.setVisible(true)
        }
        if(layer.get('name')=='photo'){
          layer.setVisible(false)
        }
      })
      
    },
    photo(){
      this.$parent.$refs.map.map.getLayers().forEach(layer => {
        if(layer.get('name')=='THERMAL'){
          layer.setVisible(false)
        }
        if(layer.get('name')=='photo'){
          layer.setVisible(true)
        }
      })
    }
  }
}
</script>