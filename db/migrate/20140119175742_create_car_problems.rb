class CreateCarProblems < ActiveRecord::Migration
  def change
    create_table :car_problems do |t|
      t.string :title
    end
  end
end
