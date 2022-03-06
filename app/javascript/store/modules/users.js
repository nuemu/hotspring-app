const users_module = {
  namespaced: true,
  state(){
    return{
      user_name: '',
    }
  },
  getters:{
    user_name(state){
      return state.user_name
    }
  },
  mutations:{
    set_user(state, user_name){
      state.user_name = user_name
    }
  },
  actions:{
    login(commit, params){
      
    }
  }
}