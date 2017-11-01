# encoding: utf-8

class Client
  
  def vehicle_connect(vehicle)
    connect = vehicle.command("connect")
    execute_command(connect)
  end
  
  def vehicle_diagnostics(vehicle)
    diagnostics = vehicle.command("diagnostics")
    parameters = {
      :diagnosticsRequest => {
        :diagnosticItem => diagnostics["commandData"]["supportedDiagnostics"]["supportedDiagnostic"]
      }
    }
    execute_command(diagnostics, parameters)
  end
  
  private
  
  def execute_command(command, parameters = {})
    status = start_command(command, parameters)
    progress = status["commandResponse"]["status"].downcase
    while progress == "inprogress"
      sleep 5
      status = get_status(status)
      progress = status["commandResponse"]["status"].downcase
    end
    status
  end
  
  def start_command(command, parameters = {})
    authed_post command["url"], parameters
  end
  
  def get_status(status)
    authed_get status["commandResponse"]["url"]
  end
  
end