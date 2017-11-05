Remove-Variable -Name * -Force -ErrorAction SilentlyContinue


$domen = "https://lektorium.megaplan.ru/BumsCommonApiV01/User/authorize.api"
#$login = "jiscar"
#$pass = "64fd9cc337872db23bce772ca95e2d40"
#$queryStringd = [string]::Concat($domen,"?","Login=",$login,"&","Password=",$pass) | Write-Host -foregroundcolor green
#$queryString = ("Login=jiscar")

$bad = @"
{
"Login":"jiscar",
"Password":"64fd9cc337872db23bce772ca95e2d40"}
"@ 


$boda = @{
Login="jiscar";
Password="64fd9cc337872db23bce772ca95e2d40"
}

#Invoke-WebRequest -uri $domen -ContentType "application/x-www-form-urlencoded" -method POST  -Body $queryString

$a = Invoke-WebRequest -uri "https://lektorium.megaplan.ru/BumsCommonApiV01/User/authorize.api"

Write-Host $a

#([System.Text.Encoding]::UTF8.GetBytes($boda))


