class UsersController < ApplicationController

  def index
    #Find Artist from Spotify
    @artist = RSpotify::Artist.search('Beyoncé').first.name

    #Find Upcoming Concerts from Bands in Town

    # Bandsintown.app_id = ENV['BIT_ID']
    # artist = Bandsintown::Artist.new({
    #     :name => "Beyoncé"
    #     })
    # @events = artist.events

    #Find Upcoming Concerts from SongKick
    # remote = Songkickr::Remote.new ENV['SK_API']
    # @concerts = remote.

    #Find Top Tracks from Spotify for Concert Votes
    @song_results = RSpotify::Artist.search('Beyoncé').first.top_tracks(:US)
    #Save Top Tracks Search results into an array
    songs = []
    results_list = @song_results.each do |track|
      songs.push(track.name)
    end

  end

  def new
    #needs empty object to be initialized
    @user = User.new
  end

  def create
     @user = User.new(user_params)
    if @user.save
    redirect_to '/users/index'
    else
    redirect_to '/signup'
    end
  end

  private
    def user_params
      params
      .require(:user)
      .permit(:email, :password, :first_name, :last_name)
    end
end
