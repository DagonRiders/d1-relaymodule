function wificonnect()
    wifi.setmode(wifi.STATION)
    wifi.sta.config(station_cfg)
    tmr.alarm(1, 1000, 1, function()
        if wifi.sta.status() == wifi.STA_GOTIP then
          tmr.stop(1)
          print("Connected, IP is "..wifi.sta.getip())
          start()
        else
          if wifi.sta.status() == wifi.STA_CONNECTING then
            print("Connecting...")
          else
            tmr.stop(1)
            print("Error:")
            print(wifi.sta.status())
          end
        end
    end)
    print("Loaded")
end
