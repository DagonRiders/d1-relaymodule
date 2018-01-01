redis = require('redis')
sjson = require('sjson')
bit = require('bit')

function processData(data)
	print("Processing switch state " .. data)
	data = tonumber(data)
  for i=0,7,1 do
  	if bit.isset(data, i) then
    	print("Switch " .. i .. " is on")
    	gpio.write(i+1, gpio.LOW)
    else
    	print("Switch " .. i .. " is off")
    	gpio.write(i+1, gpio.HIGH)
    end
  end
end

function onUpdate(channel, msg)
	print("Received a PUBLISH message.")
	print(msg)
	processData(msg)
end

function start()
	print("Started")

	connection = redis.connect(REDIS_SERVER)
	connection:subscribe("state." .. PACK_ID, onUpdate)

	http.get(WEBDIS_SERVER.."/get/state." .. PACK_ID, nil, function(code, data)
    if (code < 0) then
      print("GET request failed")
    else
    	print("Received GET response:")
      print(code, data)
      a = sjson.decode(data)
      processData(a["get"])
    end
  end)
end