Remove-Variable -Name * -Force -ErrorAction SilentlyContinue
<#
Function Get-StringHash1([String] $String,$HashName = "MD5") 
{ 
$StringBuilder = New-Object System.Text.StringBuilder 
[System.Security.Cryptography.HashAlgorithm]::Create($HashName).ComputeHash([System.Text.Encoding]::Default.GetBytes($String))|%{ 
[Void]$StringBuilder.Append($_.ToString("x1")) 
} 
$StringBuilder.ToString() 
}

Function Get-StringHash([String] $String,$HashName = "HMACSHA1") 
{ 
$StringBuilder = New-Object System.Text.StringBuilder 
[System.Security.Cryptography.HashAlgorithm]::Create($HashName).ComputeHash([System.Text.Encoding]::Default.GetBytes($String))|%{ 
[Void]$StringBuilder.Append($_.ToString("x1")) 
} 
$StringBuilder.ToString() 
}

#>


$multString = @"
POST

application/x-www-form-urlencoded
Tue, 09 Dec 2014 11:06:23 +0300
example.megatest.local/BumsCrmApiV01/Contractor/list.api
"@
$STR = "FUCKINGCODING"
$SecretKey = "FUCKINGCODING"
# NjRiMGIyNTVmOWMzYTU2ZDJiMmZiYzhjODY4YTU4Nzg0NWFkMjk0OA==
#$STR = "POST`n`napplication/x-www-form-urlencoded`nTue, 09 Dec 2014 11:06:23 +0300`nexample.megatest.local/BumsCrmApiV01/Contractor/list.api"
#$SecretKey = "fd57A98113F7Eb562e34F5Fa1c1fDc362dbdE103"

#function GET-HMACSHA1($STR,$SecretKey){
$HMAC = New-Object System.Security.Cryptography.HMACSHA1
$HMAC.key = [Text.Encoding]::UTF8.GetBytes($SecretKey)
$HMAC.ComputeHash([Text.Encoding]::UTF8.GetBytes($STR)) | Out-Null
Foreach ($item in $HMAC.hash){$b+=[System.String]::Format("{0:x2}", [System.Convert]::ToUInt64($item))}
$b=[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($b)).ToString() 
#}
#[string]$c= [System.Convert]::ToUInt32($cc)
Write-Host -ForegroundColor Magenta $b
#GET-HMACSHA1 $STR, $SecretKey



<#
$arr = $cc.Split("`n")
Foreach ($item in $arr){$b+=[System.String]::Format("{0:x}", [System.Convert]::ToUInt32($item))}
$b | Out-Host
$b=[Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($b)).ToString() 
$b | Out-Host
#>

#Write-Host -ForegroundColor Magenta $signRight

<#echo ($signRight -eq "MjdmZTM5ZTJjM2RhMDliMDdiODk2OWQ0YTYxNDQ1NzllMzU4MjIxYg==")
$sub = "27fe39e2c3da09b07b8969d4a6144579e358221b"
$a = [Convert]::ToBase64String([Text.Encoding]::Default.GetBytes($sub))      # .ToString() 
Write-Host -ForegroundColor cyan $a
#>



<#
#39 254 57 226 195 218 9 176 123 137 105 212 166 20 69 121 227 88 34 27
$STR01 = "39 254 57 226 195 218 9 176 123 137 105 212 166 20 69 121 227 88 34 27"
$arr=$STR01.Split(" ") 
Foreach ($item in $arr) {$c+=[System.String]::Format("{0:X}", [System.Convert]::ToUInt32($item))}
$c=$c.ToLower()

$c=[Convert]::ToBase64String([Text.Encoding]::Default.GetBytes($c)).ToString() 

Write-Host -ForegroundColor Cyan $c
#>