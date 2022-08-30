Describe 'afw'
    Include afw
    It 'downlaods a file'
        When call download
        The output should equal 'ok'
    End
End
