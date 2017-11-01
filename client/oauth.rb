# encoding: utf-8

require 'securerandom'
require 'jwt'

class Client
  
  def login(account)
    @account = account
    body = login_dictionary(@account)
    
    payload = jwt_post('oauth/token', body)
    @account.auth_token = AuthToken.create :payload => payload
    @account.save
  end
  
  def renew(account = nil)
    @account = account if account
    body = renew_dictionary(@account)
    
    payload = jwt_post('oauth/token', body)
    
    @account.auth_token.merge(payload)
    @account.save
  end
  
  def upgrade_auth(account = nil)
    @account = account if account
    body = upgrade_dictionary(@account)
    
    payload = jwt_post('oauth/token', body)
    
    @account.auth_token.merge(payload)
    @account.save
  end
  
  private
  
  def jwt_headers
    content_type = {
      'Content-Type' => 'text/plain'
    }
    common_headers.merge(content_type)
  end
  
  def jwt_post(path, body)
    response = post do |req|
      req.url path
      req.headers.update(jwt_headers)
      req.body = jwt_body(body)
    end
    
    payload, header = JWT.decode response.body, nil, false
    payload
  end
  
  private
  
  def jwt_body(payload)
    JWT.encode payload, @environment.client_secret, 'HS256'
  end
  
  def oauth_dictionary(dictionary)
    {
      :device_id => device_id,
      :timestamp => timestamp,
      :client_id => @environment.client_id,
      :nonce => uuid,
      :scope => "priv msso onstar gmoc commerce",
    }.merge(dictionary)
  end
  
  def login_dictionary(account)
    oauth_dictionary({
      :password => account.password,
      :username => account.username,
      :grant_type => "password",
    })
  end
  
  def upgrade_dictionary(account)
    oauth_dictionary({
      :scope => "priv",
      :grant_type => "urn:onstar:params:oauth:grant-type:jwt-bearer-pin",
      :assertion => account.auth_token.id_token,
      :pin => account.pin
    })
  end
  
  def renew_dictionary(account)
    oauth_dictionary({
      :assertion => account.auth_token.id_token,
      :grant_type => "urn:ietf:params:oauth:grant-type:jwt-bearer",
    })
  end
  
end