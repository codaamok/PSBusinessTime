# PSBusinessTime
A PowerShell module with functions to help working with and calculating business hours / date times.

## To-do

- Use some public API for public holidays
- Allow configurable 'lunch hour' and so it respects the designated time period, too, e.g.
  - if start date is 8am and end date is 5pm, and 'lunch hour' time period is 12pm - 1pm, then working hours is 8.
  - if start date is 12pm and end date is 5pm, and 'lunch hour' time period is 12pm - 1pm, then working hours is 4.
- Allow config for specifying days with different working hours, e.g. perhaps specific dates of the month or year might be 4 or 5 working hours rather than 8 or 9, which is generally days like Christmas Eve is most western countries