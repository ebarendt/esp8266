#!/usr/bin/env ruby

require 'socket'
require 'json'

# ip = IPSocket.getaddress(Socket.gethostname)

server = UDPSocket.new
server.bind('0.0.0.0', 8267)

client = UDPSocket.new
client.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
client.send('DISCOVERY', 0, '192.168.1.255', 8266)
client.close

data = nil
until data
  data, (family, port, hostname, addr) = server.recvfrom(1024)
  json = JSON.parse(data)
  puts "From addr: '%s', msg: '%s'" % [addr, json.inspect]
end

server.close
