<script setup>
import { computed, ref } from 'vue';
import { useStore } from 'vuex';
import AgentMessage from 'widget/components/AgentMessage.vue';
import UserMessage from 'widget/components/UserMessage.vue';
import { MESSAGE_TYPE } from 'widget/helpers/constants';

const props = defineProps({
  message: { type: Object, default: () => ({}) },
});

const store = useStore();
const allMessages = computed(
  () => store.getters['conversation/getConversation']
);
const isUserMessage = computed(
  () => props.message.message_type === MESSAGE_TYPE.INCOMING
);
const replyTo = computed(() => {
  const replyId = props.message?.content_attributes?.in_reply_to;
  return replyId ? allMessages.value[replyId] : null;
});

const showOriginal = ref(false);
const hasOriginal = computed(
  () => !!props.message?.content_attributes?.original_content
);
const displayMessage = computed(() => {
  if (hasOriginal.value && showOriginal.value) {
    return {
      ...props.message,
      content: props.message.content_attributes.original_content,
    };
  }
  return props.message;
});
function toggleOriginal() {
  showOriginal.value = !showOriginal.value;
}
</script>

<template>
  <div>
    <UserMessage
      v-if="isUserMessage"
      :id="`cwmsg-${message.id}`"
      :message="displayMessage"
      :reply-to="replyTo"
    />
    <AgentMessage
      v-else
      :id="`cwmsg-${message.id}`"
      :message="displayMessage"
      :reply-to="replyTo"
    />
    <button
      v-if="hasOriginal"
      class="text-xs text-n-slate-11 mt-1"
      @click="toggleOriginal"
    >
      {{
        showOriginal
          ? $t('COMPONENTS.CHAT_MESSAGE.SHOW_TRANSLATED')
          : $t('COMPONENTS.CHAT_MESSAGE.SHOW_ORIGINAL')
      }}
    </button>
  </div>
</template>

<style scoped lang="scss">
.message-wrap {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  max-width: 90%;
}
</style>
