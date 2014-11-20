require 'sinatra' 
require 'sinatra/reloader' if development?

require 'uri'
#set :port, 3000
#set :environment, :production

#------------------------------------------> variable chat<------------------------------------------------------------------

chat = ['Bienvenido Amig@ al chat']

enable :sessions
set :session_secret, '*&(^#234a)'

#------------------------------------------> usuarios <------------------------------------------------------------------

users = Array.new

contraseña = String.new
contraseña2 = String.new
blanco = false
repeat = false
contrax = false
#------------------------------------------> GET /------------------------------------------------------------------

get('/') do
    if !session[:name]
   erb :index

 else
    erb :chat
  end
end
#------------------------------------------> GET /chat<------------------------------------------------------------------

get '/chat' do
     
    erb :chat
  
end

post '/chat' do
  if (users.include?(params[:name]))
  redirect '/'
  else
  name = params[:name]
  session[:name] = name
  users << name
  puts users
  #puts name
  erb :chat
  end
  
end
#------------------------------------------> GET /registrar------------------------------------------------------------------

get('/registrar') do
    name = params[:name]
    pass = params[:contra1]
    pass2 = params[:contra2]

    if (users.include?(params[:name]))
    @repeat = repeat = true
    erb :registrar
   elsif (name =='')
    @blanco = blanco = true
    erb :registrar
   elsif (pass2 != pass)
    @contrax = contrax = true
    erb :registrar
   elsif (pass2 == '')
    @contrax = contrax = true
    erb :registrar
   elsif (pass == '')
    @contrax = contrax = true
    erb :registrar
   else
    name = params[:name]
    session[:name] = name
    repeat = false
    blanco = false
    contrax = false
    erb :chat
   end

   
end
#------------------------------------------> GET /logout<------------------------------------------------------------------

get '/logout' do
   users.delete (session[:name])
   session.clear
   redirect '/'
end


#------------------------------------------> GET /*<------------------------------------------------------------------
  
  

#------------------------------------------> GET /send<------------------------------------------------------------------
get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{session[:name]} : #{params['text']}"
  nil
end
#------------------------------------------> GET /update<------------------------------------------------------------------
get '/listuser' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @users = users
  erb <<-'HTML', :layout => false
      <% @users.each do |phrase| %>
        <%= phrase %> <br />
      <% end %>
  HTML
end


get '/update' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @updates = chat[params['last'].to_i..-1] || []

  @last = chat.size
  erb <<-'HTML', :layout => false
      <% @updates.each do |phrase| %>
        <%= phrase %> <br />
      <% end %>
      <span data-last="<%= @last %>"></span>
  HTML
end




