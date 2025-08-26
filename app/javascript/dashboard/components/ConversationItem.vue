<script setup>
import { inject } from 'vue';
import ConversationCard from './widgets/conversation/ConversationCard.vue';
import SentimentBadge from './widgets/conversation/SentimentBadge.vue';

const {
  source,
  teamId = 0,
  label = '',
  conversationType = '',
  foldersId = 0,
  showAssignee = false,
} = defineProps({
  source: { type: Object, required: true },
  teamId: { type: [String, Number], default: 0 },
  label: { type: String, default: '' },
  conversationType: { type: String, default: '' },
  foldersId: { type: [String, Number], default: 0 },
  showAssignee: { type: Boolean, default: false },
});

const selectConversation = inject('selectConversation');
const deSelectConversation = inject('deSelectConversation');
const assignAgent = inject('assignAgent');
const assignTeam = inject('assignTeam');
const assignLabels = inject('assignLabels');
const updateConversationStatus = inject('updateConversationStatus');
const toggleContextMenu = inject('toggleContextMenu');
const markAsUnread = inject('markAsUnread');
const markAsRead = inject('markAsRead');
const assignPriority = inject('assignPriority');
const isConversationSelected = inject('isConversationSelected');
const deleteConversation = inject('deleteConversation');
</script>

<template>
  <div class="relative">
    <ConversationCard
      :key="source.id"
      :active-label="label"
      :team-id="teamId"
      :folders-id="foldersId"
      :chat="source"
      :conversation-type="conversationType"
      :selected="isConversationSelected(source.id)"
      :show-assignee="showAssignee"
      enable-context-menu
      @select-conversation="selectConversation"
      @de-select-conversation="deSelectConversation"
      @assign-agent="assignAgent"
      @assign-team="assignTeam"
      @assign-label="assignLabels"
      @update-conversation-status="updateConversationStatus"
      @context-menu-toggle="toggleContextMenu"
      @mark-as-unread="markAsUnread"
      @mark-as-read="markAsRead"
      @assign-priority="assignPriority"
      @delete-conversation="deleteConversation"
    />
    <div class="absolute top-2 left-2">
      <SentimentBadge
        v-if="source.sentiment_score !== undefined"
        :score="source.sentiment_score"
      />
    </div>
  </div>
</template>
