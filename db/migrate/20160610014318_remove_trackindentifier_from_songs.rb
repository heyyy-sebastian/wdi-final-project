class RemoveTrackindentifierFromSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :track_indentifier, :string
  end
end
