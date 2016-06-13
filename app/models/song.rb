class Song < ActiveRecord::Base
  belongs_to :artist
  validates :track_identifier, uniqueness: true
end
