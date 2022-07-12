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
          野湯を探すなら
        </div>
        <h1 class="display-1 font-weight-normal text-nowrap webfont">
          ゆtellite
        </h1>
        <p />
        <div class="justify-content-center">
          <button class="btn btn-outline-dark w-50" @click.prevent="$router.push('/hotsprings')">野湯一覧</button>
        </div>
        <p />
        <div class="justify-content-center">
          <button class="btn btn-outline-secondary w-50" @click.prevent="$router.push('/register')">ユーザー登録</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default{}
</script>