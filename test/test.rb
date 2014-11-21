require 'capybara' # loading capybara
require 'capybara/dsl'
require 'rack/test'
require 'coveralls'

Coveralls.wear!

Capybara.default_driver = :selenium 

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = :random
end

urlchat = 'https://chat-p7.herokuapp.com'

describe 'make API call to load path', :type => :feature do 
  it "should load the home page" do
    visit "#{urlchat}"
    expect(page).to have_content("Registrar")
  end
end

describe 'make API call to load chat and to found elements' do
  it "should load the chat page" do
    visit "#{urlchat}/chat"
    expect(page).to have_content("Usuarios conectados")
  end
end

describe 'make API sign in whith a specific name' do
  it 'user login' do
    visit "#{urlchat}"
    fill_in 'name', :with => 'Rushil'
    click_on('Click para ir al chat.')
    visit "#{urlchat}/chat"
    expect(page).to have_content("Rushil")     
  end

  describe 'chat page' do
   it 'have a chat with the chat' do
      visit "#{urlchat}/chat"
      fill_in 'text', :with => 'Ey'
      #click_on('')
      #expect(page).to have_content('')
   end
end