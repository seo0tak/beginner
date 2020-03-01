<template>
  <div class="todoApp">
    <div align="right" id="write">
        <button type="button" v-on:click="addTodo()" class="btn btn btn-primary">Add</button>
    </div>
    <br>
    <div id="board" v-for="list in data" :key="list.NUM">
        <div style="width: 10px;float: left">{{ list.NUM }}</div>
        <div style="width: 240px;float: left">
            <a href="javascript:void(0)" @click="detailTodo(list.NUM)">{{list.TITLE}}</a>
            <!-- <a href="javascript:void(0)" @click="detailView(list.NUM)">{{list.TITLE}}</a> -->
        </div>
        <div style="width: 100px;float: left">{{ list.NAME }}</div>
        <div style="width: 100px;float: left">{{ $moment(list.REGDATE).format('YYYY-MM-DD') }}</div>
        <div style="width: 50px;float: left"><a href="javascript:void(0)" @click="detailView(list)">수정</a></div>
        <hr style="width: 500px">
        <!-- <component v-bind:is="currentView"></component> -->
        <detail-component v-if="1 === 2"></detail-component>
    </div>
    <div id="paging">
        <a href='javascript:void(0);' v-if="paging.curPage > 1" @click="pageList('1')">[처음]</a>
        <a href='javascript:void(0);' v-if="paging.curBlock > 1" @click="pageList(paging.prevPage)">[이전]</a>
        <span v-for="num in (paging.blockBegin, paging.blockEnd)" :key="num">
          <span v-if="paging.curPage === num" style="color: red">&nbsp;{{ num }}&nbsp;</span>
          <a v-else href='javascript:void(0);' @click="pageList(num)">&nbsp;{{ num }}&nbsp;</a>
        </span>
        <a v-if="paging.curBlock <= paging.totBlock" href='javascript:void(0);' @click="pageList(paging.nextPage)">[다음]</a>
        <a v-if="paging.curPage < paging.totalPage" href='javascript:void(0);' @click="pageList(paging.totalPage)">[끝]</a>
    </div>
  </div>
</template>

<script>
import BoardDataSevice from '../services/BoardDataSevice';
import bus from '../EventBus';
import detailComponent from './detail-component.vue';

export default {
  name: 'VueBoard-restful',
  components: {
    'detail-component': detailComponent
  },
  data(){
    return {
      data: [],
      paging: [],
      curPage: 0,
      flag: false
    }
  },
  methods:{
    getBoardList (curPage) {
      if(curPage == undefined){
        curPage = 1
      }
      BoardDataSevice.getAll(curPage)
      .then(res => {
        this.paging = res.data.paging
        this.data = res.data.list
        console.log(this.paging.blockBegin)
      })
    },
    pageList (curPage) {
      this.getBoardList(curPage)
    },
    addTodo () {
      this.$router.push({ path :'/add' })
    },
    detailTodo (num) {
      this.$router.push({ name: 'Detail' , params: { num: num }})
    },
    detailView(list) {
      alert(list.NUM);
      //this.flag = !this.flag;
      console.log(list);
      //bus.$emit('buslist', list)
      this.currentView=Home;
    }
  },
  mounted(){
    //this.getBoardList()
  },
  created(){
    this.getBoardList()
    /* 
    버스로 받을때
    bus.$on('buslist', function (res) {
      console.log(res[0].id)
    }) 
    */
  }
}
</script>