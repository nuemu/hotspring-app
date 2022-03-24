const files = require.context('.', false, /(.*)layer\.js$/)

const layers = {}
files.keys().forEach(key =>{
  if(!key.match(/loader/)) layers[key.replace(/(\.\/|\.js)/g, '')] = files(key).default
})

export default layers