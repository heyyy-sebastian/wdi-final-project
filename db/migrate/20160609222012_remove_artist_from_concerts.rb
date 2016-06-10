class RemoveArtistFromConcerts < ActiveRecord::Migration
  def change
    remove_reference :concerts, :artist, index: true, foreign_key: true
  end
end
