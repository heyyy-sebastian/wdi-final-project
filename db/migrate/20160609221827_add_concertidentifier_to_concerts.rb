class AddConcertidentifierToConcerts < ActiveRecord::Migration
  def change
    add_column :concerts, :concert_identifier, :string
  end
end
