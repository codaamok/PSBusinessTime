# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.4] - 2022-04-14
### Fixed
- `Get-ElapsedBusinessTime` did not return correct result when either the start date or end date were outside of business hours
- Added line breaks in between each line for all comment based help

## [0.1.2] - 2022-04-13
### Fixed
- `Get-ElapsedBusinessTime` did not return correct result where the number of working days between `-StartDate` and `-EndDate` was 1 but the date range spanned more than 1 calendar day, e.g. Sunday through to Monday.

## [0.1.1] - 2022-04-12
### Fixed
- Some typo and grammar issues in comment based help
- `Get-WorkingDates` would not return the correct number of working dates, which also impacted `Get-ElapsedBusinessTime`

## [0.1.0] - 2022-04-11
### Added
- Initial release

[Unreleased]: https://github.com/codaamok/PSBusinessTime/compare/0.1.4..HEAD
[0.1.4]: https://github.com/codaamok/PSBusinessTime/compare/0.1.2..0.1.4
[0.1.2]: https://github.com/codaamok/PSBusinessTime/compare/0.1.1..0.1.2
[0.1.1]: https://github.com/codaamok/PSBusinessTime/compare/0.1.0..0.1.1
[0.1.0]: https://github.com/codaamok/PSBusinessTime/tree/0.1.0