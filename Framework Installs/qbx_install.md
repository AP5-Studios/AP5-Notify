### QBox Integration
Replace your QBCore notification function with this code in your `qbx_core/client/functions.lua`:

```lua
function Notify(text, notifyType, duration, subTitle, notifyPosition, notifyStyle, notifyIcon, notifyIconColor)
    local typeMapping = {
        success = 'success',
        error = 'error',
        info = 'info',
        warning = 'warning',
        primary = 'info',
        secondary = 'info',
        police = 'police',
        default = 'info'
    }
    
    local title, description
    
    if type(text) == 'table' then
        title = text.text or 'Notification'
        description = text.caption or nil
    elseif subTitle then
        title = text
        description = subTitle
    else
        title = nil
        description = text
    end

    local mappedType = typeMapping[notifyType] or 'info'
    local notificationData = {
        Type = mappedType,
        Text = description or 'No message provided',
        Duration = duration or 5000,
        ShowProgress = true
    }

    if title then
        notificationData.Title = title
    end

    if notifyIcon then
        local iconMapping = {
            ['check'] = 'fa-solid fa-check',
            ['times'] = 'fa-solid fa-times',
            ['info'] = 'fa-solid fa-info-circle',
            ['warning'] = 'fa-solid fa-exclamation-triangle',
            ['police'] = 'fa-solid fa-handcuffs',
            ['star'] = 'fa-solid fa-star',
            ['heart'] = 'fa-solid fa-heart',
            ['user'] = 'fa-solid fa-user',
            ['car'] = 'fa-solid fa-car',
            ['home'] = 'fa-solid fa-home',
            ['money'] = 'fa-solid fa-dollar-sign',
            ['phone'] = 'fa-solid fa-phone',
            ['message'] = 'fa-solid fa-envelope',
            ['bank'] = 'fa-solid fa-university',
            ['hospital'] = 'fa-solid fa-hospital',
            ['mechanic'] = 'fa-solid fa-wrench',
            ['fuel'] = 'fa-solid fa-gas-pump'
        }
        
        notificationData.Icon = iconMapping[notifyIcon] or notifyIcon
    end

    exports['AP5-Notify']:Notification(notificationData)
end
```