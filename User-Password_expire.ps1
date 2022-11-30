$Output = @() 
$Days = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge.Days 
Foreach ($ADUsers in Get-ADuser -filter {(PassWordNeverExpires -eq "false") -and (Enabled -eq "True")}) 
{ 
    $ADUser = Get-ADUser -Identity $ADUsers.SAMAccountName -Properties * 
    $DayOfExpiration =  (get-date $aduser.passwordlastset).AddDays($days) 
    $DaysToExpire =  ((get-date $aduser.passwordlastset).AddDays($days) - (get-date)).Days 
    $Output += New-Object PSObject -Property @{DisplayName=$ADUser.DisplayName; PasswordLastSet=$aduser.passwordlastset;'The date the password will expire on'=$DayOfExpiration ;DaysLeft=$DaysToExpire; EmailAddress=$ADUser.EmailAddress} 
} 
 
$Output | Out-GridView 