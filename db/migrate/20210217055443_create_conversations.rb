class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.text :name
      t.boolean :status

      t.timestamps
    end
  end
end
