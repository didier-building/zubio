<script setup>
import BarChart from 'shared/components/charts/BarChart.vue';

const collection = {
  labels: ['Mon', 'Tue', 'Wed'],
  datasets: [
    {
      label: 'Sentiment',
      backgroundColor: '#4F46E5',
      data: [1, 0, -1],
    },
  ],
};
</script>

<template>
  <div class="p-6">
    <h1 class="text-xl font-medium mb-4">{{ $t('REPORT.SENTIMENT.TITLE') }}</h1>
    <BarChart :collection="collection" />
  </div>
</template>
