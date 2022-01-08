# SubZero Interactive: Logs

## Installation

- Add your Discord Webhooks to `Config.Webhooks`
- if Using ESX, set  `Config.UseESX` to true
- Personalise `Config.ServerName` and `Config.ServerLogo`
- Add to your server.cfg:
  > ensure szi-logs

## How To Use

- ServerSide Export
  > exports["szi-logs"]:SendLog(name, title, color, message, tagEveryone) 

- Example Command
  > /embed "default" "default"

- Example Export
  > SendLog("default", 'Test Webhook', "red", 'Webhook setup successfully',false)