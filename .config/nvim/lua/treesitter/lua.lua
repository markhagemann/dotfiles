require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "javascript",
        "typescript",
        "vue",
        "html",
        "css",
        "bash",
        "cpp",
        "rust",
        "lua"
    },
    autotag = {enable = true},
    highlight = {
        enable = true,
        use_languagetree = true
    }
}
