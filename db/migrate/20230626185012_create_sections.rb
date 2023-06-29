class CreateSections < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.references :teacher, foreign_key: true, null: false
      t.references :subject, foreign_key: true, null: false
      t.integer :class_room, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.integer :regularity, default: 0
      t.integer :duration, default: :default, null: false

      t.timestamps
    end
  end
end
