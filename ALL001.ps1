Remove-Variable -Name * -Force -ErrorAction SilentlyContinue
<# 

URL любого API-запроса составляется следующим образом:
https://<имя_вашего_домена>.megaplan.ru/<URI_команды>

запрос авторизации методом GET составляется следующим образом:
https://domain.megaplan.ru/BumsCommonApiV01/User/authorize.xml?Login=name&Password=md5pass
где:
    domain.megaplan.ru/
    BumsCommonApiV01/User/authorize.xml
    Login=name (пара ключ=значение для логина)
    Password=md5pass (пара ключ=значение для md5 пароля)

Ответ выглядит следующим образом:
    {
      "status":
      {
        "code":"ok",
        "message":null
      },
      "params":
      {
        "Login":"someuser",
        "Password":"202cb962ac59075b964b07152d234b70"},
      "data":
      {
        "AccessId":"5f615c654865eAddF0c2",
        "SecretKey":"2Dd0E3ff3d4a7e3695d3CeD3ec9Ff8D39D67365c",
        "UserId":12324,
        "EmployeeId":1000001
      }
    }

Для всех запросов к API кроме авторизации требуется передавать набор HTTP-заголовков:
    Date:<дата запроса в формате RFC-2822>
    Accept:application/json
    X-Authorization:<AccessId>:<Signature>
X-Authorization - заголовок аутентификации.Cостоит из значения AccessId и сигнатуры.

++++Алгоритм формирования сигнатуры++++
1. Подготовить строку с символами переноса строки после каждого пункта даже если он пустой
    Method - метод запроса, например POST или GET
    Content-MD5 - MD5 тела запроса (В данный момент параметр не актуален)
    Content-Type - тип данных запроса, например application/x-www-form-urlencoded
    Date - дата запроса в формате RFC-2822, например Wed, 25 May 2011 16:50:58 +0400 (должна с точностью до секунды совпадать с Date или X-Sdf-Date в заголовке)
    Host - хост вашего аккаунта, например accountname.megaplan.ru
    URI - адрес запроса, например /BumsTaskApiV01/Task/list.api для получения списка задач

    пример:
        GET`n`napplication/x-www-form-urlencoded`nWed, 25 May 2011 16:50:58 +0400`naccountname.megaplan.ru/BumsTaskApiV01/Task/list.api

2. Закодировать полученную в п.1 строку с использованием алгоритма HMAC-SHA1 с ключом SecretKey, полученным ранее при авторизации пользователя.

3. Закодировать полученное в п.2 значение алгоритмом MIME base64
#>

<#

#Создание MD5 для пароля
Function Get-MD5([String] $String,$HashName = "MD5") 
{ 
$StringBuilder = New-Object System.Text.StringBuilder 
[System.Security.Cryptography.HashAlgorithm]::Create($HashName).ComputeHash([System.Text.Encoding]::Default.GetBytes($String))|%{ 
[Void]$StringBuilder.Append($_.ToString("x1")) 
} 
$StringBuilder.ToString() 
}

# входные данные Логин Пароль
[string]$passSTR = "247247"
[string]$loginSTR = "jiscar"

# авторизация
[string]$domen = "https://lektorium.megaplan.ru/BumsCommonApiV01/User/authorize.api"
[string]$login = "jiscar"
[string]$pass = Get-MD5 $passSTR                  #"64fd9cc337872db23bce772ca95e2d40"
$wc = New-Object system.Net.WebClient
$wc.QueryString.Add("Login", $loginSTR)
$wc.QueryString.Add("Password", $pass)

$ResultAuth = $wc.downloadString($domen)
$Authjsn = ConvertFrom-Json $ResultAuth

#вывод результатов авторизации
$AccessId = $Authjsn.data.AccessId + ":"
$SecretKey = $Authjsn.data.SecretKey
$UserId = $Authjsn.data.UserId
$ContractorId = $Authjsn.data.ContractorId

#>


$AccessId = "2aC28cfe795d31cddabf:"
$SecretKey = "605b6574d71cdef9e5ca7c9487bbd5d2ca46bcce"

# переменная времени

[string]$DateString2 = (Get-Date -Format r).Replace("GMT",(Get-Date -Format zz00)).ToString([CultureInfo]::GetCultureInfo('en-US'))
# сборка строки сигнатуры по запчастям
[string]$Method = "GET`n"
[string]$ContentMD5 = "`n"
[string]$contentType = "`n"  #"application/json`n"   #application/x-www-form-urlencoded
[string]$DateString = (Get-Date -Format r).Replace("GMT",(Get-Date -Format zz00)).ToString([CultureInfo]::GetCultureInfo('en-US'))+"`n"
[string]$Hst ="lektorium.megaplan.ru"
[string]$URI = "/BumsTaskApiV01/Task/list.api"


[string]$filtr1 = "Folder"
[string]$filtrVal1 = "incoming"
[string]$filtr2 = "Status"
[string]$filtrVal2 = "actual"
[string]$filtrString = "?" + $filtr1 + "=" + $filtrVal1 + "&" + $filtr2 + "=" + $filtrVal2
#[string]$filtrValue = "failed"
Write-Host -ForegroundColor cyan  $filtrString 


[string]$signString = $Method+$ContentMD5+$contentType+$DateString+$Hst+$URI+$filtrString
Write-Host -ForegroundColor Magenta $signString

# кодирование строки сигнатуры в HMACSHA1 и затем в Base64
$HMAC = New-Object System.Security.Cryptography.HMACSHA1
$HMAC.key = [Text.Encoding]::UTF8.GetBytes($SecretKey)
$HMAC.ComputeHash([Text.Encoding]::UTF8.GetBytes($signString)) | Out-Null
Foreach ($item in $HMAC.hash){$b+=[System.String]::Format("{0:x2}", [System.Convert]::ToUInt64($item))}
$b=[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($b)).ToString() 
Write-Host -ForegroundColor yellow $b



# сборка заголовков аутентификацыц
[string]$signature = $AccessId+$b

# создание вебклиента
$wc2 = New-Object system.Net.WebClient
#добавление заголовков
$wc2.Headers.Add("X-Sdf-Date", $DateString2)
$wc2.Headers.Add("X-Authorization", $signature)
$wc2.Headers.Add("Accept", "application/json")

#$wc2.Headers.Add("Folder","incoming")
#$wc2.Headers.Add("Status","failed")
$wc2.QueryString.add($filtr1 ,$filtrVal1)
$wc2.QueryString.add($filtr2 ,$filtrVal2)
#$wc2.QueryString.Add("SecretKey", $SecretKey)
#$wc2.QueryString.Add("Sign", $signString)


[string]$site = "https://"+$Hst+$URI 
$Result = $wc2.downloadString($site)
Write-Host -ForegroundColor Green $Result
#try {$wc.downloadString($site)} catch {$_.Exception.InnerException}
#$jsn = ConvertFrom-Json $Result 
#Write-Host $Result

