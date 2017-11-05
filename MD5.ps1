Remove-Variable -Name * -Force -ErrorAction SilentlyContinue

function Get-MD5([string]$Content)
{
	$cryptoServiceProvider = [System.Security.Cryptography.MD5CryptoServiceProvider];
	$hashAlgorithm = new-object $cryptoServiceProvider
	$bytes = [System.Text.Encoding]::Default.GetBytes($Content)
	$hashByteArray = $hashAlgorithm.ComputeHash($bytes);
	$formattedHash = [string]::join("",($hashByteArray | foreach {$_.tostring("x2")}))
	return [string]$formattedHash;
}



Function Get-StringHash([String] $String,$HashName = "MD5") 
{ 
$StringBuilder = New-Object System.Text.StringBuilder 
[System.Security.Cryptography.HashAlgorithm]::Create($HashName).ComputeHash([System.Text.Encoding]::Default.GetBytes($String))|%{ 
[Void]$StringBuilder.Append($_.ToString("x1")) 
} 
$StringBuilder.ToString() 
}



Function Get-Hashh ([string]$Content)
  {
    #converts string to MD5 hash in hyphenated and uppercase format

$md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$utf8 = new-object -TypeName System.Text.UTF8Encoding
$hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($Content)))
return [string]$hash.ToLower().replace("-","")
  }


[string]$passSTR = "247247"
[string]$loginSTR = "jiscar"


[string]$a = Get-MD5 $passSTR 
[string]$b = Get-StringHash $passSTR 
[string]$c = Get-Hashh $passSTR 


[string]$a.CompareTo("64fd9cc337872db23bce772ca95e2d40")
[string]$b.CompareTo("64fd9cc337872db23bce772ca95e2d40")
[string]$c.CompareTo("64fd9cc337872db23bce772ca95e2d40")
("64fd9cc337872db23bce772ca95e2d40").CompareTo("64fd9cc337872db23bce772ca95e2d40")


[string]$domen = "https://lektorium.megaplan.ru/BumsCommonApiV01/User/authorize.api"
[string]$login = "jiscar"
[string]$pass = Get-Hashh $passSTR                  #"64fd9cc337872db23bce772ca95e2d40"
$wc = New-Object system.Net.WebClient
$wc.QueryString.Add("Login", $loginSTR)
$wc.QueryString.Add("Password", $pass)

$Result = $wc.downloadString($domen)
$jsn = ConvertFrom-Json $Result 
Write-Host $Result
