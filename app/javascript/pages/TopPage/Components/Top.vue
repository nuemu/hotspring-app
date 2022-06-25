<template>
  <div class="text-center d-flex w-100 h-75 bg-warning">
    <div class="mx-auto d-flex align-self-center">
      <div class="container">
        <img
          src="~flog.svg"
          class="img-fluid"
          style="height: 300px"
        >
      </div>
      <div class="container w-100 flex-grow-1">
        <div class="lead font-weight-normal">
          野湯のことなら
        </div>
        <h1 class="display-1 font-weight-normal text-nowrap webfont">
          ゆtellite
        </h1>
        <div class="input-group justify-content-center">
          <div class="form-outline">
            <input
              id="form1"
              type="search"
              class="form-control shadow-none"
              placeholder="野湯を検索"
            >
          </div>
          <span class="input-group-btn">
            <button
              class="btn btn-default btn-outline-secondary"
            >
              <img src="~search.svg">
            </button>
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default{

}
</script>