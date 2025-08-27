local function formatColor(color)
    if type(color) == 'string' then
        local firstChar = color:sub(1, 1)
        local colorLength = string.len(color)

        if firstChar ~= '#' and colorLength == 6 and string.match(color, "^[0-9a-fA-F]+$") then
            return '#' .. color
        end

        if firstChar ~= '#' and colorLength == 8 and string.match(color, "^[0-9a-fA-F]+$") then
            local a = tonumber(color:sub(1, 2), 16) / 255.0
            local r = tonumber(color:sub(3, 4), 16)
            local g = tonumber(color:sub(5, 6), 16)
            local b = tonumber(color:sub(7, 8), 16)
            return string.format("rgba(%d, %d, %d, %.2f)", r, g, b, a)
        end
    end
    return color
end

local function processNotificationTypes(types)
    local processedTypes = {}
    for typeName, typeData in pairs(types) do
        processedTypes[typeName] = {}
        for key, value in pairs(typeData) do
            if key == 'color' then
                processedTypes[typeName][key] = formatColor(value)
            else
                processedTypes[typeName][key] = value
            end
        end
    end
    return processedTypes
end

local function playNotificationSound(notificationType)
    if not Config.EnableSounds then return end

    local soundConfig = Config.Sounds[notificationType] or Config.Sounds.default

    if soundConfig then
            SendNUIMessage({
                action = 'playSound',
                url = soundConfig.url,
                volume = soundConfig.volume or 0.4
            })
    end
end

Citizen.CreateThread(function()
    Wait(1000)
    local processedNotifications = processNotificationTypes(Config.Notifications)
    SendNUIMessage({
        action = 'setNotificationConfig',
        notifications = processedNotifications,
        showProgressGlobal = Config.EnableProgress
    })
end)

function Notification(data)
    local notificationData = data or {}

    notificationData.Type = notificationData.Type or 'info'
    notificationData.Title = notificationData.Title
    notificationData.Text = notificationData.Text
    notificationData.Duration = tonumber(notificationData.Duration) or 5000
    notificationData.Icon = notificationData.Icon
    notificationData.ShowProgress = notificationData.ShowProgress ~= nil and notificationData.ShowProgress or Config.EnableProgress
    notificationData.PlaySound = notificationData.PlaySound ~= nil and notificationData.PlaySound or Config.EnableSounds

    if not Config.Notifications[notificationData.Type] then
        notificationData.Type = 'info'
    end

    if notificationData.PlaySound then
        playNotificationSound(notificationData.Type)
    end

    SendNUIMessage({
        action = 'showNotification',
        type = notificationData.Type,
        text = notificationData.Text,
        title = notificationData.Title,
        duration = notificationData.Duration,
        icon = notificationData.Icon,
        showProgress = notificationData.ShowProgress
    })
end

exports('Notification', Notification)

RegisterNetEvent(('AP5-Notify:Notification'), function(data)
    Notification(data)
end)