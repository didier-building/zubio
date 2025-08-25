<script setup>
import { ref, computed } from 'vue';
import { useI18n } from 'vue-i18n';
import { useMapGetter } from 'dashboard/composables/store';
import { useAI } from 'dashboard/composables/useAI';
import axios from 'axios';

const { t } = useI18n();
const message = ref('');
const suggestions = ref([]);
const showSuggestions = ref(false);

const currentChat = useMapGetter('getSelectedChat');
const currentAccountId = useMapGetter('getCurrentAccountId');
const { recordAnalytics } = useAI();

const conversationId = computed(() => currentChat.value?.id);
const accountId = computed(() => currentAccountId.value);

const fetchSuggestions = async () => {
  if (!conversationId.value) return;
  const { data } = await axios.post(
    `/api/v1/accounts/${accountId.value}/conversations/${conversationId.value}/ai_suggestions`
  );
  suggestions.value = data.suggestions || [];
  showSuggestions.value = true;
};

const applySuggestion = (text, index) => {
  message.value = text;
  showSuggestions.value = false;
  recordAnalytics('REPLY_SUGGESTION', { index });
  axios.post(
    `/api/v1/accounts/${accountId.value}/conversations/${conversationId.value}/ai_suggestions`,
    { selection: index }
  );
};
</script>

<template>
  <div class="space-y-2">
    <textarea
      v-model="message"
      class="w-full border rounded p-2"
      :placeholder="t('CONVERSATION.AI_SUGGESTIONS.PLACEHOLDER')"
    />
    <div class="flex gap-2">
      <button
        type="button"
        class="px-2 py-1 bg-n-weak hover:bg-n-solid-1 rounded"
        @click="fetchSuggestions"
      >
        {{ t('CONVERSATION.AI_SUGGESTIONS.BUTTON') }}
      </button>
    </div>
    <div v-if="showSuggestions" class="border rounded p-2 space-y-1">
      <p v-if="!suggestions.length" class="text-sm text-n-slate-11">
        {{ t('CONVERSATION.AI_SUGGESTIONS.NO_SUGGESTIONS') }}
      </p>
      <ul v-else class="space-y-1">
        <li v-for="(s, index) in suggestions" :key="index">
          <button
            type="button"
            class="w-full text-left hover:bg-n-alpha-2 p-1 rounded"
            @click="applySuggestion(s, index)"
          >
            {{ s }}
          </button>
        </li>
      </ul>
    </div>
  </div>
</template>
