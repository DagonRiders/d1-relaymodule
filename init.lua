dofile("config.lua")
dofile("wificonnect.lua")
dofile("relaymodule.lua")

print("Turning all switches off")
for i=0,7,1 do
  gpio.mode(i+1, gpio.OUTPUT)
  gpio.write(i+1, gpio.HIGH)
end

wificonnect()
