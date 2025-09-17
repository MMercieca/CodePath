class CreateLecturesStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :lecture_students do |t|
      t.references :lecture, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
