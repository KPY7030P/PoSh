[string]$DateString = (Get-Date -Format r).Replace("GMT",(Get-Date -Format zz00)).ToString([CultureInfo]::GetCultureInfo('en-US'))+"`n"
[string]$Method = "GET`n"
[string]$ContentMD5 = "`n"
[string]$contentType = "`n"   #application/x-www-form-urlencoded
[string]$Hst ="lektorium.megaplan.ru"
[string]$URI = "/BumsTaskApiV01/Task/list.api"

[string]$sign = $Method+$ContentMD5+$contentType+$DateString+$Hst,$URI | Write-Host -ForegroundColor cyan

[string]$message = $Method+$ContentMD5+$contentType+$DateString+$Hst,$URI
[string]$secret = '605b6574d71cdef9e5ca7c9487bbd5d2ca46bcce'

$hmacsha = New-Object System.Security.Cryptography.HMACSHA1
$hmacsha.key = [Text.Encoding]::ASCII.GetBytes($secret)
$signature = $hmacsha.ComputeHash([Text.Encoding]::ASCII.GetBytes($message))
$signature = [Convert]::ToBase64String($signature)

$OLOLO = "lalala"
$lala = ""