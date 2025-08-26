<script setup>
import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';
import { useAccount } from 'dashboard/composables/useAccount';
import SectionLayout from './SectionLayout.vue';
import Switch from 'next/switch/Switch.vue';
import { useAlert } from 'dashboard/composables';

const { t } = useI18n();
const { currentAccount, updateAccount } = useAccount();
const isEnabled = ref(false);

watch(
  currentAccount,
  () => {
    isEnabled.value = !!currentAccount.value?.settings?.ai_suggestions_enabled;
  },
  { immediate: true }
);

const toggle = async () => {
  try {
    await updateAccount(
      { ai_suggestions_enabled: isEnabled.value },
      { silent: true }
    );
    useAlert(t('GENERAL_SETTINGS.FORM.AI_SUGGESTIONS.API.SUCCESS'));
  } catch (e) {
    useAlert(t('GENERAL_SETTINGS.FORM.AI_SUGGESTIONS.API.ERROR'));
  }
};
</script>

<template>
  <SectionLayout
    :title="t('GENERAL_SETTINGS.FORM.AI_SUGGESTIONS.TITLE')"
    :description="t('GENERAL_SETTINGS.FORM.AI_SUGGESTIONS.NOTE')"
    with-border
  >
    <template #headerActions>
      <div class="flex justify-end">
        <Switch v-model="isEnabled" @change="toggle" />
      </div>
    </template>
  </SectionLayout>
</template>
