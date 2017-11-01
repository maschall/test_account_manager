# encoding: utf-8
require 'sinatra'
require 'sinatra/json'
require 'haml'

class App < Sinatra::Application
  enable :sessions

  configure :production do
    set :haml, { :ugly=>true }
    set :clean_trace, true
  end

  configure :development do
    # ...
  end

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end
end

require_relative 'models/init'
require_relative 'client/init'
require_relative 'api/init'
require_relative 'web/init'