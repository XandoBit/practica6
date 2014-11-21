# Imports
require 'sinatra'
require 'sinatra/flash'
require 'sinatra/reloader' if development?
require 'haml'
require 'json'
require 'rubygems'

require 'uri'
require 'data_mapper'
require 'pry'
require 'erubis'               
require 'pp'
require 'chartkick'
require 'xmlsimple'
require 'restclient'
require 'dm-timestamps'
require 'dm-core'
require 'dm-types'


#------------------------------------------> variable chat<------------------------------------------------------------------

chat = ['Bienvenido Amig@ al chat']

enable :sessions
set :session_secret, '*&(^#234a)'

#------------------------------------------> usuarios <------------------------------------------------------------------

users = Array.new()
blanco = false
repeat = false
contrax = false
#------------------------------------------> GET /------------------------------------------------------------------

get('/') do
    
   erb :index, :layout => false

 
 
end
#------------------------------------------> GET /chat<------------------------------------------------------------------

get '/chat' do
     
    erb :chat, :layout => false
  
end

post '/chat' do

  if (users.include?(params[:name]))
  repeat = true
  redirect '/'
  elsif(params[:name]== '')
  blanco = true
  redirect '/'
  elsif(params[:pass1]== '')
  blanco= true
  redirect '/'
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
    pass = params[:pass1]
    pass2 = params[:pass2]

   if (users.include? name)
    @repeat = repeat = true
    erb :registrar, :layout =>false
   elsif (name =='')
    @blanco = blanco = true
    erb :registrar, :layout =>false
   elsif (pass2 != pass)
    @contrax = contrax = true
    erb :registrar, :layout =>false
   elsif (pass2 == '')
    @contrax = contrax = true
    erb :registrar, :layout =>false
   elsif (pass == '')
    @contrax = contrax = true
    erb :registrar, :layout =>false
   else
    name = params[:name]
    session[:name] = name
    repeat = false
    blanco = false
    contrax = false
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




