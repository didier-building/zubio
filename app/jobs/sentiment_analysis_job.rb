class SentimentAnalysisJob < ApplicationJob
  queue_as :default

  POSITIVE_WORDS = %w[good great happy love excellent].freeze
  NEGATIVE_WORDS = %w[bad sad angry hate terrible].freeze

  def perform(message_id)
    message = Message.find_by(id: message_id)
    account = message&.conversation&.account
    return unless account&.feature_enabled?('sentiment_analysis')
    return unless account.sentiment_analysis

    score = analyze_sentiment(message.content)
    update_conversation_sentiment(message.conversation, score)
  end

  private

  def analyze_sentiment(text)
    return 0 if text.blank?

    words = text.downcase.scan(/\w+/)
    words.count { |w| POSITIVE_WORDS.include?(w) } -
      words.count { |w| NEGATIVE_WORDS.include?(w) }
  end

  def update_conversation_sentiment(conversation, score)
    previous = conversation.sentiment_score.to_i
    trend = if score > previous
              'up'
            elsif score < previous
              'down'
            else
              'neutral'
            end

    attrs = conversation.additional_attributes || {}
    attrs['sentiment_trend'] = trend
    conversation.update(sentiment_score: score, additional_attributes: attrs)
  end
end
