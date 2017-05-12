class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true
      t.string :status, default: 'new'
      t.string :tag
      t.datetime :deadline_time

      t.timestamps
    end
  end
end
