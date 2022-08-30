Describe 'src/afw'
    Include src/afw
    It 'downlaods a file'
        When call download
        The output should equal 'ok'
    End
End
