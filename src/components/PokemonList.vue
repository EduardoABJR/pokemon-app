<template>
    <PokeLoader v-if="isLoading"></PokeLoader>
    <h1>Pokedex</h1>
   <div class="div-card">
        <div class="div-pokemon" 
            v-for = "(pokemon, index) in list" :key="index" 
            @click="selectPokemon(getPokemonId(pokemon.url))">

            <img :src="getPokemonImage(getPokemonId(pokemon.url))">
            {{pokemon.name}}
    </div>
</div>
</template>

<script>
import {getPokemonList, getPokemonImageUrl} from "../service/pokemon-service";
import { onMounted, ref } from "vue";
import { useRouter } from "vue-router";
import PokeLoader from "./PokeLoader.vue";

export default{
    components: {
        PokeLoader
    },
    setup() {
const list = ref([]);
const router = useRouter();
const isLoading = ref(false);

        onMounted(() => {
            isLoading.value = true;
            getPokemonList().then(resp => {
                list.value = resp.results;
            }).finally(() =>{
                isLoading.value = false
            });
        });
        
        const getPokemonId = url => 
        url.replace("https://pokeapi.co/api/v2/pokemon/", "").replace("/","");

        const getPokemonImage = id => getPokemonImageUrl(id);
        
        const selectPokemon = id => router.push({name: "pokemon", params: { id }});
        
        return {list, getPokemonImage, getPokemonId, selectPokemon, isLoading};
    }
}
</script>

<style scoped>
.div-card{
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: space-evenly;
    
}
.div-pokemon {
    width: 6rem;
    margin: .5rem;
    border: black solid 1px;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
    background: #f2f2f2;
    border-radius: .5rem;
    cursor: pointer;
    transition-duration: .5s;
}
.div-pokemon:hover{
    background: #fdfdd6;
 
}
</style>