[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
            return true;
        }
 }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

$PSDefaultParameterValues.Add('Invoke-RestMethod:UseDefaultCredentials',$true)

Invoke-RestMethod "https://$($env:ComputerName).contoso.com/AdminService/v1.0"

$data = Invoke-RestMethod "https://$($env:ComputerName).contoso.com/AdminService/v1.0" 

$data.value

Function mmsinv {
    Param(
        $uri, $method = 'Get', [switch]$FullResponse
    )
    $result = Invoke-RestMethod -Method $Method -Uri "https://$($env:ComputerName).contoso.com/AdminService/$uri" -UseDefaultCredentials
    if($FullResponse) {
        $result
    }
    else {
        $result.value
    }
}

mmsinv 'v1.0/ConsoleAdminsData'
mmsinv 'v1.0/HubItems' -FullResponse

mmsinv 'wmi'

mmsinv 'wmi/'

mmsinv 'wmi/SMS_R_System'

$md = mmsinv 'wmi/$metadata' -FullResponse

mmsinv 'wmi/SMS_R_System/$count' -FullResponse

mmsinv 'wmi/SMS_R_System?$top=1'

mmsinv 'wmi/SMS_R_System(16777219)'

mmsinv 'wmi/SMS_R_System?$filter=Name eq ''D45E0AF1819C'''

mmsinv 'wmi/SMS_R_System(16777219)/SMS_G_System_COMPUTER_SYSTEM'