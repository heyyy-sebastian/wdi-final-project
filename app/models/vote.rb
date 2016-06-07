class Vote < ActiveRecord::Base
  belongs_to :concert
  belongs_to :song
end
