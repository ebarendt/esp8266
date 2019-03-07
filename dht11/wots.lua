--    Test communication of DHT sensor
--    Tested with Lua NodeMCU 0.9.5 build 20150127 floating point !!!
-- 1. Flash Lua NodeMCU to ESP module.
-- 2. Set in program wots.lua humidity sensor type. This is parameter typeSensor="dht11" or "dht22".
-- 3. Load program wots.lua and testdht.lua to ESP8266 with LuaLoader
-- 4. HW reset module
-- 5. Run program wots.lua - dofile(wots.lua)
 
 
sensorType="dht11"          -- set sensor type dht11 or dht22
 
    PIN = 3 --  data pin, GPIO0
    humi=0
    temp=0
    --load DHT module for read sensor
function ReadDHT()
    dht=require("dht11")
    dht.read(PIN)
    chck=1
    h=dht.getHumidity()
    t=dht.getTemperature()
    print(h)
    print(t)
    if h==nil then h=0 chck=0 end
    if sensorType=="dht11"then
        humi=h/256
        temp=t/256
    else
        humi=h/10
        temp=t/10
    end
    fare=(temp*9/5+32)
    print("Humidity:    "..humi.."%")
    print("Temperature: "..temp.." deg C")
    print("Temperature: "..fare.." deg F")
    -- release module
    dht=nil
    package.loaded["dht11"]=nil
end
ReadDHT()