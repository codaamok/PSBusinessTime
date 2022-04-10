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

Describe "Test-WorkingDay" {
    It "Should be a working day: <_.Description>" -TestCases @(
        @{
            StartDate   = Get-Date '2022-04-07 10:00:00'
            StartHour   = Get-Date '08:00:00'
            FinishHour  = Get-Date '17:00:00'
            Description = 'traditional work day and time'
        }
        @{
            StartDate   = Get-Date '2022-04-07 01:00:00'
            StartHour   = Get-Date '01:00:00'
            FinishHour  = Get-Date '17:00:00'
            Description = 'alternative starting work hour'
        }
        @{
            StartDate   = Get-Date '2022-04-07 22:00:00'
            StartHour   = Get-Date '08:00:00'
            FinishHour  = Get-Date '23:00:00'
            Description = 'alternative finishing work hour'
        }
    ) {
        $Params = @{
            StartDate  = $StartDate
            StartHour  = $StartHour
            FinishHour = $FinishHour
        }
        Test-WorkingDay @Params | Should -BeTrue
    }

    It "Should not be a working day: <_.Description>" -TestCases @(
        @{
            StartDate            = Get-Date '2022-04-10 10:00:00'
            NonWorkingDates      = $null
            NonWorkingDaysOfWeek = 0,6
            Description          = 'weekend'
        }
        @{
            StartDate            = Get-Date '2022-04-07 10:00:00'
            NonWorkingDates      = Get-Date '2022-04-07'
            NonWorkingDaysOfWeek = 0,6
            Description          = 'non-working date eg public holiday'
        }
        @{
            StartDate            = Get-Date '2022-04-07 10:00:00'
            NonWorkingDates      = $null
            NonWorkingDaysOfWeek = 4
            Description          = 'alternative non-working day of the week'
        }
    ) {
        $Params = @{
            StartDate            = $StartDate
            NonWorkingDates      = $NonWorkingDates
            NonWorkingDaysOfWeek = $NonWorkingDaysOfWeek
        }
        Test-WorkingDay @Params | Should -BeFalse
    }
}