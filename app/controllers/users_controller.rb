class UsersController < ApplicationController

  def index
  # @test = RSpotify::Artist.search('Rihanna').first.top_tracks(:US)[0]
  # binding.pry
  end

  def find_artist
    #Find Artist from Spotify
    artistname = params[:q]
    spotify_url = RSpotify::Artist.search(artistname).first
    artist = spotify_url.name

    #Find Upcoming Concerts from Bands in Town
    bit_api = ENV['BIT_ID']
    artistname_bit = params[:q].gsub(' ', '%20')
    concerts = HTTParty.get('http://api.bandsintown.com/artists/'+artistname_bit+'/events.json?api_version=2.0&app_id='+bit_api)
    results = [artist, concerts]
    @artist = results[0]
    @artist_img = spotify_url.images[2]['url']
    @concerts = results[1]

    #Find Top 6 Tracks from Spotify for Concert Votes

    @song_results = spotify_url.top_tracks(:US)[0..5]
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
