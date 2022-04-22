---
external help file: PSBusinessTime-help.xml
Module Name: PSBusinessTime
online version:
schema: 2.0.0
---

# New-BusinessTimeSpan

## SYNOPSIS
Get the elapsed time between two dates, where the time measured is only inbetween "business hours".

## SYNTAX

```
New-BusinessTimeSpan [-Start] <DateTime> [-End] <DateTime> [[-StartHour] <DateTime>] [[-FinishHour] <DateTime>]
 [[-NonWorkingDaysOfWeek] <String[]>] [[-NonWorkingDates] <DateTime[]>] [<CommonParameters>]
```

## DESCRIPTION
Get the elapsed time between two dates, where the time measured is only inbetween "business hours".

This is helpful to measure the amount of time past from a start datetime, to an end datetime, while only considering "business hours".

What constitutes "business hours" in terms of day of the week, or calendar date, including working hours, is arbitrary and completely customisable.

In other words, the default parameters dictate normal working days, which are Monday through Friday and 08:00 through 17:00.

You can also specify particular dates, or days of the week, to be regarded as non-working dates via the -NonWorkingDates and -NonWorkingDaysOfWeek parameters.

This function does consider both date and time while calculating the elapsed time.

## EXAMPLES

### EXAMPLE 1
```
New-BusinessTimeSpan -Start (Get-Date '2022-04-11 10:00:00') -End (Get-Date '2022-04-11 10:37:00')
```

The function will return a timespan object of 37 minutes.
2022-04-11 is a Monday and the whole time inbetween the date range given is within the default parameters.

### EXAMPLE 2
```
New-BusinessTimeSpan -Start (Get-Date '2022-04-11 08:00:00') -End (Get-Date '2022-04-12 08:00:00')
```

The function will return a timespan object of 9 hours.
2022-04-11 is a Monday and 2022-04-12 is a Tuesday, and only 9 hours is considered "working hours" within the default parameters.

### EXAMPLE 3
```
New-BusinessTimeSpan -Start (Get-Date '2022-04-11 13:00:00') -End (Get-Date '2022-04-13 13:00:00')
```

The function will return a timespan object of 18 hours.
2022-04-11 through 2022-04-13 is Monday through Wednesday, and only 18 hours is considered "working hours" within the default parameters.

### EXAMPLE 4
```
New-BusinessTimeSpan -Start (Get-Date '2022-04-01 00:00:00') -End (Get-Date '2022-04-30 23:59:59') -NonWorkingDates (Get-Date '2022-04-15'), (Get-Date '2022-04-18')
```

The function will return a timespan object of 162 hours.
2022-04-01 through 2022-04-30 is an entire calendar month, and only 162 hours is considered "working hours" within the defined parameters.
'2022-04-15' and '2022-04-18' are considered non-working dates.

### EXAMPLE 5
```
New-BusinessTimeSpan -Start (Get-Date '2022-01-01 00:00:00') -End (Get-Date '2022-12-31 23:59:59') -NonWorkingDates (Get-Date '2022-01-03'), (Get-Date '2022-04-15'), (Get-Date '2022-04-18'), (Get-Date '2022-05-02'), (Get-Date '2022-06-02'), (Get-Date '2022-06-03'), (Get-Date '2022-08-29'), (Get-Date '2022-12-26'), (Get-Date '2022-12-27')
```

The function will return a timespan object of 2259 hours.
2022-01-01 through 2022-12-31 is an entire year, and only 2259 hours is considered "working hours" within the defined parameters.
All dates passed to -NonWorkingDates are considered non-working dates (public holidays in the UK for 2022).

### EXAMPLE 6
```
New-BusinessTimeSpan -Start (Get-Date '2022-01-01 00:00:00') -End (Get-Date '2022-12-31 23:59:59') -NonWorkingDaysOfWeek 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'
```

The function will return a timespan object of 0 hours.
2022-01-01 through 2022-12-31 is an entire year, and 0 hours is considered "working hours" within the defined parameters.
All days passed to -NonWorkingDaysOfWeek are considered non-working days, hence the result of 0 hours.

## PARAMETERS

### -Start
The datetime object to start calculating the elapsed time from.
It must be an older datetime than -End.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -End
The datetime object to end calculating the elapsed time to.
It must be a newer datetime than -Start.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartHour
The starting hour of a typical working day.
The default starting hour is 08:00 (AM).

Note: this parameter is a datetime object is, however only the time is used for calculation.
The date is ignored.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 08:00:00
Accept pipeline input: False
Accept wildcard characters: False
```

### -FinishHour
The final hour of a typical working day.
The default final hour is 17:00.
        
Note: this parameter is a datetime object is, however only the time is used for calculation.
The date is ignored.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 17:00:00
Accept pipeline input: False
Accept wildcard characters: False
```

### -NonWorkingDaysOfWeek
The days of the week, representated as strings e.g.
'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday', which denotes non-working days of the week.

Days specified in this parameter will not be considered as working days.

Default values are Saturday and Sunday.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: @('Saturday','Sunday')
Accept pipeline input: False
Accept wildcard characters: False
```

### -NonWorkingDates
An array of datetime objects which denote specific non-working dates.

Dates specified in this parameter will not be considered as working days.

```yaml
Type: DateTime[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### This function does not accept pipeline input.
## OUTPUTS

### System.TimeSpan
## NOTES

## RELATED LINKS
