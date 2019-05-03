#Create deployment
$Deployment = New-CMApplicationDeployment `
                    -CollectionName 'All Systems' `
                    -Name '7-Zip 19.00 (x64) 19.00 RZ19053768'
                    -DeployAction Install `
                    -DeployPurpose Available `
                    -ApprovalRequired $true


#Get required info for the approval
$Device = Get-CMDevice -Name $env:ComputerName

$Application = Get-CMApplication -Name '7-Zip 19.00 (x64) 19.00 RZ19053768'

$clientGuid = $Device.SMSID
$appid = $Application.ModelName
$autoInstall = "true"
$comments = "Approved"

#invoke approval
Invoke-WmiMethod `
          -Path "SMS_ApplicationRequest" `
          -Namespace 'root\sms\site_PS1' `
          -Name CreateApprovedRequest `
          -ArgumentList @($appid, $autoInstall, $clientGuid, $comments)

# code to "re approve" if something is denied
$reqObj = Get-WmiObject -Namespace 'root\sms\site_PS1' -Class SMS_UserApplicationRequest | `
  Where-Object {$_.ModelName -eq $appid -and $_.RequestedMachine -eq $env:ComputerName }
$reqObj.Approve('Approved', 1)