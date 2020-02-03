class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :image
      t.string :name
      t.string :description
      t.string :age
      t.string :sex
      t.string :adoptable
    end
  end
end
