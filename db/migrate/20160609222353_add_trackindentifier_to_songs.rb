class AddTrackindentifierToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :track_indentifier, :string
  end
end
