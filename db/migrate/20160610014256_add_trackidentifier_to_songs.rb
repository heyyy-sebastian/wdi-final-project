class AddTrackidentifierToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :track_identifier, :string
  end
end
