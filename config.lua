Config = {}

Config.EnableProgress = true -- If true, Notifications show a progress bar by default.
Config.EnableSounds = true -- If true, All notification sounds will be enabled.

Config.Sounds = {
    default = {
        url = 'notification.wav',
        volume = 0.4 -- Volume level (0.0 to 1.0)
    },
    success = {
        url = 'notification.wav',
        volume = 0.4
    },
    error = {
        url = 'notification.wav',
        volume = 0.4
    },
    info = {
        url = 'notification.wav',
        volume = 0.4
    },
    warning = {
        url = 'notification.wav',
        volume = 0.4
    },
    police = {
        url = 'notification.wav',
        volume = 0.4
    }
}

Config.Notifications = {
    success = {
        icon = 'fa-solid fa-circle-check',
        color = '28a745',
    },
    error = {
        icon = 'fa-solid fa-circle-xmark',
        color = 'dc3545',
    },
    info = {
        icon = 'fa-solid fa-circle-info',
        color = '17a2b8',
    },
    warning = {
        icon = 'fa-solid fa-triangle-exclamation',
        color = 'ffc107',
    },
    police = {
        icon = 'fa-solid fa-handcuffs',
        color = 'FF001AFF',
    },
    -- Add more custom types as needed
    -- custom = {
    --     icon = 'fa-solid fa-star',
    --     color = 'purple',
    -- }
}