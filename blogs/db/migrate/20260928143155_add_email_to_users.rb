class AddEmailToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :email, :string, presence: true, uniqueness: true
  end
end
