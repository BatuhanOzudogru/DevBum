class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :suite
      t.string :city
      t.string :zipcode
      t.float :latitude
      t.float :longitude
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
