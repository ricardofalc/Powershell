$phoneNumber= ""
$identity= ""
$policyName= "NL-VCIO365-AllCalls"

Set-CsPhoneNumberAssignment -Identity $identity -Phonenumber $phoneNumber -PhoneNumberType DirectRouting
Grant-CsTeamsCallingPolicy -identity $identity -Policyname "AllowCalling"
Grant-CsOnlineVoiceRoutingPolicy -Identity $identity -PolicyName $policyName