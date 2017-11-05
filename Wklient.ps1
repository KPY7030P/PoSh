Remove-Variable -Name * -Force -ErrorAction SilentlyContinue

$domen = "https://lektorium.megaplan.ru/BumsCommonApiV01/User/authorize.api"
$login = "jiscar"
$pass = "64fd9cc337872db23bce772ca95e2d40"
$wc = New-Object system.Net.WebClient
$wc.QueryString.Add("Login", $login)
$wc.QueryString.Add("Password", $pass)

$Result = $wc.downloadString($domen)
$jsn = ConvertFrom-Json $Result 
Write-Host $Result


