<script setup>
import { computed } from 'vue';
import { useI18n } from 'vue-i18n';
import { getLanguageName } from 'dashboard/components/widgets/conversation/advancedFilterItems/languages';
import ContactDetailsItem from './ContactDetailsItem.vue';
import CustomAttributes from './customAttributes/CustomAttributes.vue';
import SentimentBadge from 'dashboard/components/widgets/conversation/SentimentBadge.vue';

const props = defineProps({
  conversationAttributes: {
    type: Object,
    default: () => ({}),
  },
  contactAttributes: {
    type: Object,
    default: () => ({}),
  },
});

const referer = computed(() => props.conversationAttributes.referer);
const initiatedAt = computed(
  () => props.conversationAttributes.initiated_at?.timestamp
);

const browserInfo = computed(() => props.conversationAttributes.browser);

const browserName = computed(() => {
  if (!browserInfo.value) return '';
  const { browser_name: name = '', browser_version: version = '' } =
    browserInfo.value;
  return `${name} ${version}`;
});

const browserLanguage = computed(() =>
  getLanguageName(props.conversationAttributes.browser_language)
);

const sentimentScore = computed(
  () => props.conversationAttributes.sentiment_score
);

const platformName = computed(() => {
  if (!browserInfo.value) return '';
  const { platform_name: name = '', platform_version: version = '' } =
    browserInfo.value;
  return `${name} ${version}`;
});

const createdAtIp = computed(() => props.contactAttributes.created_at_ip);

const { t } = useI18n();

const staticElements = computed(() =>
  [
    {
      content: initiatedAt,
      title: t('CONTACT_PANEL.INITIATED_AT'),
      key: 'static-initiated-at',
      type: 'static_attribute',
    },
    {
      content: browserLanguage,
      title: t('CONTACT_PANEL.BROWSER_LANGUAGE'),
      key: 'static-browser-language',
      type: 'static_attribute',
    },
    {
      content: referer,
      title: t('CONTACT_PANEL.INITIATED_FROM'),
      key: 'static-referer',
      type: 'static_attribute',
    },
    {
      content: browserName,
      title: t('CONTACT_PANEL.BROWSER'),
      key: 'static-browser',
      type: 'static_attribute',
    },
    {
      content: platformName,
      title: t('CONTACT_PANEL.OS'),
      key: 'static-platform',
      type: 'static_attribute',
    },
    {
      content: createdAtIp,
      title: t('CONTACT_PANEL.IP_ADDRESS'),
      key: 'static-ip-address',
      type: 'static_attribute',
    },
  ].filter(attribute => !!attribute.content.value)
);
</script>

<template>
  <div class="conversation--details">
    <div v-if="sentimentScore !== undefined" class="mb-2">
      <SentimentBadge :score="sentimentScore" />
    </div>
    <CustomAttributes
      :static-elements="staticElements"
      attribute-class="conversation--attribute"
      attribute-from="conversation_panel"
      attribute-type="conversation_attribute"
    >
      <template #staticItem="{ element }">
        <ContactDetailsItem
          :key="element.title"
          :title="element.title"
          :value="element.content.value"
        >
          <a
            v-if="element.key === 'static-referer'"
            :href="element.content.value"
            rel="noopener noreferrer nofollow"
            target="_blank"
            class="text-n-brand"
          >
            {{ element.content.value }}
          </a>
        </ContactDetailsItem>
      </template>
    </CustomAttributes>
  </div>
</template>
