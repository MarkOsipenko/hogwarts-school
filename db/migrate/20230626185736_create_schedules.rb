class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.references :student, foreign_key: true, null: false
      t.references :section, foreign_key: true, null: false
      t.datetime :beginning_at, null: false
      t.datetime :finished_at, null: false

      t.timestamps
    end
  end
end
