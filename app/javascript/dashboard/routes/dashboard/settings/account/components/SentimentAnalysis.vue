<script setup>
import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import { useAccount } from 'dashboard/composables/useAccount';
import { useAlert } from 'dashboard/composables';
import SectionLayout from './SectionLayout.vue';
import Switch from 'next/switch/Switch.vue';

const { t } = useI18n();
const isEnabled = ref(false);
const { currentAccount, updateAccount } = useAccount();

watch(
  currentAccount,
  () => {
    const { sentiment_analysis } = currentAccount.value?.settings || {};
    isEnabled.value = !!sentiment_analysis;
  },
  { deep: true, immediate: true }
);

const toggleSentiment = async () => {
  try {
    await updateAccount({ sentiment_analysis: isEnabled.value });
    useAlert(t('GENERAL_SETTINGS.FORM.SENTIMENT_ANALYSIS.API.SUCCESS'));
  } catch (e) {
    useAlert(t('GENERAL_SETTINGS.FORM.SENTIMENT_ANALYSIS.API.ERROR'));
  }
};
</script>

<template>
  <SectionLayout
    :title="t('GENERAL_SETTINGS.FORM.SENTIMENT_ANALYSIS.TITLE')"
    :description="t('GENERAL_SETTINGS.FORM.SENTIMENT_ANALYSIS.NOTE')"
    with-border
  >
    <template #headerActions>
      <div class="flex justify-end">
        <Switch v-model="isEnabled" @change="toggleSentiment" />
      </div>
    </template>
  </SectionLayout>
</template>
