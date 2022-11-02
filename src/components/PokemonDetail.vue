<template>
    <button class="btn-voltar" @click="back">Voltar</button>
    <PokeLoader v-if="isLoading"></PokeLoader>
    <div v-if="info">


        <div class="poke-detail">
            <div class="div-row">
                <h1>{{info.name}}</h1>
                <img :src="image">
                
            </div>
            <div class="div-images">
            <div v-for="(value, key, index) in info.sprites" :key="index">
                <img v-if="value && typeof value === 'string'" :src="value">
            </div>
        

        </div>
        <div class="poke-info">
            <h3>Sobre</h3>
            <div class="poke-info-2">
                <div class="div-row">
                    <h4>Experiência:  </h4> {{ info.base_experience }}
                </div>
                <div class="div-row">
                    <h4>Peso:  </h4> <span>{{ info.weight/10}} Kg </span>
                </div>
                <div class="div-row">
                    <h4>Altura:  </h4> <span>{{ info.height/10 }} m</span>
                </div>
            </div>
    </div>


    </div>
</div>
</template>

<script>
    import { useRoute, useRouter } from "vue-router";
    import { onMounted, ref, computed } from "vue";
    import { getPokemon, getPokemonImageUrl } from "../service/pokemon-service.js";
    import PokeLoader from "./PokeLoader.vue";

    export default{
        components:{
            PokeLoader
        },

    setup(){
        const router = useRouter();
        const route = useRoute();
        const info = ref(null);
        const isLoading = ref(false);

        onMounted(() =>{
            isLoading.value = true;            
            getPokemon(route.params.id).then(resp => {
                info.value = resp;
        
            }).finally(() => {
                isLoading.value = false;
            })

        });
        const back = () => router.replace("/");

        const image = computed(() => getPokemonImageUrl(info.value.id));

        return {isLoading, info, image, back};
    }

}
</script>

<style scoped>

.div-row{
    display: flex;
    flex-direction: row;
    align-items: center;
    padding-bottom: 0;
    justify-content: center;
    margin-left: .5rem;
    margin-left: .5rem;
}
.btn-voltar{
    background-color: #f2f2f2; 
    border: #f2f2f2 2px solid;
    color: black;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    border-radius: .5rem;
    cursor: pointer;
    transition-duration: 0.4s;
    display: flex;
    justify-content: center;
    
}
.btn-voltar:hover{
    background-color: #a0a0a0;
    color: black;
    border: #f2f2f2 solid 2px;
}
.div-images{
    margin-top: 0;
    padding-top: 0;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
}
.poke-detail{
    margin-left: 2rem;
    margin-right: 2rem;
    
}
.poke-info{
    border: black solid 1px;
    background: #f2f2f2;
    border-radius: 2rem;
}
.poke-info-2{
    
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
    
}
</style>