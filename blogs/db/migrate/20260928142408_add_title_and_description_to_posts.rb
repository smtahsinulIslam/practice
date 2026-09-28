class AddTitleAndDescriptionToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :title, :string, presence: true
    add_column :posts, :description, :string
  end
end
