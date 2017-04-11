class StaticPagesController < ApplicationController

  def home
  	unless params[:my_flickr_id].nil?
  		@photos = flickr.photos.search(user_id:params[:my_flickr_id])	  
  	end
  end


end
