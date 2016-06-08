class UsersController < ApplicationController

  def index
  end

  def find_artist
    #Find Artist from Spotify
    artistname = params[:q]
    spoitfy_url = RSpotify::Artist.search(artistname).first
    artist = spoitfy_url.name

    #Find Upcoming Concerts from Bands in Town
    bit_api = ENV['BIT_ID']
    concerts = HTTParty.get('http://api.bandsintown.com/artists/'+artistname+'/events.json?api_version=2.0&app_id='+bit_api)
    results = [artist, concerts]
    @artist = results[0]
    @concerts = results[1]
    #binding.pry
    render "users/index"
  end

  def find_songs
    #Find Top Tracks from Spotify for Concert Votes
    @artist = params['user']
    spoitfy_url = RSpotify::Artist.search(@artist).first
    @song_results = spoitfy_url.top_tracks(:US)
    render "users/index"
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
