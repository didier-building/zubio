import { frontendURL } from '../../helper/URLHelper';
import SentimentReport from './SentimentReport.vue';
import { FEATURE_FLAGS } from 'dashboard/featureFlags';

export default {
  routes: [
    {
      path: frontendURL('accounts/:accountId/reports/sentiment'),
      name: 'sentiment_reports',
      meta: {
        permissions: ['administrator', 'report_manage'],
        featureFlag: FEATURE_FLAGS.REPORTS,
      },
      component: SentimentReport,
    },
  ],
};
