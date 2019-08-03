class CreateTodos < ActiveRecord::Migration[4.2]
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
