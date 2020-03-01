<template>
    <div class="todoApp">
        <div style="width: 500px; margin: auto; text-align: right;">
            <button type="button" @click="goToPage()" class="btn btn btn-primary">리스트로</button>
        </div>
        <hr style="width: 500px">
        <form role="form" style="width: 500px;" v-on:submit.prevent="">
            <label for="name">이름</label>        
            <input 
                type="text" 
                class="form-control" 
                placeholder="name" 
                v-model="list.name" 
                name="name" 
                required
            />
            <br><br>

            <label for="name">제목</label>                
            <input 
                type="text" 
                class="form-control" 
                placeholder="title" 
                v-model="list.title" 
                name="title" 
                required
            />
            <br><br>

            <label for="name">내용</label>                
            <textarea 
                class="form-control" 
                placeholder="content" 
                v-model="list.content" 
                rows="13" 
                name="content" 
                required
            >
            </textarea>
            <br>              
            <div align="right" id="write">
                <button v-on:click="insertBoard()" class="btn btn btn-primary">Add</button>
            </div>
        </form>
    </div>
</template>

<script>
import BoardDataSevice from '../services/BoardDataSevice';

export default {
    data() {
        return{
            list: {
                name: '',
                title: '',
                content: ''
            }
        }
    },
    methods:{
        insertBoard() {
            BoardDataSevice.create(this.list)
            .then(res => {
                console.log(res);
                if(res.data === 'success'){
                    alert('삽입성공');
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
            this.$router.push({ path :'/' })
        }
    }
}
</script>