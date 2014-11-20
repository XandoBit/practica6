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

urlchat = ''

describe 'make API call to load path', :type => :feature do 
  it "should load the home page" do
    visit "#{urlchat}"
    expect(page).to have_content("Regístrate")
  end
end

describe 'make API call to load chat and to found elements' do
  it "should load the chat page" do
    visit "#{urlchat}/chat"
    expect(page).to have_content("welcome")
  end
end

describe 'make API sign in whith a specific name' do
  it 'user login' do
    visit "#{urlchat}"
    fill_in 'usuario', :with => 'Rushil'
    click_on('Regístrate')
    visit "#{urlchat}/chat"
    expect(page).to have_content("Rushil")     
  end
end

