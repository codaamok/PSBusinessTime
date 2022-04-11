function Get-WorkingDates {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [DateTime]$StartDate,

        [Parameter(Mandatory)]
        [ValidateScript({
            if ($StartDate -gt $_) { throw "-StartDate must be less than -EndDate." } else { return $true }
        })]
        [DateTime]$EndDate,

        [Parameter()]
        [int[]]$NonWorkingDaysOfWeek = @(0,6),

        [Parameter()]
        [DateTime[]]$NonWorkingDates = @()
    )
 
    if ($StartDate.TimeOfDay -eq $EndDate.TimeOfDay) { 
        # This can return 1 less than intended if we do not do this change. 
        # For example, if the dates in between are 3 working days,
        # but the time span between them are 2 whole days,
        # this returns 2 instead of 3
        $EndDate = $EndDate.AddSeconds(1) 
    }

    $TimeSpan = New-TimeSpan -Start $StartDate -End $EndDate
    $Days = [Math]::Ceiling($TimeSpan.TotalDays)
    $Date = $StartDate

    $WorkingDays = do {
        if ($NonWorkingDaysOfWeek -notcontains $Date.DayOfWeek -And $NonWorkingDates -notcontains $Date.Date) {
            $Date.Date
        }
        $Date = $Date.AddDays(1)
        $Days--
    } while ($Days)

    $WorkingDays
}