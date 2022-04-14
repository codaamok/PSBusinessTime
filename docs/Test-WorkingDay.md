---
external help file: PSBusinessTime-help.xml
Module Name: PSBusinessTime
online version:
schema: 2.0.0
---

# Test-WorkingDay

## SYNOPSIS
Determine whether a given datetime is a working day.

## SYNTAX

```
Test-WorkingDay [-Date] <DateTime> [[-StartHour] <DateTime>] [[-FinishHour] <DateTime>]
 [[-NonWorkingDaysOfWeek] <String[]>] [[-NonWorkingDates] <DateTime[]>] [<CommonParameters>]
```

## DESCRIPTION
Determine whether a given datetime is a working day.

What constitutes a "working day" in terms of day of the week, or calendar date, including working hours, is arbitrary and completely customisable.

In other words, the default parameters dictate normal working days, which are Monday through Friday, and normal working hours are 08:00 through 17:00.

You can also specify particular dates, or days of the week, to be regarded as non-working dates via the -NonWorkingDates and -NonWorkingDaysOfWeek parameters.

If the datetime of -Date falls outside of these parameters, you'll receive a boolean result.

## EXAMPLES

### EXAMPLE 1
```
Test-WorkingDay -Date (Get-Date '2022-04-11 09:00:00')
```

The function will return true because the datetime is within the default parameters.
2022-04-11 is a Monday, and 09:00 is between 08:00 and 17:00.

### EXAMPLE 2
```
Test-WorkingDay -Date (Get-Date '2022-04-10 11:00:00')
```

The function will return false because the datetime is outside the default parameters.
2022-04-10 is a Sunday, and therefore is not a working day, regardless of the hour/minute.

### EXAMPLE 3
```
Test-WorkingDay -Date (Get-Date '2022-04-11 22:00:00') -StartHour (Get-Date '08:00:00') -FinishHour Get-Date '23:00:00'
```

The function will return true because the datetime is within the defined parameters.
2022-04-11 is a Monday, and 22:00 is between 08:00 and 23:00.
Note: a datetime object is passed for both -StartHour and -FinishHour, however only the time is used for calculation.
The date is ignored.

### EXAMPLE 4
```
Test-WorkingDay -Date (Get-Date '2022-04-11 09:00:00') -NonWorkingDaysOfWeek 'Saturday','Sunday','Monday'
```

The function will return false because the datetime is outside the defined parameters.
2022-04-11 is a Monday, and is considered a non working day of the week.

### EXAMPLE 5
```
Test-WorkingDay -Date (Get-Date '2022-04-11 09:00:00') -NonWorkingDates (Get-Date '2022-04-11')
```

The function will return false because the datetime is outside the defined parameters.
2022-04-11 is a Monday, and is considered a non working date.

## PARAMETERS

### -Date
The datetime to determine whether it is a working day or not.

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
Position: 2
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
Position: 3
Default value: 17:00:00
Accept pipeline input: False
Accept wildcard characters: False
```

### -NonWorkingDaysOfWeek
The days of the week, representated as strings e.g.
'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday', which denotes non-working days of the week.

Days specified in this parameter will not be considered as working days.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### This function does not accept pipeline input.
## OUTPUTS

### System.Boolean
## NOTES

## RELATED LINKS
