const files = require.context('.', false, /(.*)\.svg$/)

const layers = {}
files.keys().forEach(key =>{
  if(!key.match(/loader/)) layers[key.replace(/(\.\/|\.svg)/g, '')] = files(key)
})

export default layers