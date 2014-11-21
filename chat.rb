
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

#------------------------------------------> GET /------------------------------------------------------------------

get('/') do    
   erb :index, :layout => false
end
#------------------------------------------> GET /chat<------------------------------------------------------------------

get '/chat' do
     
    erb :chat, :layout => false
  
end

post '/chat' do

  @blanco = false;
  @repeat = false;
  if (users.include?(params[:name]))
    puts "Fallo 1 - usuario ya creado"
  @repeat = true
  erb :index, :layout =>false
  elsif(params[:name]== '')
    puts "Fallo 2 - nombre en blanco"
  @blanco = true
  erb :index, :layout =>false
  elsif(params[:pass1]== '')
    puts "Fallo 3 - contraseña en blanco"
  @blanco= true
  erb :index, :layout =>false
  else
  name = params[:name]
  session[:name] = name
  users << name
  puts "Este es el usuario de la sesion: #{session[:name]} y de la variable: #{users}"

  erb :chat, :layout =>false
  end
  


end
#------------------------------------------> GET /registrar------------------------------------------------------------------

post('/registrar') do
    name = params[:name]
    
    @repeat = false;
    @contrax = false;
    @blanco = false;

   if (users.include? name)
    puts "Fallo 1"
    @repeat =  true
    erb :registrar, :layout =>false
   elsif (name =='')
    puts "Fallo 2"
    @blanco = true
    erb :registrar, :layout =>false
   elsif (pass2 != pass)
    puts "Fallo 3"
    @contrax =  true
    erb :registrar, :layout =>false
   elsif (pass2 == '')
    puts "Fallo 4"
    @contrax =  true
    erb :registrar, :layout =>false
   elsif (pass == '')
    puts "Fallo 5"
    @contrax = true
    erb :registrar, :layout =>false
   else
    name = params[:name]
    session[:name] = name
    @repeat = false
    @blanco = false
    @contrax = false
    erb :chat, :layout =>false
   end

   
end

get ('/registrar') do
 erb :registrar, :layout =>false
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
  chat << ("-#{session[:name]} ---> #{params['text']}" + "<br>")
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




