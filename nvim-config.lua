local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'williamboman/mason.nvim'
Plug 'ervandew/supertab'
Plug ('nvim-telescope/telescope.nvim', { tag = '0.1.0' })
Plug 'sainnhe/everforest'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'kdheepak/tabline.nvim'
Plug 'maxmx03/dracula.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'folke/tokyonight.nvim'
Plug '~/toms-plugin'
Plug 'navarasu/onedark.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'doums/darcula'
Plug 'briones-gabriel/darcula-solid.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'romainl/apprentice'
Plug ('daltonmenezes/aura-theme', { rtp = 'packages/neovim' })
Plug ('bluz71/vim-nightfly-colors', { as = 'nightfly' })
Plug 'mrjones2014/lighthaus.nvim'
Plug 'github/copilot.vim'
vim.call('plug#end');

vim.cmd('colorscheme dracula');
vim.cmd('set termguicolors');
vim.cmd('set statusline+=%F');
vim.cmd('set splitright');
vim.cmd('set cmdheight=1');

vim.api.nvim_command('set nowrap');
vim.g.mapleader = ";"

vim.opt.number = true;
vim.opt.relativenumber = true;
vim.opt.syntax = enable;
vim.opt.cursorline = true;
vim.opt.expandtab = true;
vim.opt.tabstop = 2;
vim.opt.shiftwidth = 2;
vim.opt.autoindent = true;
vim.opt.smartindent = true;
vim.wo.signcolumn = "yes";
vim.completopt = 'menu,menuone,noselect';

local builtin = require('telescope.builtin')
-- TELESCOPE HOTKEYS
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Tree
vim.keymap.set('n', '<leader>fn', '<cmd>NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<leader>fc', '<cmd>NvimTreeCollapse<CR>', {})

-- COMMANDS
vim.keymap.set('n', '<F3>', '<cmd>set hlsearch!<CR>', {})
vim.keymap.set('n', '<F4>', '<cmd>:set cmdheight=1<CR>', {})

-- LINE
vim.keymap.set('n', 'ª', '<cmd> :move -2<CR>', {})
vim.keymap.set('n', '√', '<cmd> :move +1<CR>', {})

-- WINDOW 
vim.keymap.set('n', '<C-l>', '<C-w>l', {});
vim.keymap.set('n', '<C-h>', '<C-w>h', {});

vim.keymap.set('n', '<F9>', '<C-w>10>', {});
vim.keymap.set('n', '<F10>', '<C-w>10<', {});

-- COPILOT
vim.keymap.set('n', '<C-e>', '<cmd><Plug>(copilot-next)<CR>', {});
vim.keymap.set('n', '<C-q>', '<cmd><Plug>(copilot-previous)<CR>', {});

require("mason-lspconfig").setup {
  ensure_installed = { 'tsserver' }
}

require'nvim-treesitter.configs'.setup {
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
}
require("nvim-tree").setup()

local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered("‚ï≠", "‚îÄ", "‚ïÆ", "‚îÇ", "‚ïØ", "‚îÄ", "‚ï∞", "‚îÇ"),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'cmp_tabnine' },
    }, {
      { name = 'buffer' },
    }),
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
 
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

 
  local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lsp_flags = {
    debounce_text_changes = 150,
  }

  require('lspconfig')['tsserver'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
  }
 
  require('lspconfig')['html'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
  }
 
  require('lspconfig')['tailwindcss'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
  }
  
   require('lspconfig')['phpactor'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
  }
 
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  require'lspconfig'.cssls.setup {
    capabilities = capabilities,
  }


require('telescope').setup{  defaults = { file_ignore_patterns = { "node_modules" }} }
require('mason').setup();

require("nvim-tree").setup({
  open_on_setup = true,
  sort_by = "case_sensitive",
     view = {
        relativenumber = true,
        width = 50,
      },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
        modified = false,
      },
    }
  },
  filters = {
    dotfiles = false,
  },
})

-- local tabnine = require('cmp_tabnine.config')
