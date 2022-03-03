class CreateBreweries < ActiveRecord::Migration[6.1]
  def change
    create_table :breweries do |t|
      t.string :name
      t.integer :user_id
      t.string :url
      t.string :address

      t.timestamps
    end
  end
end
