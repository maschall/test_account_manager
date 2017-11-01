# encoding: utf-8

class Vehicle < Ohm::Model
  include Ohm::DataTypes
  
  attribute :data, Type::Hash
  unique :unique_id
  reference :account, :Account

  def vin
    data["vin"]
  end
  
  def nickname
    data["nickname"]
  end
  
  def entitlements
    data["entitlements"]["entitlement"]
  end
  
  def entitlement(id)
    entitlements.find { |e| e["id"].downcase == id.downcase }
  end
  
  def is_eligible_for(id)
    entitlement = entitlement(id)
    return false unless entitlement
    eligible = entitlement["eligible"] == "true"
    if (service.downcase == "prognostic_alert" )
      eligible = eligible && entitlement["notificationCapable"] == "true"
    end
    eligible
  end
  
  def commands
    data["commands"]["command"]
  end
  
  def command(name)
    commands.find { |c| c["name"].downcase == name.downcase }
  end
  
  def unique_id
    "#{vin}@#{account.unique_id}"
  end
  
end