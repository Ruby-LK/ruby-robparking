Config = {}

Config.MoneyType = 'cash' -- 'cash' = cash reward / 'markedmoney' = for marked-bills
Config.MinReward = 100 -- Minimum reward amount
Config.MaxReward = 400 -- Maximum reward amount
Config.Cooldown = 5000 -- Cooldown time in milliseconds

Config.dispatch = true -- true = Enables the dispatch alerts / false = Disables the alerts.
Config.disptachforall = false -- true = Enables the alerts for all meter robberies / false = Not sending alerts for all meter robberies
Config.PoliceCallChance = 15 -- Chance of sending alerts to pd when someone robs meters. | Enabling Config.disptachforall will overide this.