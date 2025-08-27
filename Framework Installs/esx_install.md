### ESX Integration
Replace your ESX notification functions with this code in your `es_extended/client/main.lua`:

```lua
function ESX.ShowNotification(message, type, length)
    local typeMapping = {
        success = 'success',
        error = 'error',
        info = 'info',
        warning = 'warning',
        inform = 'info',
        alert = 'warning'
    }
    
    exports['AP5-Notify']:Notification({
        Type = typeMapping[type] or 'info',
        Text = tostring(message),
        Duration = length or 5000,
        ShowProgress = true
    })
end

function ESX.ShowAdvancedNotification(title, subject, msg, icon, iconType, length)
    local typeMapping = {
        success = 'success',
        error = 'error',
        info = 'info',
        warning = 'warning',
        inform = 'info',
        CHAR_DEFAULT = 'info',
        CHAR_POLICE = 'police'
    }
    
    exports['AP5-Notify']:Notification({
        Type = typeMapping[type] or 'info',
        Text = tostring(message),
        Duration = length or 5000,
        ShowProgress = true
    })
end
```

Older or other ESX versions
```lua
ESX.Notification = ESX.ShowNotification
ESX.NotificationError = function(message, length)
    ESX.ShowNotification(message, 'error', length)
end
ESX.NotificationSuccess = function(message, length)
    ESX.ShowNotification(message, 'success', length)
end
ESX.NotificationInfo = function(message, length)
    ESX.ShowNotification(message, 'info', length)
end
ESX.NotificationWarning = function(message, length)
    ESX.ShowNotification(message, 'warning', length)
end

RegisterNetEvent('esx:showNotification', function(message, type, length)
    ESX.ShowNotification(message, type, length)
end)

RegisterNetEvent('esx:showAdvancedNotification', function(title, subject, msg, icon, iconType, length)
    ESX.ShowAdvancedNotification(title, subject, msg, icon, iconType, length)
end)
```