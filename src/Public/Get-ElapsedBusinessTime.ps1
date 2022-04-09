function Get-ElapsedBusinessTime {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [datetime]$StartDate,
        
        [Parameter(Mandatory)]
        [ValidateScript({
            if ($StartDate -gt $_) { throw "-StartDate must be less than -EndDate." } else { return $true }
        })]
        [datetime]$EndDate,

        [Parameter()]
        [DateTime]$StartOfDay = '08:00:00',

        [Parameter()]
        [DateTime]$EndOfDay = '17:00:00',

        [Parameter()]
        [int[]]$NonWorkingDaysOfWeek = @(0,6),

        [Parameter()]
        [DateTime[]]$NonWorkingDates = @()
    )

    $CommonParams = @{
        NonWorkingDaysOfWeek = $NonWorkingDaysOfWeek
        NonWorkingDates      = $NonWorkingDates
    }

    $WorkingHours = New-TimeSpan -Start $StartOfDay -End $EndOfDay      
    $WorkingDays  = Get-WorkingDays -StartDate $StartDate -EndDate $EndDate @CommonParams

    if ($WorkingDays -eq 0) {
        New-TimeSpan
    }
    elseif ($WorkingDays -eq 1) {
        $Params = @{
            StartDate  = $StartDate
            EndDate    = $EndDate
            StartOfDay = $StartOfDay
            EndOfDay   = $EndOfDay
        }

        GetElapsedTime @Params
    }
    else {
        $ElapsedTime = New-TimeSpan
        
        if (Test-WorkingDay -StartDate $StartDate -StartHour $StartOfDay -FinishHour $EndOfDay @CommonParams) {
            $FirstDayEndDate = Get-Date ('{0}/{1}/{2} {3}:{4}:{5}' -f $StartDate.Year,
                                                                      $StartDate.Month,
                                                                      $StartDate.Day,
                                                                      $EndOfDay.Hour, 
                                                                      $EndOfDay.Minute, 
                                                                      $EndOfDay.Second)
            
            $Params = @{
                StartDate  = $StartDate
                EndDate    = $FirstDayEndDate
                StartOfDay = $StartOfDay
                EndOfDay   = $EndOfDay
            }
            $ElapsedTime += (GetElapsedTime @Params)
            $WorkingDays--
        }

        if (Test-WorkingDay -StartDate $EndDate -StartHour $StartOfDay -FinishHour $EndOfDay @CommonParams) {
            $LastDayStartDate = Get-Date ('{0}/{1}/{2} {3}:{4}:{5}' -f $EndDate.Year,
                                                                       $EndDate.Month,
                                                                       $EndDate.Day,
                                                                       $StartOfDay.Hour, 
                                                                       $StartOfDay.Minute, 
                                                                       $StartOfDay.Second)
            
            $Params = @{
                StartDate  = $LastDayStartDate
                EndDate    = $EndDate
                StartOfDay = $StartOfDay
                EndOfDay   = $EndOfDay
            }
            $ElapsedTime += (GetElapsedTime @Params)
            $WorkingDays--
        }

        $InBetweenHours = $WorkingDays * $WorkingHours.Hours
        (New-TimeSpan -Hours $InBetweenHours) + $ElapsedTime
    }
}