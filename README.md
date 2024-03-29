# PSBusinessTime

| Branch | Build status | Last commit | Latest release | PowerShell Gallery | GitHub |
|-|-|-|-|-|-|
| `main` | [![GitHub Workflow Status (main)](https://img.shields.io/github/workflow/status/codaamok/PSBusinessTime/Pipeline/main)](https://github.com/codaamok/PSBusinessTime/actions) | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/codaamok/PSBusinessTime/main?color=blue)](https://github.com/codaamok/PSBusinessTime/commits/main) | [![GitHub release (latest by date)](https://img.shields.io/github/v/release/codaamok/PSBusinessTime?color=blue)](https://github.com/codaamok/PSBusinessTime/releases/latest) [![GitHub Release Date](https://img.shields.io/github/release-date/codaamok/PSBusinessTime?color=blue)](https://github.com/codaamok/PSBusinessTime/releases/latest) | [![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/PSBusinessTime?color=blue)](https://www.powershellgallery.com/packages/PSBusinessTime) | [![GitHub all releases](https://img.shields.io/github/downloads/codaamok/PSBusinessTime/total?color=blue)](https://github.com/codaamok/PSBusinessTime/releases) |

A PowerShell module with functions to help calculate working hours, and for generally working with or calculating business hours / date times.

Inspired by https://pleasework.robbievance.net/howto-calculate-elapsed-business-hours-using-powershell/.

## Functions

- [Add-WorkingDays](docs/Add-WorkingDays.md)
- [New-BusinessTimeSpan](docs/New-BusinessTimeSpan.md)
- [Get-WorkingDates](docs/Get-WorkingDates.md)
- [Test-WorkingDay](docs/Test-WorkingDay.md)

## Requirements

- PowerShell 5.1 or newer

## Getting started

Install and import:

```powershell
Install-Module PSBusinessTime -Scope CurrentUser
Import-Module PSBusinessTime
```

See the below examples and use `Get-Help` to learn more about the functions with examples. You can discover all functions in the module by running:

```powershell
Get-Command -Module PSBusinessTime
```

## Examples

```powershell
New-BusinessTimeSpan -Start (Get-Date '2022-04-01 00:00:00') -End (Get-Date '2022-04-30 23:59:59') -NonWorkingDates (Get-Date '2022-04-15'), (Get-Date '2022-04-18')
```

The function will return a timespan object of 171 hours:

```powershell
Days              : 7
Hours             : 3
Minutes           : 0
Seconds           : 0
Milliseconds      : 0
Ticks             : 6156000000000
TotalDays         : 7.125
TotalHours        : 171
TotalMinutes      : 10260
TotalSeconds      : 615600
TotalMilliseconds : 615600000
```

2022-04-01 through 2022-04-30 is an entire calendar month, and only 171 hours is considered "working hours" within the defined parameters. '2022-04-15' and '2022-04-18' are considered non-working dates.

___

```powershell
Test-WorkingDay -Date (Get-Date '2022-04-11 09:00:00')
```

The function will return `true` because the datetime is within the default parameters. 2022-04-11 is a Monday, and 09:00 is between 08:00 and 17:00.

___

```powershell
Get-WorkingDates -Start (Get-Date '2022-04-04') -End (Get-Date '2022-04-17') -NonWorkingDaysOfWeek 'Saturday','Sunday','Monday'
```

The function will return an array of 8 datetime objects for '2022-04-05' through to '2022-04-08', and '2022-04-12' through to '2022-04-15':

```powershell
05 April 2022 00:00:00
06 April 2022 00:00:00
07 April 2022 00:00:00
08 April 2022 00:00:00
12 April 2022 00:00:00
13 April 2022 00:00:00
14 April 2022 00:00:00
15 April 2022 00:00:00
```

These are considered working dates within the defined parameters. Saturdays, Sundays, and Mondays, are considered non-working days, therefore every other date inbetween the range is considered a working date.

## To-do

- Use some public API for public holidays
- Allow configurable 'lunch hour' and so it respects the designated time period, too, e.g.
  - if start date is 8am and end date is 5pm, and 'lunch hour' time period is 12pm - 1pm, then working hours is 8.
  - if start date is 12pm and end date is 5pm, and 'lunch hour' time period is 12pm - 1pm, then working hours is 4.
- Allow config for specifying days with different working hours, e.g. perhaps specific dates of the month or year might be 4 or 5 working hours rather than 8 or 9, which is generally days like Christmas Eve is most western countries
