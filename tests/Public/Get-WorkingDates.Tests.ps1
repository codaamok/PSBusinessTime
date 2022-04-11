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

Describe "Get-WorkingDates" {
    It "should be 0 working days" {
        $StartDate = Get-Date '2022-04-09 08:00:00'
        $EndDate   = Get-Date '2022-04-09 17:00:00'
        Get-WorkingDates -StartDate $StartDate -EndDate $EndDate | Should -BeNullOrEmpty
    }

    It "should be 1 working day" {
        $StartDate = Get-Date '2022-04-07 08:00:00'
        $EndDate   = Get-Date '2022-04-07 17:00:00'
        Get-WorkingDates -StartDate $StartDate -EndDate $EndDate | Should -Be $StartDate.Date
    }

    It "should be 2 working days across 2 consecutive days" {
        $StartDate = Get-Date '2022-04-07 08:00:00'
        $EndDate   = Get-Date '2022-04-08 17:00:00'
        Get-WorkingDates -StartDate $StartDate -EndDate $EndDate | Should -Be (0..1 | ForEach-Object { $StartDate.AddDays($_).Date })
    }

    It "should be 2 working days across 3 consecutive days, with traditional weekends" {
        $StartDate = Get-Date '2022-04-07 08:00:00'
        $EndDate   = Get-Date '2022-04-09 17:00:00'
        Get-WorkingDates -StartDate $StartDate -EndDate $EndDate | Should -Be (0..1 | ForEach-Object { $StartDate.AddDays($_).Date })
    }

    It "should be 10 working days across 14 consecutive days, with traditional weekends" {
        $StartDate = Get-Date '2022-04-04 08:00:00'
        $EndDate   = Get-Date '2022-04-17 17:00:00'
        Get-WorkingDates -StartDate $StartDate -EndDate $EndDate | Should -Be @(
            (Get-Date '2022-04-04 00:00:00').Date
            (Get-Date '2022-04-05 00:00:00').Date
            (Get-Date '2022-04-06 00:00:00').Date
            (Get-Date '2022-04-07 00:00:00').Date
            (Get-Date '2022-04-08 00:00:00').Date
            (Get-Date '2022-04-11 00:00:00').Date
            (Get-Date '2022-04-12 00:00:00').Date
            (Get-Date '2022-04-13 00:00:00').Date
            (Get-Date '2022-04-14 00:00:00').Date
            (Get-Date '2022-04-15 00:00:00').Date
        )
    }

    It "should be 9 working days across 14 consecutive days, where a date inbetween is a non-working date eg public holiday" {
        $StartDate = Get-Date '2022-04-04 08:00:00'
        $EndDate   = Get-Date '2022-04-17 17:00:00'
        $NonWorkingDates = Get-Date '2022-04-05'
        Get-WorkingDates -StartDate $StartDate -EndDate $EndDate -NonWorkingDates $NonWorkingDates | Should -Be @(
            (Get-Date '2022-04-04 00:00:00').Date
            (Get-Date '2022-04-06 00:00:00').Date
            (Get-Date '2022-04-07 00:00:00').Date
            (Get-Date '2022-04-08 00:00:00').Date
            (Get-Date '2022-04-11 00:00:00').Date
            (Get-Date '2022-04-12 00:00:00').Date
            (Get-Date '2022-04-13 00:00:00').Date
            (Get-Date '2022-04-14 00:00:00').Date
            (Get-Date '2022-04-15 00:00:00').Date
        )
    }

    It "should be 8 working days across 14 consecutive days, where Sat+Sun+Mon are non-working days" {
        $StartDate = Get-Date '2022-04-04 08:00:00'
        $EndDate   = Get-Date '2022-04-17 17:00:00'
        Get-WorkingDates -StartDate $StartDate -EndDate $EndDate -NonWorkingDaysOfWeek 'Saturday','Sunday','Monday' | Should -Be @(
            (Get-Date '2022-04-05 00:00:00').Date
            (Get-Date '2022-04-06 00:00:00').Date
            (Get-Date '2022-04-07 00:00:00').Date
            (Get-Date '2022-04-08 00:00:00').Date
            (Get-Date '2022-04-12 00:00:00').Date
            (Get-Date '2022-04-13 00:00:00').Date
            (Get-Date '2022-04-14 00:00:00').Date
            (Get-Date '2022-04-15 00:00:00').Date
        )
    }
}