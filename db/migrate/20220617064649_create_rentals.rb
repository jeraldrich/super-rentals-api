class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.string :title
      t.string :city
      t.string :location
      t.string :category
      t.string :image
      t.integer :bedrooms
      t.text :description

      t.timestamps
    end
  end
end
