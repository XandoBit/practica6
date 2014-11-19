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


#------------------------------------------> usuarios <------------------------------------------------------------------

users = Array.new
nombre = String.new
contraseña = String.new
contraeña2 = String.new
blanco = false
repeat = false
#------------------------------------------> GET /------------------------------------------------------------------

get('/') do
   erb :index
end
#------------------------------------------> GET /chat<------------------------------------------------------------------

get '/chat' do
   name = params[:name]

   if (users.include? name)
    @repeat = repeat = true
    erb :index
   elsif (name =='')
    @blanco = blanco = true
    erb :index
   else
    nombre = name
    users << name
    repeat = false
    blanco = false
    erb :chat
   end
end
#------------------------------------------> GET /logout<------------------------------------------------------------------

get '/logout' do
   users.delete (nombre)
   nombre = ""
   @repeat = repeat = 0
   redirect '/'
end


#------------------------------------------> GET /*<------------------------------------------------------------------
  
  

#------------------------------------------> GET /send<------------------------------------------------------------------
get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "#{request.ip} : #{params['text']}"
  nil
end
#------------------------------------------> GET /update<------------------------------------------------------------------



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



