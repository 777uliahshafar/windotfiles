vim.opt_local.conceallevel = 2

require'cmp'.setup.buffer{
sources = {
    { name = "luasnip" },
    {
      name = "dictionary",
      keyword_length = 3,
    },
    { name = "path" },
  },

}
local dict = require("cmp_dictionary")

dict.setup({
  -- The following are default values.
  exact = 2,
  first_case_insensitive = false,
  document = false,
  document_command = "wn %s -over",
  async = false,
  sqlite = false,
  max_items = -1,
  capacity = 5,
  debug = false,
})

dict.switcher({
 spelllang = {
    id = "~/.config/nvim/dicts/id-cmp.dict",
    en_us = "~/.config/nvim/dicts/en-cmp.dict",
  },
})

