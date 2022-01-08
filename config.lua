Config = {}
Config.ServerName = "Server Name"
Config.ServerLogo = "https://LinkToServerLogo.com"
Config.UseESX = false
Config.Webhooks = {
  default = 'ADD WEBHOOK HERE',
  testwebhook = '',
  Chat = '',
  UserActions = '',
  Resources = '',
}

Config.Colors = { -- https://www.spycolor.com/
  default = 14423100,
  blue = 255,
  red = 16711680,
  green = 65280,
  white = 16777215,
  black = 0,
  orange = 16744192,
  yellow = 16776960,
  pink = 16761035,
  lightgreen = 65309,
}

Config.DefaultEvents = { -- Default Log Events
    chat = true,
    playerDropped = true,
    playerJoining = true,
    Resources = true
}