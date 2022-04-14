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

Describe "Add-WorkingDays" {
    It "should be 2022-04-19 as 3 working days from 2022-04-14" {
        Add-WorkingDays -Date (Get-Date '2022-04-14') -Days 3 | Should -Be (Get-Date '2022-04-19')
    }

    It "should be 2022-04-11 as -3 working days from 2022-04-14" {
        Add-WorkingDays -Date (Get-Date '2022-04-14') -Days -3 | Should -Be (Get-Date '2022-04-11')
    }

    It "should be 2022-04-21 as 3 working days from 2022-04-14, with Good Friday and Easter Monday holidays" {
        Add-WorkingDays -Date (Get-Date '2022-04-14') -Days 3 -NonWorkingDates (Get-Date '2022-04-15'),(Get-Date '2022-04-18') | Should -Be (Get-Date '2022-04-21')
    }

    It "should be 2022-04-21 as 3 working days from 2022-04-14, excluding Friday, Saturday, Sunday, and Monday, as working days" {
        Add-WorkingDays -Date (Get-Date '2022-04-14') -Days 3 -NonWorkingDaysOfWeek 'Friday','Saturday','Sunday','Monday' | Should -Be (Get-Date '2022-04-21')
    }
}