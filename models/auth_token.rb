# encoding: utf-8

class AuthToken < Ohm::Model
  include Ohm::DataTypes
  
  attribute :payload, Type::Hash
  
  def access_token
    payload["access_token"]
  end
  
  def id_token
    payload["id_token"]
  end
  
  def merge(other)
    self.payload["scope"] += " #{other['scope']}"
    self.payload = self.payload.merge(other)
    save
  end
  
  def to_hash
    super.merge(:payload => payload)
  end
end