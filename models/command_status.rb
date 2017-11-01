# encoding: utf-8

class CommandStatus < Ohm::Model
  include Ohm::DataTypes
  
  attribute :payload, Type::Hash
  unique :unique_id
  reference :vehicle, :Vehicle
  
  def url
    payload["url"]
  end
  
  def body
    payload["body"]
  end
  
  def command_name
    payload["type"]
  end
  
  def status
    payload["status"]
  end
  
  def is_success?
    status.downcase == "success"
  end
  
  def is_failure?
    status.downcase == "failure"
  end
  
  def is_inProgress?
    status.downcase == "inprogress"
  end
  
  def unique_id
    "#{command_name}@#{vehicle.unique_id}"
  end
  
  def to_hash
    super.merge(:payload => payload)
  end
end



#{"commandResponse"=>{"requestTime"=>"2017-07-25T13:13:58.849Z", "completionTime"=>"2017-07-25T13:14:23.664Z", "url"=>"https://api.gm.com/api/v1/account/vehicles/1GCVKREC2GZ301253/requests/11632891141", "status"=>"success", "type"=>"diagnostics", "body"=>{"diagnosticResponse"=>[{"name"=>"FUEL TANK INFO", "diagnosticElement"=>[{"name"=>"FUEL AMOUNT", "status"=>"NA", "message"=>"na", "value"=>"42.4", "unit"=>"L"}, {"name"=>"FUEL CAPACITY", "status"=>"NA", "message"=>"na", "value"=>"98.38", "unit"=>"L"}, {"name"=>"FUEL LEVEL", "status"=>"NA", "message"=>"na", "value"=>"43.1", "unit"=>"%"}, {"name"=>"FUEL LEVEL IN GAL", "status"=>"NA", "message"=>"na", "value"=>"42.4", "unit"=>"L"}]}, {"name"=>"HOTSPOT CONFIG", "diagnosticElement"=>[{"name"=>"PASSPHRASE", "status"=>"NA", "message"=>"na", "value"=>"triforce"}, {"name"=>"SSID", "status"=>"NA", "message"=>"na", "value"=>"faytruck"}]}, {"name"=>"HOTSPOT STATUS", "diagnosticElement"=>[{"name"=>"HOTSPOT STATUS", "status"=>"NA", "message"=>"na", "value"=>"ENABLED"}]}, {"name"=>"LAST TRIP DISTANCE", "diagnosticElement"=>[{"name"=>"LAST TRIP TOTAL DISTANCE", "status"=>"NA", "message"=>"na", "value"=>"21411.53", "unit"=>"KM"}]}, {"name"=>"LAST TRIP FUEL ECONOMY", "diagnosticElement"=>[{"name"=>"LAST TRIP FUEL ECON", "status"=>"NA", "message"=>"na", "value"=>"6.451612903225806", "unit"=>"kmpl"}]}, {"name"=>"LIFETIME FUEL ECON", "diagnosticElement"=>[{"name"=>"LIFETIME FUEL ECON", "status"=>"NA", "message"=>"na", "value"=>"6.452199459075928", "unit"=>"kmpl"}]}, {"name"=>"LIFETIME FUEL USED", "diagnosticElement"=>[{"name"=>"LIFETIME FUEL USED", "status"=>"NA", "message"=>"na", "value"=>"3291.84", "unit"=>"L"}]}, {"name"=>"ODOMETER", "diagnosticElement"=>[{"name"=>"ODOMETER", "status"=>"NA", "message"=>"na", "value"=>"21411.53", "unit"=>"KM"}]}, {"name"=>"OIL LIFE", "diagnosticElement"=>[{"name"=>"OIL LIFE", "status"=>"NA", "message"=>"YELLOW", "value"=>"10.1", "unit"=>"%"}]}, {"name"=>"TIRE PRESSURE", "diagnosticElement"=>[{"name"=>"TIRE PRESSURE LF", "status"=>"NA", "message"=>"GREEN", "value"=>"264.0", "unit"=>"KPa"}, {"name"=>"TIRE PRESSURE LR", "status"=>"NA", "message"=>"GREEN", "value"=>"260.0", "unit"=>"KPa"}, {"name"=>"TIRE PRESSURE PLACARD FRONT", "status"=>"NA", "message"=>"na", "value"=>"262.0", "unit"=>"KPa"}, {"name"=>"TIRE PRESSURE PLACARD REAR", "status"=>"NA", "message"=>"na", "value"=>"262.0", "unit"=>"KPa"}, {"name"=>"TIRE PRESSURE RF", "status"=>"NA", "message"=>"GREEN", "value"=>"264.0", "unit"=>"KPa"}, {"name"=>"TIRE PRESSURE RR", "status"=>"NA", "message"=>"GREEN", "value"=>"260.0", "unit"=>"KPa"}]}, {"name"=>"VEHICLE RANGE", "diagnosticElement"=>[{"name"=>"GAS RANGE", "status"=>"NA", "message"=>"na", "value"=>"248.82", "unit"=>"KM"}]}]}}}