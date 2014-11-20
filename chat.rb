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

users = Array.new()

contraseña = String.new
contraeña2 = String.new
blanco = false
repeat = false
contrax = false
#------------------------------------------> GET /------------------------------------------------------------------

get('/') do
    if !session[:nombre]
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
  puts "Este es el usuario de la sesion: #{session[:name]} y de la variable: #{users}"

  erb :chat
  end
  


end
#------------------------------------------> GET /registrar------------------------------------------------------------------

get('/registrar') do
    name = params[:name]
    pass = params[:contra1]
    pass2 = params[:contra2]

   if (users.include? name)
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
    name = params[:nombre]
    session[:nombre] = name
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
  
  
get '/nombres' do
   enviar = "<ul id='listuser'>"
   users.each do | name |
     enviar = enviar + "<li>" + user.to_s + "</li>"
   end
   enviar = enviar + "</ul>"
   enviar.to_s
end

#------------------------------------------> GET /send<------------------------------------------------------------------


get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << ("#{session[:name]} :::: #{params['text']}" + "<hr>")
  nil
end

#------------------------------------------> GET /update<------------------------------------------------------------------
get '/listuser' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @users = users
  puts @users
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




