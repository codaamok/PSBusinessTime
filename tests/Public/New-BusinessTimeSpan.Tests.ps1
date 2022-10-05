BeforeAll {
    # Always use built code if running in a pipeline
    if ($env:USER -eq 'runner') {
        Import-Module "$PSScriptRoot/../../build/PSBusinessTime/PSBusinessTime.psd1" -Force
    }
    # Check if module is already imported, as it can be via VSCode task where you can choose what code base to test
    # and you might not want to cloober it with the non-built code
    elseif (-not (Get-Module PSBusinessTime)) {
        Import-Module "$PSScriptRoot/../../src/PSBusinessTime.psd1" -Force
    }
}

Describe "New-BusinessTimeSpan" {
    Context "Date times which start and end within working hours" {
        It "should be 37 minutes on the same day" {
            $StartDate = Get-Date '2022-04-07 10:00:00'
            $EndDate   = Get-Date '2022-04-07 10:37:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Minutes | Should -Be 37
        }

        It "should be 2 hours on the same day" {
            $StartDate = Get-Date '2022-04-07 10:00:00'
            $EndDate   = Get-Date '2022-04-07 12:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 2
        }
        
        It "should be 9 hours on the same day" {
            $StartDate = Get-Date '2022-04-07 08:00:00'
            $EndDate   = Get-Date '2022-04-07 17:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 9
        }

        It "should be 9 hours on the same day" {
            $StartDate = Get-Date '2022-04-07 07:00:00'
            $EndDate   = Get-Date '2022-04-07 18:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 9
        }

        It "should be 1 hour, across 2 consecutive days, where both are working days" {
            $StartDate = Get-Date '2022-04-07 16:00:00'
            $EndDate   = Get-Date '2022-04-08 03:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 1
        }

        It "should be 1 hour, across 2 consecutive days, where both are working days" {
            $StartDate = Get-Date '2022-04-07 22:00:00'
            $EndDate   = Get-Date '2022-04-08 09:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 1
        }

        It "should be 9 hours, across 2 consecutive days, where both are working days" {
            $StartDate = Get-Date '2022-04-07 08:00:00'
            $EndDate   = Get-Date '2022-04-08 08:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 9
        }

        It "should be 9 hours, across 3 consecutive days, where all are working days" {
            $StartDate = Get-Date '2022-04-06 22:00:00'
            $EndDate   = Get-Date '2022-04-08 02:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 9
        }

        It "should be 143 minutes, across 2 consecutive days, where 1 is a working days" {
            $StartDate = Get-Date '2022-04-10 13:52:12'
            $EndDate   = Get-Date '2022-04-11 10:23:12'
            [decimal](New-BusinessTimeSpan -Start $StartDate -End $EndDate).TotalMinutes | Should -Be 143.2
        }
    
        It "should be 10 hours, across 1 full day and 1 partial day, where both are working days" {
            $StartDate = Get-Date '2022-04-07 08:00:00'
            $EndDate   = Get-Date '2022-04-08 09:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 10
        }
    
        It "should be 10 hours, across 1 partial day and 1 full day, where both are working days" {
            $StartDate = Get-Date '2022-04-07 16:00:00'
            $EndDate   = Get-Date '2022-04-08 17:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 10
        }
    
        It "should be 18 hours, across 2 consecutive days, where both are working days" {
            $StartDate = Get-Date '2022-04-07 08:00:00'
            $EndDate   = Get-Date '2022-04-08 17:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 18
        }
    
        It "should be 18 hours, across 3 consecutive days, where all are working days" {
            $StartDate = Get-Date '2022-04-06 13:00:00'
            $EndDate   = Get-Date '2022-04-08 13:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 18
        }
    
        It "should be 45 hours, across 5 consecutive days, where all are working days" {
            $StartDate = Get-Date '2022-04-04 08:00:00'
            $EndDate   = Get-Date '2022-04-08 17:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).TotalHours | Should -Be 45
        }
    
        It "should be 45 hours, across 7 consecutive days, where 5 are working days and 2 are not" {
            $StartDate = Get-Date '2022-04-07 08:00:00'
            $EndDate   = Get-Date '2022-04-13 17:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).TotalHours | Should -Be 45
        }

        It "should be 90 hours, across 14 consecutive days, where 10 are working days and 4 are not" {
            $StartDate = Get-Date '2022-04-07 08:00:00'
            $EndDate   = Get-Date '2022-04-20 17:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).TotalHours | Should -Be 90
        }

        It "should be 90 hours, across 17 consecutive days, where 13 are working days and 6 are not" {
            $StartDate = Get-Date '2022-04-07 08:00:00'
            $EndDate   = Get-Date '2022-04-25 17:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).TotalHours | Should -Be 117
        }

        It "should be 171 hours, across 29 consecutive days, where 19 are working days and 11 are not" {
            $StartDate = Get-Date '2022-04-01 00:00:00'
            $EndDate   = Get-Date '2022-04-30 23:59:59'
            $NonWorkingDates = (Get-Date '2022-04-15'), (Get-Date '2022-04-18')
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate -NonWorkingDates $NonWorkingDates).TotalHours | Should -Be 171
        }

        It "should be 162 hours, across 29 consecutive days, where 18 are working days and 11 are not" {
            $StartDate = Get-Date '2022-04-02 00:00:00'
            $EndDate   = Get-Date '2022-05-01 23:59:59'
            $NonWorkingDates = (Get-Date '2022-04-15'), (Get-Date '2022-04-18')
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate -NonWorkingDates $NonWorkingDates).TotalHours | Should -Be 162
        }

        It "should be 180 hours, across 29 consecutive days, where 20 are working days and 10 are not" {
            $StartDate = Get-Date '2022-04-02 00:00:00'
            $EndDate   = Get-Date '2022-05-01 23:59:59'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).TotalHours | Should -Be 180
        }

        It "should be 2340 hours, across 365 consecutive days, where 260 are working days and 105 are not" {
            $StartDate = Get-Date '2022-01-01 00:00:00'
            $EndDate   = Get-Date '2022-12-31 23:59:59'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).TotalHours | Should -Be 2340
        }

        It "should be 2259 hours, across 365 consecutive days, where 251 are working days and 20 are not" {
            $StartDate = Get-Date '2022-01-01 00:00:00'
            $EndDate   = Get-Date '2022-12-31 23:59:59'
            $NonWorkingDates = @(
                Get-Date '2022-01-03' # New Year's Day
                Get-Date '2022-04-15' # Good Friday
                Get-Date '2022-04-18' # Easter Monday
                Get-Date '2022-05-02' # Early May bank Holiday
                Get-Date '2022-06-02' # Spring bank Holiday
                Get-Date '2022-06-03' # Platinum Jubliee bank holiday
                Get-Date '2022-08-29' # Summer bank holiday
                Get-Date '2022-12-26' # Boxing Day
                Get-Date '2022-12-27' # Christmas Day
            )
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate -NonWorkingDates $NonWorkingDates).TotalHours | Should -Be 2259
        }

        It "should be 0 hours, across 365 consecutive days, where 0 are working days and 365 are not" {
            $StartDate = Get-Date '2022-01-01 00:00:00'
            $EndDate   = Get-Date '2022-12-31 23:59:59'
            $NonWorkingDaysOfWeek = 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate -NonWorkingDaysOfWeek $NonWorkingDaysOfWeek).TotalHours | Should -Be 0
        }

        It "should be 0 hours, across 2 consecutive days, where 2 are working days" {
            $StartDate = Get-Date '2022-04-07 18:00:00'
            $EndDate   = Get-Date '2022-04-08 03:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 0
        }

        It "should be 0 hours, across 1 consecutive day, where 1 is a working day" {
            $StartDate = Get-Date '2022-04-07 01:00:00'
            $EndDate   = Get-Date '2022-04-07 03:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 0
        }

        It "should be 0 hours, across 1 consecutive day, where 1 is a working day" {
            $StartDate = Get-Date '2022-04-07 18:00:00'
            $EndDate   = Get-Date '2022-04-07 19:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 0
        }

        It "should be 0 hours, across 4 consecutive days, where 2 are working days" {
            $StartDate = Get-Date '2022-04-08 18:00:00'
            $EndDate   = Get-Date '2022-04-11 03:00:00'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate).Hours | Should -Be 0
        }

        It "should be 2016.41666666667, across 4 consecutive days, where 3 are working days" {
            $StartDate = Get-Date '24 March 2022 07:23:33'
            $EndDate   = Get-Date '28 March 2022 01:04:35'
            (New-BusinessTimeSpan -Start $StartDate -End $EndDate -StartHour (Get-Date '07:00:00') -FinishHour (Get-Date '23:59:59')).TotalMinutes | Should -Be '2016.41666666667'
        }
    }
}