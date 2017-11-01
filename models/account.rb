# encoding: utf-8

class Account < Ohm::Model
  attribute :username
  attribute :password
  attribute :pin

  reference :environment, :Environment
  reference :auth_token, :AuthToken
  collection :vehicles, :Vehicle
  
  unique :unique_id
  
  def to_hash
    super.merge(:username => username,
                :password => password,
                :pin => pin,
                :vehicles => vehicles.to_json )
  end
  
  def unique_id
    "#{username}@#{environment.unique_id}"
  end
  
end