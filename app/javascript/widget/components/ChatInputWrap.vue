<script setup>
import { ref, watch, onMounted, onBeforeUnmount, computed } from 'vue';
import { useStore } from 'vuex';
import { useMapGetter } from 'dashboard/composables/store.js';
import ChatAttachmentButton from 'widget/components/ChatAttachment.vue';
import ChatSendButton from 'widget/components/ChatSendButton.vue';
import FluentIcon from 'shared/components/FluentIcon/Index.vue';
import ResizableTextArea from 'shared/components/ResizableTextArea.vue';
import EmojiInput from 'shared/components/emoji/EmojiInput.vue';

const props = defineProps({
  onSendMessage: { type: Function, default: () => {} },
  onSendAttachment: { type: Function, default: () => {} },
});

const widgetColor = useMapGetter('appConfig/getWidgetColor');
const isWidgetOpen = useMapGetter('appConfig/getIsWidgetOpen');
const shouldShowFilePicker = useMapGetter('appConfig/getShouldShowFilePicker');
const shouldShowEmojiPicker = useMapGetter(
  'appConfig/getShouldShowEmojiPicker'
);

const userInput = ref('');
const showEmojiPicker = ref(false);
const isFocused = ref(false);
const chatInput = ref(null);

const channelConfig = window.chatwootWebChannel;
const hasAttachmentsEnabled = computed(() =>
  channelConfig.enabledFeatures.includes('attachments')
);
const hasEmojiPickerEnabled = computed(() =>
  channelConfig.enabledFeatures.includes('emoji_picker')
);

const showAttachment = computed(
  () =>
    shouldShowFilePicker.value &&
    hasAttachmentsEnabled.value &&
    userInput.value.length === 0
);
const showSendButton = computed(() => userInput.value.length > 0);

const store = useStore();

function focusInput() {
  chatInput.value.focus();
}
function handleButtonClick(sendOriginal = false) {
  if (userInput.value && userInput.value.trim()) {
    props.onSendMessage(userInput.value, { sendOriginal });
  }
  userInput.value = '';
  focusInput();
}
function handleEnterKeyPress(e) {
  if (e.keyCode === 13 && !e.shiftKey) {
    e.preventDefault();
    handleButtonClick();
  }
}

watch(isWidgetOpen, val => {
  if (val) {
    focusInput();
  }
});

onMounted(() => {
  document.addEventListener('keypress', handleEnterKeyPress);
  if (isWidgetOpen.value) {
    focusInput();
  }
});

onBeforeUnmount(() => {
  document.removeEventListener('keypress', handleEnterKeyPress);
});

function onBlur() {
  isFocused.value = false;
}
function onFocus() {
  isFocused.value = true;
}
function toggleEmojiPicker() {
  showEmojiPicker.value = !showEmojiPicker.value;
}
function hideEmojiPicker(e) {
  if (showEmojiPicker.value) {
    e.stopPropagation();
    toggleEmojiPicker();
  }
}
function emojiOnClick(emoji) {
  userInput.value = `${userInput.value}${emoji} `;
}
function toggleTyping(typingStatus) {
  store.dispatch('conversation/toggleUserTyping', { typingStatus });
}
function onTypingOff() {
  toggleTyping('off');
}
function onTypingOn() {
  toggleTyping('on');
}
</script>

<template>
  <div
    class="items-center flex ltr:pl-3 rtl:pr-3 ltr:pr-2 rtl:pl-2 rounded-[7px] transition-all duration-200 bg-n-background !shadow-[0_0_0_1px,0_0_2px_3px]"
    :class="{
      '!shadow-n-brand dark:!shadow-n-brand': isFocused,
      '!shadow-n-strong dark:!shadow-n-strong': !isFocused,
    }"
    @keydown.esc="hideEmojiPicker"
  >
    <ResizableTextArea
      id="chat-input"
      ref="chatInput"
      v-model="userInput"
      :rows="1"
      :aria-label="$t('CHAT_PLACEHOLDER')"
      :placeholder="$t('CHAT_PLACEHOLDER')"
      class="user-message-input reset-base"
      @typing-off="onTypingOff"
      @typing-on="onTypingOn"
      @focus="onFocus"
      @blur="onBlur"
    />
    <div class="flex items-center ltr:pl-2 rtl:pr-2">
      <ChatAttachmentButton
        v-if="showAttachment"
        class="text-n-slate-12"
        :on-attach="props.onSendAttachment"
      />
      <button
        v-if="shouldShowEmojiPicker && hasEmojiPickerEnabled"
        class="flex items-center justify-center min-h-8 min-w-8"
        :aria-label="$t('EMOJI.ARIA_LABEL')"
        @click="toggleEmojiPicker"
      >
        <FluentIcon
          icon="emoji"
          class="transition-all duration-150"
          :class="{
            'text-n-slate-12': !showEmojiPicker,
            'text-n-brand': showEmojiPicker,
          }"
        />
      </button>
      <EmojiInput
        v-if="shouldShowEmojiPicker && showEmojiPicker"
        v-on-clickaway="hideEmojiPicker"
        :on-click="emojiOnClick"
        @keydown.esc="hideEmojiPicker"
      />
      <ChatSendButton
        v-if="showSendButton"
        :color="widgetColor"
        @click="handleButtonClick()"
      />
      <button
        v-if="showSendButton"
        class="ml-2 text-xs text-n-slate-11"
        @click="handleButtonClick(true)"
      >
        {{ $t('COMPONENTS.CHAT_INPUT.SEND_ORIGINAL') }}
      </button>
    </div>
  </div>
</template>

<style scoped lang="scss">
.emoji-dialog {
  @apply max-w-full ltr:right-5 rtl:right-[unset] rtl:left-5 -top-[302px] before:ltr:right-2.5 before:rtl:right-[unset] before:rtl:left-2.5;
}

.user-message-input {
  @apply border-none outline-none w-full placeholder:text-n-slate-10 resize-none h-8 min-h-8 max-h-60 py-1 px-0 my-2 bg-n-background text-n-slate-12 transition-all duration-200;
}
</style>
