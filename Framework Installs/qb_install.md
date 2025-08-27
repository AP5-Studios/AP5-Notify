### QBCore Integration
Replace your QBCore notification function with this code in your `qb-core/client/functions.lua`:

```lua
function QBCore.Functions.Notify(text, texttype, length, icon)
    local typeMapping = {
        primary = 'info',
        success = 'success',
        error = 'error',
        warning = 'warning',
        police = 'police',
        info = 'info'
    }
    
    local message = {
        Type = typeMapping[texttype] or 'info',
        Duration = length or 5000,
        ShowProgress = true
    }

    if type(text) == 'table' then
        message.Text = text.text or 'Placeholder'
        message.Title = text.caption
    else
        message.Text = text
    end

    if icon then message.Icon = icon end

    exports['AP5-Notify']:ShowNotification(message)
end
```