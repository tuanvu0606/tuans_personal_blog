class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :name
      t.references :user_id, foreign_key: true
      t.references :faculty, foreign_key: true

      t.timestamps
    end
  end
end
