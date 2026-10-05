<script setup lang="ts">
import { computed, ref } from "vue";

const props = defineProps<{ label: string; step?: number }>();

const count = ref(0);
const doubled = computed(() => count.value * 2);

function increment() {
    count.value += props.step ?? 1;
}
</script>

<template>
    <main class="counter">
        <p v-if="count > 0">doubled: {{ doubled }}</p>
        <button type="button" @click="increment">{{ label }}: {{ count }}</button>
    </main>
</template>

<style scoped>
.counter {
    display: grid;
    gap: 1rem;
}
</style>
