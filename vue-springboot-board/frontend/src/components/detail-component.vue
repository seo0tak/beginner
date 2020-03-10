<template>
  <form role="form" style="width: 500px;" v-on:submit.prevent="">
      <div style="width: 50px;float: left">214</div>
      <div style="width: 250px;float: left">
          <!-- <input type="text" class="form-control" style="width: 290px"> -->
          124
      </div>
      <div style="width: 100px;float: left">
        <!-- <input type="text" class="form-control" style="width: 100px;"> -->
        124
      </div>
      <!-- <div style="width: 100px;float: left">{{ $moment(list.REGDATE).format('YYYY-MM-DD') }}</div> -->
      <div style="width: 100px;float: left">2020-02-25</div>
      <div align="right" id="write">
        <button type="button" v-on:click="updateBoard()" class="btn btn btn-primary">수정</button>
        <button type="button" v-on:click="deleteBoard()" class="btn btn btn-primary">삭제</button>
        <button type="button" v-on:click="reset()" class="btn btn btn-primary">취소</button>
      </div>
      <div style="width: 500px">
        <textarea 
                class="form-control" 
                rows="13" 
                required
        >
        </textarea>
      </div>
      <hr style="width: 500px">
  </form>
</template>

<script>
import bus from '../EventBus';
export default {
  data(){
    return {
      data: [],
      num: 0,
      flag: 0
    }
  },
  methods:{
    reset() {
      //bus.$emit('push-msg', num);
    }
  },
  created(){
    bus.$on('msg', (res)=>{
      alert(res);
    })
  }
}
</script>
