class AddStatementToComments < ActiveRecord::Migration[8.1]
  def change
    add_column :comments, :statement, :text, presence: true, null: false
  end
end
