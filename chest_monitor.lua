local chest = peripheral.find("minecraft:chest")
local monitor = peripheral.find("monitor")
monitor.setTextScale(1)

if not chest then
    print("No chest found.")
    return
end

local function updateItemName(str)
    -- if not str then return "An error occured" end --> debugging
    return str:gsub("^minecraft:", ""):gsub("^%l", string.upper):gsub("_", " ")
end

local function updateDisplay()
    monitor.clear()

    local monitorWidth = monitor.getSize()

    local function centeralizeText(text)
        local textWidth = #text
        local xPos = math.floor((monitorWidth - textWidth) / 2)
        return xPos
    end

    local line = 1

    monitor.setTextColor(colors.yellow)
    monitor.setCursorPos(centeralizeText("Chest Monitor \n"), line)
    monitor.setTextColor(colors.white)
    line = line + 1

    for slot = 1, chest.size() do
        local item = chest.getItemDetail(slot)
        if item then
            local itemName = updateItemName(item.name)

            local itemInfo = itemName .. ": "
            monitor.setCursorPos(centeralizeText(itemInfo), line)
            monitor.write(itemInfo)

            -- monitor.setCursorPos(1, line + 1)
            monitor.setTextColor(colors.lightGray)
            monitor.write(item.count .. "x")
            monitor.setTextColor(colors.white)

            line = line + 1
        else
            return
        end
    end
end

while true do
    updateDisplay()
    print("Type and enter any key or string to quit.")
    local input = read()

    if input then
        print("Stopping the live monitor.")
        break
    end
    sleep(10)
end
