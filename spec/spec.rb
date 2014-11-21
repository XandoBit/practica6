require 'coveralls'
Coveralls.wear!
ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'rack/test'
require 'rubygems'
require 'rspec'

include Rack::Test::Methods
describe "Testing specs" do

   def app
      Sinatra::Application
   end
    
    it "Without session init" do
       get '/', {}, 'rack.session' => { :name => 'Testing' }
       expect(last_response).to be_ok
    end
    
    it "With session" do
       get '/'
       expect(last_response).to be_ok
    end
    
    it "Testing post" do
       post '/'
       expect(last_response).to be_ok
    end

    it "/send" do
    get '/send'
    expect(last_response.body).to eq("Not an ajax request")
    end


    it "/update" do
    get '/update'
    expect(last_response.body).to eq("Not an ajax request")
    end