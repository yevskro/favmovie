class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name
      t.string :birth_date
      t.string :birth_place
    end
  end
end
