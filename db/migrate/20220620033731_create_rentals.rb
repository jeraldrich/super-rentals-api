class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      # Owner.
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :city
      # t.string :location #Json not exist in sqlite without ext.
      t.float :lat
      t.float :lng
      t.string :category
      t.string :image
      t.string :street_address
      t.integer :bedrooms
      t.text :description

      t.timestamps
    end
  end
end
