class AddCommentToCrawlers < ActiveRecord::Migration[5.0]
  def change
    add_column :crawlers, :comment, :string
  end
end
