<template>
  <div
    id="sample"
    class="d-flex justify-content-center"
  >
    <div class="d-flex justify-content-center align-items-center mb-5 me-3">
      <router-link
        to="/hotsprings"
        class="btn rounded-circle btn-outline-warning p-5"
      >
        <h3 class="text-center text-dark">
          野湯一覧から探す
        </h3>
        <div class="d-flex justify-content-center">    
          <img
            src="~flog.svg"
            class="img-fluid"
            style="height: 200px;"
          >
        </div>
      </router-link>
    </div>
    <div class="d-flex justify-content-center align-items-center mb-5 ms-3">
      <router-link
        to="/mountains"
        class="btn rounded-circle btn-outline-warning p-5"
      >
        <h3 class="text-center text-dark">
          山一覧から探す
        </h3>
        <div class="d-flex justify-content-center">    
          <img
            src="~hiker.svg"
            class="img-fluid"
            style="height: 200px;"
          >
        </div>
      </router-link>
    </div>
  </div>
</template>

<script>
export default{
}
</script>