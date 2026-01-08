return {
  -- Ember.js Handlebars template syntax highlighting
  { "joukevandermaas/vim-ember-hbs", event = "BufReadPre" },
  -- Highlight function arguments using tree-sitter
  { "m-demare/hlargs.nvim",          event = "BufEnter" },
}
