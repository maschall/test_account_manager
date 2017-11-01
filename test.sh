#!/bin/bash

echo | pbcopy <<EOF
require_relative 'models/init'
require_relative 'client/init'
env = Environment[1]
account = Account[1]
vehicle = account.vehicles.to_a[0]
client = Client.new(env, account)
client.renew
EOF

REDIS_URL=redis://127.0.0.1:6379/1 irb
