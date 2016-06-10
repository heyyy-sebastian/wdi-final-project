class RemoveDateFromConcerts < ActiveRecord::Migration
  def change
    remove_column :concerts, :date, :string
  end
end
