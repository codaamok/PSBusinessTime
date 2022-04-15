function Add-WorkingDays {
    <#
    .SYNOPSIS
        Add a number of working days onto a given date.
    .DESCRIPTION
        Add a number of working days onto a given date.

        What constitutes a "working day" in terms of day of the week, or calendar date, is arbitrary and completely customisable.

        In other words, the default parameters dictate normal working days, which are Monday through Friday.

        You can also specify particular dates, or days of the week, to be regarded as non-working dates via the -NonWorkingDates and -NonWorkingDaysOfWeek parameters.
    .PARAMETER Date
        The starting date used for calculation.
        
        The default value is the current datetime.
    .PARAMETER Days
        The number of working days to add onto from the given date.
        
        Number can be negative in order to substract from the given date, too.
    .PARAMETER NonWorkingDaysOfWeek
        The days of the week, representated as strings e.g. 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday', which denotes non-working days of the week.
        
        Days specified in this parameter will not be considered as working days.

        Default values are Saturday and Sunday.
    .PARAMETER NonWorkingDates
        An array of datetime objects which denote specific non-working dates.
        
        Dates specified in this parameter will not be considered as working days.
    .EXAMPLE
        Add-WorkingDays -Days 3
        
        Adds 3 working days onto the current date. For example, if today's date is 2022-04-07, then the returned datetime object will be 2022-04-12.
    .EXAMPLE
        Add-WorkingDays -Days -3

        Minuses 3 working days from the current date. For example, if today's date is 2022-04-07, then the returned datetime object will be 2022-04-04.
    .EXAMPLE
        Add-WorkingDays -Date (Get-Date '2022-04-14') -Days 5 -NonWorkingDates (Get-Date '2022-04-15'),(Get-Date '2022-04-18')

        Add 5 working days from 2022-04-14, discounting 2022-04-15 (Good Friday) and 2022-04-18 (Easter Monday) as working days. The returned datetime object will be 2022-04-25.
    .EXAMPLE
        Add-WorkingDays -Days 1 -NonWorkingDaysOfWeek 'Friday','Saturday','Sunday'

        Add 1 working day onto the current date. For example, if today's date is 2022-04-07, then the returned datetime object will be 2022-04-11.
    .INPUTS
        This function does not accept pipeline input.
    .OUTPUTS
        System.DateTime
    .NOTES
        Chris Dent (@indented-automation) wrote this in the WinAdmins Discord
        https://discord.com/channels/618712310185197588/618857671608500234/913855890384371712
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [object]$Date = (Get-Date),

        [Parameter(Mandatory)]
        [int]$Days,

        [Parameter()]
        [ValidateSet('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday')]
        [String[]]$NonWorkingDaysOfWeek = @('Saturday','Sunday'),

        [Parameter()]
        [DateTime[]]$NonWorkingDates
    )

    $increment = $Days / [Math]::Abs($Days)
    do {
        $Date = $Date.AddDays($increment)
        
        if ($NonWorkingDaysOfWeek -notcontains $Date.DayOfWeek -And $NonWorkingDates -notcontains $Date.Date) {
            $Days -= $increment
        }
    } while ($Days)

    return $Date
}
