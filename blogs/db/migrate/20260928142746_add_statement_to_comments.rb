class AddStatementToComments < ActiveRecord::Migration[8.1]
  def change
    add_column :comments, :statement, :text
  end
end
