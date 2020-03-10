<template>
  <div class="todoApp">
    <div align="right" id="write">
        <button type="button" v-on:click="addTodo()" class="btn btn btn-primary">Add</button>
    </div>
    <br>
    <div id="board" v-for="list in data" :key="list.NUM">
        <modal v-if='flag === list.NUM' name="hello-world">
          {{list.CONTENT}}
        </modal>
        <!-- <div v-if='flag === list.NUM'> -->
        
        <!-- <detail-component></detail-component> -->
         <!--  <form role="form" style="width: 500px;" v-on:submit.prevent="">
            <label for="NAME">이름</label>        
            <input 
                type="text" 
                class="form-control" 
                v-model="list.NAME"
                readonly
            />
            <br><br>

            <label for="TITLE">제목</label>                
            <input 
                type="text" 
                class="form-control" 
                v-model="list.TITLE"
                required
            />
            <br><br>

            <label for="REGDATE">작성날짜</label>                
            <input 
                type="text" 
                class="form-control" 
                v-model="list.REGDATE"
                readonly
            />
            <br><br>

            <label for="CONTENT">내용</label>                
            <textarea 
                class="form-control" 
                v-model="list.CONTENT" 
                rows="13" 
                required
            >
            </textarea>
            <br>              
            <div align="right" id="write">
                <button type="button" v-on:click="updateBoard()" class="btn btn btn-primary">수정</button>
                <button type="button" v-on:click="deleteBoard()" class="btn btn btn-primary">삭제</button>
            </div>
          </form>    --> 
        <!-- </div> -->
        <div>
          <div style="width: 50px;float: left">{{ list.NUM }}</div>
          <div style="width: 250px;float: left">
              <!-- <a href="javascript:void(0)" @click="detailTodo(list.NUM)">{{list.TITLE}}</a> -->
              <a href="javascript:void(0)" @click="show(list.NUM)">{{list.TITLE}}</a>
          </div>
          <div style="width: 100px;float: left">{{ list.NAME }}</div>
          <div style="width: 100px;float: left">{{ $moment(list.REGDATE).format('YYYY-MM-DD') }}</div>
          <hr style="width: 500px">
        </div>
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
      flag: 0
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
    detailView(num) {
      bus.$emit('msg', num);
      this.flag = num;
    },
    show (num) {
      this.flag = num;
      this.$modal.show('hello-world');
    },
    hide (num) {
      this.flag = num;
      this.$modal.hide('hello-world');
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