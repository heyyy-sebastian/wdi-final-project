class UsersController < ApplicationController

  def index
    #@user = User.current.id
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


#epic method to save songs, votes and concerts into the db
  def save_song_votes
    #extract song identifiers from params and push them into an array
    songs_from_params = params.to_a[1..3]
    song_collection = []

    songs_from_params.each do |identifier|
      song = identifier[0].gsub('song_vote_', '')
      song_collection.push(song)
    end
    #loop through the collection of songs and save each one
    song_collection.each do |song|

      #look for song in db
      check_for_song = Song.exists?(track_identifier: song)

      #if it exists, do stuff; if it doesn't, save it
      if check_for_song
        #check for concert
        check_for_concert = Concert.exists?(concert_identifier: params['concert-name'])

        #if concert exists, upvote song
        if check_for_concert
          check_for_song_vote_concert = Vote.exists?(concert_id: params['concert-name'])
          check_for_song_vote_track = Song.exists?(track_identifier: song)
          if check_for_song_vote_concert && check_for_song_vote_track

          #upvote
          else
            #add track to db to upvote it

          end

        else
        #create the concert
        #create song to upvote it
        end
        #save concert if it doesn't exit
        #increase the votes on the song
      else
        #save song to db
        #check for concert
        #save concert if it doesn't exit
        #increase the votes on the song

      end

    end #end song_collection.each

    binding.pry
    puts params.inspect
    render "users/index"
  end

#part of new user creation method below
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


  private
  #define strong params
    def user_params
      params
      .require(:user)
      .permit(:email, :password, :first_name, :last_name)
    end

    # def song_votes_params
    #   params
    #   .require(:song)

    # end

  #check if song exists in songs table





end
