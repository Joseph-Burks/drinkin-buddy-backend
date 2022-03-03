class CreateBeers < ActiveRecord::Migration[6.1]
  def change
    create_table :beers do |t|
      t.string :name
      t.integer :brewery_id
      t.string :style
      t.string :description
      t.float :alcohol_content
      t.integer :bitterness

      t.timestamps
    end
  end
end
