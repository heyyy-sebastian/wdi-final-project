class RemoveLocationFromConcerts < ActiveRecord::Migration
  def change
    remove_column :concerts, :location, :string
  end
end
