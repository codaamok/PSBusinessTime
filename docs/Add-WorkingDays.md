---
external help file: PSBusinessTime-help.xml
Module Name: PSBusinessTime
online version:
schema: 2.0.0
---

# Add-WorkingDays

## SYNOPSIS
Add a number of working days onto a given date.

## SYNTAX

```
Add-WorkingDays [[-Date] <Object>] [-Days] <Int32> [[-NonWorkingDaysOfWeek] <String[]>]
 [[-NonWorkingDates] <DateTime[]>] [<CommonParameters>]
```

## DESCRIPTION
Add a number of working days onto a given date.

What constitutes a "working day" in terms of day of the week, or calendar date, is arbitrary and completely customisable.

In other words, the default parameters dictate normal working days, which are Monday through Friday.

You can also specify particular dates, or days of the week, to be regarded as non-working dates via the -NonWorkingDates and -NonWorkingDaysOfWeek parameters.

## EXAMPLES

### EXAMPLE 1
```
Add-WorkingDays -Days 3
```

Adds 3 working days onto the current date.
For example, if today's date is 2022-04-07, then the returned datetime object will be 2022-04-12.

### EXAMPLE 2
```
Add-WorkingDays -Days -3
```

Minuses 3 working days from the current date.
For example, if today's date is 2022-04-07, then the returned datetime object will be 2022-04-04.

### EXAMPLE 3
```
Add-WorkingDays -Date (Get-Date '2022-04-14') -Days 5 -NonWorkingDates (Get-Date '2022-04-15'),(Get-Date '2022-04-18')
```

Add 5 working days from 2022-04-14, discounting 2022-04-15 (Good Friday) and 2022-04-18 (Easter Monday) as working days.
The returned datetime object will be 2022-04-25.

### EXAMPLE 4
```
Add-WorkingDays -Days 1 -NonWorkingDaysOfWeek 'Friday','Saturday','Sunday'
```

Add 1 working day onto the current date.
For example, if today's date is 2022-04-07, then the returned datetime object will be 2022-04-11.

## PARAMETERS

### -Date
The starting date used for calculation.

The default value is the current datetime.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: (Get-Date)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Days
The number of working days to add onto from the given date.

Number can be negative in order to substract from the given date, too.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
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
Position: 3
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
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### This function does not accept pipeline input.
## OUTPUTS

### System.DateTime
## NOTES
Chris Dent (@indented-automation) wrote this in the WinAdmins Discord
https://discord.com/channels/618712310185197588/618857671608500234/913855890384371712

## RELATED LINKS
