class CreateLeaveWords < ActiveRecord::Migration[5.1]
  def change
    create_table :leave_words do |t|
      t.text :body, null:false
      t.timestamp :created_at, null: false
    end
  end
end
