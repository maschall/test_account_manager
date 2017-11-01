# encoding: utf-8

class App < Sinatra::Application
  get "/" do
    @title = "Test Account Manager"        
    haml :main
  end
end