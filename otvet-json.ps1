<#
$forjsn = @"
{
    "status":{
        "code":"ok","message":null
    },
    "data":{
        "UserId":1000075,
        "EmployeeId":1000009,
        "ContractorId":"",
        "AccessId":"2aC28cfe795d31cddabf",
        "SecretKey":"605b6574d71cdef9e5ca7c9487bbd5d2ca46bcce"
    }
}
"@ | ConvertFrom-Json

$forjsn.data.SecretKey | Write-Host
#>