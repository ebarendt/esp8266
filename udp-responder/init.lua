wifi.setmode(wifi.STATION)
wifi.sta.config("et406","")

tmr.alarm(0, 5000, 0, function()
    print(wifi.sta.getip())
    print(wifi.sta.getbroadcast())
end)

-- a udp server
s=net.createServer(net.UDP)
s:on("receive", function(s,c)
    if c == "DISCOVERY" then
        ip = wifi.ap.getip()
        ip, netmask, gateway = wifi.sta.getip()
        id = node.flashid()
        r = net.createConnection(net.UDP, 0)
        r:connect(8267, "255.255.255.255")
        r:send("{\"id\":\""..id.."\",\"ip\":\""..ip.."\"}")
    else
        print(c)
    end
end)
s:listen(8266)
