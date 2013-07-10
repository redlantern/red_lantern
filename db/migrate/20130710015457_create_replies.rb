class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.references :ticket
      t.string :sender
      t.text :body

      t.timestamps
    end
    add_index :replies, :ticket_id
  end
end
