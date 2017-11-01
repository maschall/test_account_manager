# encoding: utf-8

class Client
  
  def get_vehicles(account = @account)
    parameters = {
      :includeEntitlements => true,
      :includeCommands => true,
      :includeModules => true,
      :includeOptInStatus => true
    }
    
    vehicles = authed_get("account/vehicles", parameters, account)
    vehicles = vehicles["vehicles"]["vehicle"]
    
    vehicles.each do |vehicleData|
      vin = vehicleData["vin"]
      persistedVehicle = Vehicle.with(:vin, vin)
      
      if persistedVehicle
        persistedVehicle.data.merge(vehicleData)
        persistedVehicle.save
      else
        persistedVehicle = Vehicle.create :data => vehicleData, :account => account
      end
    end
  end
  
end