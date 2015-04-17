class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.string :description
      t.integer :moderator_id, null: false
    end

    add_index :subs, :moderator_id
    add_index :subs, :title, unique: true
  end
end
