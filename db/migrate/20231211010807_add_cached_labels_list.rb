class AddCachedLabelsList < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :cached_label_list, :string
    Conversation.reset_column_information
    # ActsAsTaggableOn::Taggable::Cache.included(Conversation)
    # Note: This line references a constant that doesn't exist in the current version of acts-as-taggable-on
    # The cached_label_list column works fine without this explicit cache setup
  end
end
