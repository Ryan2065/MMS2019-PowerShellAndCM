Get-Command *-CM*

Get-Command *Collection* -CommandType Cmdlet

Get-CMCollection

$Collections = Get-CMCollection -CollectionType Device

$Collections.Count

$Collections[0]

$Collections = Get-CMCollection -CollectionType Device -Name '*[Testing]'

$Collections.Count

$Collections = Get-CMCollection -CollectionType Device -Name '*[Testing]' | Where-Object { $_.RefreshType -eq 6 }

Foreach($Collection in $Collections) {
    Set-CMCollection -InputObject $Collection -RefreshType Manual -WhatIf
}

Foreach($Collection in $Collections) {
    Set-CMCollection -InputObject $Collection -RefreshType Manual
}


$RandomMinutes = Get-Random -Minimum 0 -Maximum 1440
$RandomDateTime = (Get-Date).AddMinutes($RandomMinutes)
$Schedule = New-CMSchedule -Start $RandomDateTime -RecurCount 1 -RecurInterval Days
Set-CMCollection -InputObject $Collection -RefreshSchedule $Schedule


$Collections = Get-CMCollection -CollectionType Device -Name '*[Testing]'

Foreach($collection in $collections){
    $RandomMinutes = Get-Random -Minimum 0 -Maximum 1440
    $RandomDateTime = (Get-Date).AddMinutes($RandomMinutes)
    $Schedule = New-CMSchedule -Start $RandomDateTime -RecurCount 1 -RecurInterval Days
    Set-CMCollection -InputObject $Collection -RefreshSchedule $Schedule
}

