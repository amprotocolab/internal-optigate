class CreatePricePointers < ActiveRecord::Migration[7.0]
  def change
    create_table :price_pointers do |t|
      t.string :subtitle
      t.string :description
      t.references :price, null: false, foreign_key: true

      t.timestamps
    end
  end
end
