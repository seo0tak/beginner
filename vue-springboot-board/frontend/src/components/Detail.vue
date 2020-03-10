<template>
  <div>
    <div class="todoApp">
        <div style="width:500px; margin:auto; text-align: right;">
            <button type="button" @click="goToPage()" class="btn btn btn-primary">리스트로</button>
        </div>
        <hr style="width: 500px">
        <form role="form" style="width: 500px;" v-on:submit.prevent="">
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
        </form>    
    </div>
  </div>
</template>

<script>
import BoardDataSevice from '../services/BoardDataSevice';
import bus from '../EventBus';

export default {
    created() {
        this.getData()
    },
    data() {
        return{
            list: {
                NAME: '',
                TITLE: '',
                REGDATE: '',
                CONTENT: ''
            }
        }
    },
    methods:{
        getData() {
            BoardDataSevice.get(this.$route.params.num)
            .then(res => {
                console.log(res.data);
                this.list = res.data;
                return;
            })
        },
        updateBoard() {
            BoardDataSevice.update(this.$route.params.num, this.list)
            .then(res => {
                if(res.data === 'success'){
                    alert('수정성공');
                    this.$router.push({ path :'/' });
                }
                else{
                    return;
                }
            })
            .catch(e => {
                console.log(e);
            });
        },
        deleteBoard() {
            BoardDataSevice.delete(this.$route.params.num)
            .then(res => {
                if(res.data === 'success'){
                    alert('삭제성공');
                    this.$router.push({ path :'/' });
                }
                else{
                    return;
                }
            })
            .catch(e => {
                console.log(e);
            });
        },
        goToPage() {
           /*  
           버스 data전달
            var buslist = [
                {id : 1},
                {title : 2}
            ]
            bus.$emit('buslist', buslist) 
            */
            this.$router.push({ path :'/' })
        }
    }
}
</script>

<style>

</style>