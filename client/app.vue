<template>
  <div>
	  <ul>
		  <li v-for="product in products">{{ product }}</li>
	  </ul>
  </div>
</template>

<script setup>
const { data: products } = await useApiFetch('/products')
</script>
