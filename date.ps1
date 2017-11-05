Remove-Variable -Name * -Force -ErrorAction SilentlyContinue
<#

$date1 = [String]::Format('{0:R}',(get-date -f r))| Write-Host
$date2 = [String]::Format('{0:R}',(get-date -f zzzz))| Write-Host
$date2.remove(3) | Write-Host
$date1.Replace("GMT",$date2)| Write-Host

[string]$date1 = '{0:r}' -f $(Get-Date) #| Write-Host
[string]$date2 = '{0:zzzz}' -f $(Get-Date) #| Write-Host
[string]$dat = $date2.Remove(3) | Write-Host -ForegroundColor Yellow
[string]$dt1 = $date1.Replace("GMT",$date2) | Write-Host -ForegroundColor Green
[string]$dt2 = $date1.Replace(":","_") | Write-Host -ForegroundColor Green



$str = [string]::Concat("ololo","`n","ololo") | Write-Host -ForegroundColor green
Write-Host -ForegroundColor Green $date2

$Date = Get-Date
$Date.GetType()
$Date | gm -MemberType Method

$Date1 = (Get-Date -Format zzzz).ToString([CultureInfo]::GetCultureInfo('en-US')).Replace(":","_")| Write-Host -ForegroundColor green
$Date2 = (Get-Date -Format r).ToString([CultureInfo]::GetCultureInfo('en-US')).Replace("GMT","+3000") | Write-Host -ForegroundColor green
#>

[string]$DateString = (Get-Date -Format r).Replace("GMT",(Get-Date -Format zz00)).ToString([CultureInfo]::GetCultureInfo('en-US'))

Write-Host -ForegroundColor green $DateString