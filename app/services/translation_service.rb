require 'google/cloud/translate/v3'

class TranslationService
  pattr_initialize []

  def detect_language(text)
    return if text.blank? || client.blank?

    response = client.detect_language(
      content: text,
      parent: "projects/#{project_id}"
    )
    response.languages.first.language_code if response&.languages&.first
  rescue StandardError => e
    Rails.logger.error("translation_detect_error: #{e.message}")
    nil
  end

  def translate(text, target_language, source_language: nil)
    return if text.blank? || target_language.blank? || client.blank?

    response = client.translate_text(
      contents: [text],
      target_language_code: target_language,
      parent: "projects/#{project_id}",
      mime_type: 'text/plain',
      source_language_code: source_language
    )
    response.translations.first.translated_text if response&.translations&.first
  rescue StandardError => e
    Rails.logger.error("translation_translate_error: #{e.message}")
    nil
  end

  private

  def project_id
    ENV['GOOGLE_CLOUD_TRANSLATE_PROJECT_ID']
  end

  def credentials
    ENV['GOOGLE_CLOUD_TRANSLATE_CREDENTIALS']
  end

  def client
    return @client if defined?(@client)
    return if credentials.blank? || project_id.blank?

    @client = ::Google::Cloud::Translate::V3::TranslationService::Client.new do |config|
      config.credentials = credentials
    end
  end
end
