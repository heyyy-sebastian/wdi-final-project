class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.references :artist, index: true, foreign_key: true
      t.string :location
      t.string :date

      t.timestamps null: false
    end
  end
end
