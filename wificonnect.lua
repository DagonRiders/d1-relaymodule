firstConnect = true

function wificonnect()
    wifi.setmode(wifi.STATION)
    wifi.sta.config(station_cfg)
    tmr.alarm(1, 1000, 1, function()
        if wifi.sta.status() == wifi.STA_GOTIP then
          if firstConnect then
            firstConnect = false;
            print("Connected, IP is "..wifi.sta.getip())
            start()
          end
        else
          if wifi.sta.status() == wifi.STA_CONNECTING then
            print("Connecting...")
          else
            print("Error:")
            print(wifi.sta.status())
            firstConnect = true;
          end
        end
    end)
    print("Loaded")
end
