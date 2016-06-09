class UsersController < ApplicationController

  def index

  end

#find the artist & artist information on search
  def find_artist
    #Find Artist from Spotify
    @artistname = params[:q]
    spotify_url = RSpotify::Artist.search(@artistname).first

    #prevent no-method-for-nil-class-error if artist cannot be found
    if spotify_url.nil?
      spotify_url
    else
      @artist = spotify_url.name
      #Find Upcoming Concerts from Bands in Town
      bit_api = ENV['BIT_ID']
      artistname_bit = params[:q].gsub(' ', '%20')
      @concerts = HTTParty.get('http://api.bandsintown.com/artists/'+artistname_bit+'/events.json?api_version=2.0&app_id='+bit_api)

      #Find artist img from Spotify
      @artist_img = spotify_url.images[2]['url']

      #Find number of upcoming shows from BIT
      @num_shows = @concerts.length

      #Find Top 6 Tracks from Spotify for Concert Votes
      @song_results = spotify_url.top_tracks(:US)[0..5]
    end

    render "users/index"
  end

#part of new user creation method
  def new
    #needs empty object to be initialized
    @user = User.new
  end

#create a new user when user registers
  def create
     @user = User.new(user_params)
    if @user.save
    redirect_to '/users/index'
    else
    redirect_to '/signup'
    end
  end

#define strong params
  private
    def user_params
      params
      .require(:user)
      .permit(:email, :password, :first_name, :last_name)
    end
end
