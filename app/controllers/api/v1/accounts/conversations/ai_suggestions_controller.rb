class Api::V1::Accounts::Conversations::AiSuggestionsController < Api::V1::Accounts::Conversations::BaseController
  def create
    if params[:selection]
      Rails.logger.info("AI suggestion selected", conversation_id: @conversation.id, selection: params[:selection])
      head :ok
      return
    end

    suggestions = AiReplySuggestionService.new(@conversation).perform
    render json: { suggestions: suggestions }
  end
end
