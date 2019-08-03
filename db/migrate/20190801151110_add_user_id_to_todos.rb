class AddUserIdToTodos < ActiveRecord::Migration[4.2]
  def change
    add_column :todos, :user_id, :integer
  end
end
