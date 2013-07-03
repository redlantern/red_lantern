class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :sender
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
