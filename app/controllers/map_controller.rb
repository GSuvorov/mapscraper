class MapController < ApplicationController
  def show
    @address = "601 e 11th st ny ny"
    @image_url = root_url + "images/" + URI.escape(@address) + ".jpg"
    @elapsed_time = 0
    @time_message = ""
    if (params[:update])
      if (params[:update][:address])
        @address = params[:update][:address].to_str()
        @image_url = root_url + "images/" + URI.escape(@address) + ".jpg"
        scale = 2
        zoom = 19
        width = 640
        height = 640
        destination_file = "engine/work/" + @address + ".jpg"
        map_url = "http://maps.googleapis.com/maps/api/staticmap?zoom=19&scale=2&size=640x640&sensor=false&center=" + URI.escape(@address)
        system 'wget -O"'+ destination_file + '" "' + map_url + '"'
        start_time = Time.now
        system 'engine/mapscraper "' + destination_file + '"'
        end_time = Time.now
        @elapsed_time = (end_time - start_time) * 1000
        @time_message = "Completed in " + @elapsed_time.to_i().to_s() + " milliseconds."
      end
    end
  end
end
