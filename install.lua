local chestMonitorURL = "https://raw.githubusercontent.com/bafiantje/chest-monitor-CC/main/chest_monitor.lua"

local function downloadFile(url, filename)
    local response = http.get(url)
    if response then
        local file = fs.open(filename, "w")
        file.write(response.readAll())
        file.close()
        response.close()
        print("File downloaded as '" .. filename .. "'.")
    else
        print("Cannot find the file: " .. url)
    end
end

downloadFile(chestMonitorURL, "chest_monitor.lua")

local startupScript = [[
shell.run("chest_monitor.lua")
]]
local file = fs.open("startup.lua", "w")
file.write(startupScript)
file.close()

print("Installation succesful, run `reboot` to start the program.")