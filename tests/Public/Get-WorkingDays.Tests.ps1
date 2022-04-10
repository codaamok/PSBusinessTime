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

Describe "Get-WorkingDays" {
    It "should be 0 working days" {
        $StartDate = Get-Date '2022-04-09 08:00:00'
        $EndDate   = Get-Date '2022-04-09 17:00:00'
        Get-WorkingDays -StartDate $StartDate -EndDate $EndDate | Should -Be 0
    }

    It "should be 1 working day" {
        $StartDate = Get-Date '2022-04-07 08:00:00'
        $EndDate   = Get-Date '2022-04-07 17:00:00'
        Get-WorkingDays -StartDate $StartDate -EndDate $EndDate | Should -Be 1
    }

    It "should be 2 working days across 2 consecutive days" {
        $StartDate = Get-Date '2022-04-07 08:00:00'
        $EndDate   = Get-Date '2022-04-08 17:00:00'
        Get-WorkingDays -StartDate $StartDate -EndDate $EndDate | Should -Be 2
    }

    It "should be 2 working days across 3 consecutive days, with traditional weekends" {
        $StartDate = Get-Date '2022-04-07 08:00:00'
        $EndDate   = Get-Date '2022-04-09 17:00:00'
        Get-WorkingDays -StartDate $StartDate -EndDate $EndDate | Should -Be 2
    }

    It "should be 10 working days across 14 consecutive days, with traditional weekends" {
        $StartDate = Get-Date '2022-04-04 08:00:00'
        $EndDate   = Get-Date '2022-04-17 17:00:00'
        Get-WorkingDays -StartDate $StartDate -EndDate $EndDate | Should -Be 10
    }

    It "should be 9 working days across 14 consecutive days, where a date inbetween is a non-working date eg public holiday" {
        $StartDate = Get-Date '2022-04-04 08:00:00'
        $EndDate   = Get-Date '2022-04-17 17:00:00'
        $NonWorkingDates = Get-Date '2022-04-05'
        Get-WorkingDays -StartDate $StartDate -EndDate $EndDate -NonWorkingDates $NonWorkingDates | Should -Be 9
    }

    It "should be 8 working days across 14 consecutive days, where Sat+Sun+Mon are non-working days" {
        $StartDate = Get-Date '2022-04-04 08:00:00'
        $EndDate   = Get-Date '2022-04-17 17:00:00'
        Get-WorkingDays -StartDate $StartDate -EndDate $EndDate -NonWorkingDaysOfWeek 0,1,6 | Should -Be 8
    }
}