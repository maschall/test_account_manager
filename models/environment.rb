# encoding: utf-8

class Environment < Ohm::Model
  attribute :name
  attribute :client_id
  attribute :client_secret
  attribute :url
  
  collection :accounts, :Account

  index :name
  
  unique :unique_id
  
  def unique_id
    "#{client_id}@#{url}"
  end
end