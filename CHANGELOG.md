# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2022-05-04
### Changed
- Renamed `Get-ElapsedBusinessTime` to `New-BusinessTimeSpan`, and changed parameters `-StartDate` and `-EndDate` to `-Start` and `-End`, similar to `New-TimeSpan` and its datetime parameters.

## [0.2.2] - 2022-04-15
### Fixed
- CmdletBinding attribute was in incorrect position for `Add-WorkingDays`. This caused PlatyPS to not generate docs properly. This fix does not provide any functional improvement to `Add-WorkingDays`. At this time, it is just necessary to push to source control which invokes the release pipeline.

## [0.2.1] - 2022-04-15
### Fixed
- `New-BusinessTimeSpan` did not return correct result if `-StartDate` and `-EndDate` were on the same day, but it was a working day, and its time for both dates were outside of working hours

## [0.2.0] - 2022-04-14
### Added
- New function `Add-WorkingDays`

## [0.1.7] - 2022-04-14
### Changed
- `Test-WorkingDay` now has parameter validation to ensure `-StartHour` is less then `-FinishHour`
- `New-BusinessTimeSpan` now has parameter validation to ensure `-StartHour` is less then `-FinishHour`

## [0.1.6] - 2022-04-14
### Fixed
- `New-BusinessTimeSpan` did not return correct result if `-StartDate` and `-EndDate` were on the same day, but it was a working day, and its time for both dates were outside of working hours

## [0.1.5] - 2022-04-14
### Fixed
- `New-BusinessTimeSpan` did not return correct result if range between `-StartHour` and `-FinishHour` was not whole, ie was a span of time where minutes and seconds also needed consideration

## [0.1.4] - 2022-04-14
### Fixed
- `New-BusinessTimeSpan` did not return correct result when either the start date or end date were outside of business hours
- Added line breaks in between each line for all comment based help

## [0.1.2] - 2022-04-13
### Fixed
- `New-BusinessTimeSpan` did not return correct result where the number of working days between `-StartDate` and `-EndDate` was 1 but the date range spanned more than 1 calendar day, e.g. Sunday through to Monday.

## [0.1.1] - 2022-04-12
### Fixed
- Some typo and grammar issues in comment based help
- `Get-WorkingDates` would not return the correct number of working dates, which also impacted `New-BusinessTimeSpan`

## [0.1.0] - 2022-04-11
### Added
- Initial release

[Unreleased]: https://github.com/codaamok/PSBusinessTime/compare/0.3.0..HEAD
[0.3.0]: https://github.com/codaamok/PSBusinessTime/compare/0.2.2..0.3.0
[0.2.2]: https://github.com/codaamok/PSBusinessTime/compare/0.2.1..0.2.2
[0.2.1]: https://github.com/codaamok/PSBusinessTime/compare/0.2.0..0.2.1
[0.2.0]: https://github.com/codaamok/PSBusinessTime/compare/0.1.7..0.2.0
[0.1.7]: https://github.com/codaamok/PSBusinessTime/compare/0.1.6..0.1.7
[0.1.6]: https://github.com/codaamok/PSBusinessTime/compare/0.1.5..0.1.6
[0.1.5]: https://github.com/codaamok/PSBusinessTime/compare/0.1.4..0.1.5
[0.1.4]: https://github.com/codaamok/PSBusinessTime/compare/0.1.2..0.1.4
[0.1.2]: https://github.com/codaamok/PSBusinessTime/compare/0.1.1..0.1.2
[0.1.1]: https://github.com/codaamok/PSBusinessTime/compare/0.1.0..0.1.1
[0.1.0]: https://github.com/codaamok/PSBusinessTime/tree/0.1.0