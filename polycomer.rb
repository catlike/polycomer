require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
    return 'Hello world'
end

get '/hello/' do
  
  params[:mac] = ""
    erb :hello_form
end

post '/hello/' do
    mac = params[:mac].to_s
    extension = params[:extension].to_s 
    voicemail = params[:voicemail].to_s 
    timezone = params[:timezone].to_s 
    
    file_names = ['rssets/eg-basic_EXAMPLE.cfg']

    file_names.each do |file_name|

      text = File.read(file_name)

      new_contents = text.gsub(/AAAAAAAAAAA/, extension).gsub(/BBBBBBBBBBB/, voicemail).gsub(/TIMEZONE/, timezone)

      # To merely print the contents of the file, use:

      # puts new_contents

 

      # To write changes to the file, use:

      File.open(phone_configs/"reg-basic_"+mac+".cfg", "w") {|file| file.puts new_contents }
    end
    
    send_file("reg-basic_"+mac+".cfg", :filename =>"reg-basic_"+mac+".cfg", :type => 'Application/octet-stream')
    
    redirect back
 

end
