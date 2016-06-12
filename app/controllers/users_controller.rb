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

    #assign params to variables
    concert_identifier = params['concert-name']

    #loop through the collection of songs and save each one
    song_collection.each do |song|

      #look for song in db
      check_for_song(song)

      #if it exists, do stuff; if it doesn't, save it
      if check_for_song
        #the song exists, assign it to a variable
        voted_song = Song.find(track_identifier: song)
        #find song id to pass in later
        voted_song_id = voted_song.id

        #check for concert
        check_for_concert(concert_identifier)

        #if concert exists, check to see if it exists in vote table
        check_concert_to_upvote

        #if the song exists, but the concert doesn't, create a new one with the song in the
        #Vote table to go with it (song already exists in songs table)
        else
        #create the concert
          new_concert = Concert.create(concert_identifier: concert_identifier)
          new_concert_id = new_concert.id
        #create song to upvote it
          Vote.create(song_id: voted_song_id, concert_id: new_concert_id)
        end

      #if the song does not exist in Song table, create everything
      else
        #save song to db
        new_song = Song.create(track_identifier: song)

        #check for concert
        check_for_concert(concert_identifier)
        check_concert_to_upvote
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
  def check_for_song(song)
    Song.exists?(track_identifier: song)
  end

  #check if concert exists in concert table
  def check_for_concert(concert_finder)
    Concert.exists?(concert_identifier: concert_finder)
  end

  #check if the concert exists in the votes table
  def check_for_song_vote_concert(concert_finder)
    concert = Concert.find_by(concert_identifier: concert_finder)
    Vote.exists?(concert_id: concert.id)
  end

  #check if the song exists in the votes table
  def check_for_song_vote_track(song_finder)
    song_vote_id = Song.find_by(song_finder)
    Song.exists?(track_identifier: song_vote_id.id)
  end

  #increase the number of votes on the song in the Vote table
  def upvote(new_vote)
    new_vote.increment_counter(:num_votes, new_vote.id)
  end

  def check_concert_to_upvote
        if check_for_concert
          #the concert exists, so find its id for upvoting
          existing_concert = Concert.find_by(concert_identifier)
          existing_concert_id = existing_concert.id

          check_for_song_vote_concert(existing_concert)
          check_for_song_vote_track(voted_song)
          #if the song exists in the vote table, upvote it
          if check_for_song_vote_concert && check_for_song_vote_track
            upvote(voted_song)
            redirect_to "/users"
          else
            Vote.create(song_id: voted_song_id, concert_id: existing_concert_id)
            upvote(voted_song)
            #add track to db to upvote it
            redirect_to "/users"
          end
    end

end
