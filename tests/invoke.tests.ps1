$PesterConfig = New-PesterConfiguration -Hashtable @{
    Run = @{
        Path = '{0}/Public' -f $PSScriptRoot
        Throw = $true
        #SkipRemainingOnFailure = 'Block'
    }
    Output = @{
        Verbosity = 'Detailed'
    }
    TestResult = @{
        Enabled = $true
        OutputFormat = 'NUnit2.5'
    }
}

Invoke-Pester -Configuration $PesterConfig -ErrorAction 'Stop'