ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require_relative '../chat.rb'


include Rack::Test::Methods

def chat
    Sinatra::Application
end

describe "Chat SYTW" do
    
    
    it "Should return index" do
        get '/'
        assert last_response.ok?
    end
    
    it "should return title" do
        get '/'
        assert_match "<title>Chat SYTW</title>", last_response.body
    end
    
    it "should return form" do
        get '/'
        assert_match "<p ><b>Escribe tu username aquí...</b></p>", last_response.body
    end


    it "Debe cargar la foto de fondo" do
	get '/'
	assert_match '<img src="/fondo.jpg" />', last_response.body
    end

    it "should return foot" do
        get '/'
        assert_match " %p.pull-right SYTW 2014. Autores: Rushil Lakhani Lakhani & Adán Rafael López Lecuona.  ", last_response.body
    end
    
    
end