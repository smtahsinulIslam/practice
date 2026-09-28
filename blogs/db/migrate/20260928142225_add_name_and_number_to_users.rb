class AddNameAndNumberToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string, presence: true
    add_column :users, :number, :string, limit: 11, presence: true, uniqueness: true
  end
end
