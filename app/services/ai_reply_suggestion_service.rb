class AiReplySuggestionService
  FALLBACK_MESSAGES = [
    "I'm looking into this for you.",
    "Thanks for your message. We'll get back to you shortly."
  ].freeze

  pattr_initialize [:conversation!]

  def perform
    return FALLBACK_MESSAGES unless feature_enabled?

    body = {
      conversation: formatted_conversation
    }.to_json

    response = HTTParty.post(api_url, headers: headers, body: body)
    return parse_suggestions(response) if response.success?

    FALLBACK_MESSAGES
  rescue StandardError => e
    Rails.logger.error "AI suggestion error: #{e.message}"
    FALLBACK_MESSAGES
  end

  private

  def feature_enabled?
    ENV.fetch('AI_REPLY_SUGGESTION_ENABLED', 'false') == 'true' &&
      api_key.present? &&
      conversation.account.ai_suggestions_enabled
  end

  def api_key
    ENV['AI_REPLY_SUGGESTION_API_KEY']
  end

  def api_url
    ENV.fetch('AI_REPLY_SUGGESTION_URL', 'https://example.com/v1/suggestions')
  end

  def headers
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{api_key}"
    }
  end

  def formatted_conversation
    LlmFormatter::LlmTextFormatterService.new(conversation).format
  end

  def parse_suggestions(response)
    suggestions = response.parsed_response['suggestions']
    suggestions.presence || FALLBACK_MESSAGES
  end
end
