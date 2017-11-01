# encoding: utf-8

require 'ohm'
require 'ohm/contrib'

Ohm.redis = Redic.new(ENV['REDIS_URL'])

require_relative 'environment'
require_relative 'account'
require_relative 'vehicle'
require_relative 'auth_token'