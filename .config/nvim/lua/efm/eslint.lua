-- return {
--     lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
--     lintStdin = true,
--     lintFormats = {"%f:%l:%c: %m"},
--     lintIgnoreExitCode = true,
--     formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
--     formatStdin = true
-- }
return {
    lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {
        "%f(%l,%c): %tarning %m",
        "%f(%l,%c): %rror %m"
    },
    lintSource = "eslint"
}
