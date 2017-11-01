# encoding: utf-8

require "faraday"
require "faraday_middleware"
require "uri"
require 'time'

class Client < Faraday::Connection
  
  attr_accessor :environment, :account
  
  def initialize(environment, account = nil)
    @environment = environment
    @account = account
    super(environment.url) { |b|
      b.use FaradayMiddleware::FollowRedirects
      b.response :logger
      b.adapter :net_http
    }
  end
  
  def authed_get(path, parameters = {}, account = @account)
    authed_request(method(:get), account, path, parameters)
  end
  
  def authed_post(path, body = {}, account = @account)
    authed_request(method(:post), account, path, nil, body)
  end
  
  private
  
  def authed_request(method, account, path, parameters = nil, body = nil)
    response = method.call do |req|
      req.url path
      req.headers.update(authed_headers(account))
      req.params = parameters if parameters
      req.body = JSON(body) if body
    end
    
    JSON(response.body)
  end
  
  def common_headers
    {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json',
      'Accept-Language' => 'en'
    }
  end
  
  def authed_headers(account)
    authorization = {
      'Authorization' => "Bearer #{account.auth_token.access_token}"
    }
    common_headers.merge(authorization)
  end
  
  def device_id
    "514C78CB-6E94-4B99-9C48-03AC1E75EE85"
  end
  
  def uuid
    SecureRandom.uuid()
  end
  
  def timestamp
    Time.now.iso8601(3)
  end
  
end