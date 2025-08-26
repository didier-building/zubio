<script setup>
import { computed } from 'vue';

const props = defineProps({
  score: { type: Number, default: 0 },
});

const emoji = computed(() => {
  if (props.score > 0) return '😊';
  if (props.score < 0) return '😞';
  return '😐';
});

const colorClass = computed(() => {
  if (props.score > 0) return 'bg-n-teal-9';
  if (props.score < 0) return 'bg-n-ruby-9';
  return 'bg-n-slate-6';
});
</script>

<template>
  <span
    class="text-xxs font-semibold px-1.5 py-0.5 rounded text-white"
    :class="colorClass"
  >
    {{ emoji }}
  </span>
</template>
