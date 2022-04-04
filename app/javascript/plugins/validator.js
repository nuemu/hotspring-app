import { defineRule } from 'vee-validate'

defineRule('present', value => {
  if (!value) {
    return '一文字以上入力してください';
  }

  return true;
})

defineRule('minimum', value => {
  if (value.length < 3) {
    return '三文字以上入力してください';
  }

  return true;
})

defineRule('url', value => {
  if(!value.match(/https?:\/\/[-_.!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#\u3000-\u30FE\u4E00-\u9FA0\uFF01-\uFFE3]+/g
)){
    return '正確に入力してください'
  }
  return true
})

