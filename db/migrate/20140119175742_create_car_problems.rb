class CreateCarProblems < ActiveRecord::Migration
  def change
    create_table :car_problems do |t|
      t.string :title
      t.integer :car_model_id
      t.timestamps
    end
  end
end
