class UsersController < ApplicationController

  def index
    #Find Artist from Spotify
    @artist = RSpotify::Artist.search('Rihanna').first.name

    #Find Upcoming Concerts from Bands in Town
    bit_api = ENV['BIT_ID']
    @concerts = HTTParty.get('http://api.bandsintown.com/artists/Rihanna/events.json?api_version=2.0&app_id='+bit_api)

    #Find Top Tracks from Spotify for Concert Votes
    @song_results = RSpotify::Artist.search('Rihanna').first.top_tracks(:US)
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
