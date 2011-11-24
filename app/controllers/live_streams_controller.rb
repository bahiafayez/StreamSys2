class LiveStreamsController < ApplicationController
  
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
                render :json => ({"moment"=>@RS.first.streamURL,"ads"=>"empty", "bla" => "bla"})
              else
              
                @Playlist= AdPlaylist.all(:conditions => {:playlist_id => @RSStream.first.playlist_id})
                @arr=[]
                @hash ={}
                @Playlist.each do |i|
                  @arr << i.ad_id
                  @hash[Ad.all(:conditions => {:id => i.ad_id}).first.URL]=i.time
                end
                @adNames=[]
               
                @arr.each do |i|
                  @adNames << Ad.all(:conditions => {:id => i}).first.name  
                end
              
                render :json => ({"moment"=>@RS.first.streamURL,"ads"=> @adNames, "ad_urls" => @hash, "bla" => "bla"})
              end
            end
          end 
        end
      end
    end
end
