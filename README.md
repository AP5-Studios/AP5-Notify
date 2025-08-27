# AP5-Notify

## Features
- **Modern Sleek Design** - Beautiful, translucent notifications with blur effects
- **Multiple Notification Types** - Success, Error, Info, Warning, Police, and custom types
- **Animated Progress Bars** - Visual countdown with smooth animations
- **ESX & QBCore & Qbox Compatible** - Drop-in replacement for existing notification systems
- **Open Source** - Full source code available for customization

## Installation
1. Download from Keymaster/Portal
2. Ensure the folder is named `AP5-Notify`
3. Put the folder in your `resources` folder
4. Add `ensure AP5-Notify` to your `server.cfg`
5. Restart your server


## Client-Side Usage

Basic notification
```lua
exports['AP5-Notify']:Notification({
    Type = 'success',
    Title = 'Success!',
    Text = 'Your action was completed successfully.',
    Duration = 5000,
    ShowProgress = true
})
```
Simple notification without title
```lua
exports['AP5-Notify']:Notification({
    Type = 'error',
    Text = 'Something went wrong!',
    Duration = 3000
})
```
Custom icon and no sound
```lua
exports['AP5-Notify']:Notification({
    Type = 'info',
    Title = 'Custom Icon',
    Text = 'This notification has a custom icon.',
    Icon = 'fa-solid fa-star',
    PlaySound = false
})
```

### Server-Side Trigger
```lua
TriggerClientEvent('AP5-Notify:Notification', source, { Type = 'police', Title = 'Police Alert', Text = 'You have been flagged by the system.', Duration = 3000})
```

## Support
- **Discord**: [Join our Discord](https://discord.gg/MKMWDRNrzm)