# encoding: utf-8

class App < Sinatra::Application
  get "/random" do
    account = Account.create :username => "test@test.com", :password => "test1234"
    json account.to_hash
  end
  
  get "/accounts" do
    json Account.all
  end
end