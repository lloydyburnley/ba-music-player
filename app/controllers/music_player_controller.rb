class MusicPlayerController < ApplicationController
  layout Proc.new { |controller| controller.request.xhr? ? false : 'application' }
  def home
    @hash = params[:play]
    
  end
  def fetch

    require 'open-uri'
    @query = params[:q].nil?  ? '' : params[:q]

    #######################################################
    @apiKey = 'YOUR API KEY' #Will return 401 if not set :)
    #######################################################

    doc = JSON.parse(open('http://api.soundcloud.com/tracks.json?q=' + @query.to_s + '&client_id=' + @apiKey.to_s ).read)
    @final = doc.map do |track|
       { 
        :id          => track['id'], 
        :artwork_url => track['artwork_url'], 
        :label_name  => track['label_name'], 
        :title       => track['title'],
        :desc       => track['description']
      } 
    end
  end

  def addListaned
    #still developing, add music after pushstate hash set
    #see config/schema for info abouut migration
    MusicPlayer.create(:music => params[:musicname], :musicid => params[:id] ) 
  end

end