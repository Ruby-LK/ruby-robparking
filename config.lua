Config = {}

Config.Target = 'ox' -- ox or qb
Config.Inventory = 'ox' -- ox or qb
Config.MoneyType = 'markedbills' -- 'cash' = cash reward / 'markedmoney' = for qb marked-bills / 'markedbills' for ox
Config.MinReward = 5 -- Minimum reward amount
Config.MaxReward = 20 -- Maximum reward amount
Config.Cooldown = 5000 -- Cooldown time in milliseconds

Config.dispatch = false -- true = Enables the dispatch alerts / false = Disables the alerts.
Config.disptachforall = false -- true = Enables the alerts for all meter robberies / false = Not sending alerts for all meter robberies
Config.PoliceCallChance = 15 -- Chance of sending alerts to pd when someone robs meters. | Enabling Config.disptachforall will overide this.
