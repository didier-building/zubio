class AddSentimentScoreToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :sentiment_score, :integer
  end
end
