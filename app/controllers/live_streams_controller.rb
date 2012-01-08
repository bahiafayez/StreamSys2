class LiveStreamsController < ApplicationController
  
    def index
    @title = "All Live Streams"
    @live_streams = LiveStream.paginate(:page => params[:page])
  end
  
  def new
    @title ="Add Live Stream"
    @live_stream=LiveStream.new
    @cats=Category.all
  end
  
  def create
    @live_stream = LiveStream.new(params[:live_stream])
   
    if @live_stream.save
      # Handle a successful save.
      #sign_in2 @user #method in sessions_helper
      flash[:success] = "Welcome to the Sample App!"
      @categories= params[:cats]
    logger.debug "HEREEEEEEEEEEEEEEEEEEEEEEEEE"
    logger.debug params[:cats]
    for x in params[:cats]
      logger.debug x[0]
      @cat = StreamType.new(:live_stream_id => @live_stream.id, :category_id => x[0])
      @cat.save
    end
      redirect_to @live_stream
    else
      #@title = "Sign up"
      render 'new'
    end
  end
  
    def show
    #What this means in the context of users—which we’re now thinking 
    #of as a Users resource—is that we should view the user with id 1 
    #by issuing a GET request to the URL /users/1. Here the show action 
    #is implicit in the type of request—when Rails’ REST features are 
    #activated, GET requests are automatically handled by the show action.
      @stream= params[:url]
      @piece= params[:piece]
      @moment = LiveStream.find_by_URL(params[:url])
      
      respond_to do |format|
        format.html do
           @live_stream = LiveStream.find(params[:id])
          @title = @live_stream.name
        end
        format.json do
          if @moment.nil?
            render :json => ({"moment"=>"none"})  
          else
            
            @liveID=@moment.id
            @RS=ResultingStream.all(:conditions => {:live_stream_id =>@liveID})
            if @RS.nil? || @RS.empty?
              render :json => ({"moment"=>"Off Air","ads"=>"empty", "bla" => "bla"})
            else
              @RS_ID= @RS.first.id
              @RSStream=StreamPlaylist.all(:conditions => {:resulting_stream_id =>@RS_ID})
              #assumes only one returned for now!!
              #@RSStream.each do |i|
              #end
              if @RSStream.nil? || @RSStream.empty?
                render :json => ({"moment"=>@RS.first.streamURL,"sPlaylist"=>@RS.first.index_file,"ads"=>"empty", "bla" => "bla"})
              else
              
                @Playlist= AdPlaylist.all(:conditions => {:playlist_id => @RSStream.first.playlist_id})
                @arr=[]
                @hash ={}
                @Playlist.each do |i|
                  @arr << i.ad_id
                  logger.debug "@arr is "
                  key=Ad.all(:conditions => {:id => i.ad_id}).first.index_file
                  
                  if @hash.has_key?(key)
                    @hash[key]<<[Ad.all(:conditions => {:id => i.ad_id}).first.URL, i.time, Ad.all(:conditions => {:id => i.ad_id}).first.duration, Ad.all(:conditions => {:id => i.ad_id}).first.region]
                  else
                    @hash[key]=[[Ad.all(:conditions => {:id => i.ad_id}).first.URL, i.time, Ad.all(:conditions => {:id => i.ad_id}).first.duration, Ad.all(:conditions => {:id => i.ad_id}).first.region]]
                   end
                end
                @adNames=[]
               
                @arr.each do |i|
                  @adNames << Ad.all(:conditions => {:id => i}).first.name  
                end
              
                render :json => ({"moment"=>@RS.first.streamURL,"sPlaylist"=>@RS.first.index_file,"ads"=> @adNames, "ad_urls" => @hash , "bla" => "bla"})
              end
            end
          end 
        end
      end
    end
end
