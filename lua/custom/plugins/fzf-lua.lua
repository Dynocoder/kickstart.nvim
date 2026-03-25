return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local fzf = require 'fzf-lua'
    fzf.setup {
      winopts = {
        height = 0.85,
        width = 0.80,
        border = 'rounded',
        preview = {
          layout = 'horizontal',
          flip_columns = 120,
        },
      },
      fzf_opts = {
        ['--layout'] = 'reverse',
        ['--info'] = 'inline',
        ['--height'] = '100%',
        ['--pointer'] = '➤',
        ['--marker'] = '✓',
        ['--multi'] = '',
        ['--preview-window'] = 'right:60%',
      },
      files = {
        previewer = 'bat',
        formatter = 'path.filename_first',
        prompt = 'Files❯ ',
        git_icons = true,
        file_icons = true,
        color_icons = true,

        rg_opts = [[--color=never --hidden --files -g "!.git/*"]],
        hidden = true,
      },
      git = {
        files = {
          formatter = 'path.filename_first',
          prompt = 'GitFiles❯ ',
          cmd = 'git ls-files --exclude-standard',
          previewer = 'bat',
          git_icons = true,
          file_icons = true,
          color_icons = true,
        },
        status = {
          formatter = 'path.filename_first',
          prompt = 'GitStatus❯ ',
          cmd = 'git -c color.status=false status --porcelain',
          previewer = 'git_diff',
        },
        commits = {
          prompt = 'Commits❯ ',
          cmd = 'git log --color=always --pretty=format:"%C(auto)%h %s %d [%an]"',
          previewer = 'git_commit',
        },
        bcommits = {
          prompt = 'BCommits❯ ',
          cmd = [[git log --color --pretty=format:"%C(yellow)%h%Creset ]] .. [[%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset" {file}]],
          preview = 'git show --color {1} -- {file}',
          cwd_header = true,
        },
        blame = {
          prompt = 'Blame❯ ',
          cwd_header = true,
          cmd = [[git blame --date=short --color-lines {file}]],
          preview = 'git show --color {1} -- {file}',
        },
      },
      keymap = {
        builtin = {
          ['<Esc>'] = 'toggle-focus',
          ['<C-n>'] = 'down',
          ['<C-p>'] = 'up',
          ['<C-j>'] = 'preview-page-down',
          ['<C-k>'] = 'preview-page-up',
          -- toggle preview
          ['<C-q>'] = 'toggle-preview',
        },
        fzf = {
          ['ctrl-j'] = 'preview-page-down',
          ['ctrl-k'] = 'preview-page-up',
        },
      },
    }

    local config = require 'fzf-lua.config'
    local actions = require('trouble.sources.fzf').actions
    config.defaults.actions.files['ctrl-t'] = actions.open

    -- optionally replace vim.ui.select
    vim.ui.select = fzf.fzf_select

    -- Now replicate your Telescope mappings:
    vim.keymap.set('n', '<leader><leader>', fzf.git_files, { desc = 'Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>svh', fzf.help_tags, { desc = '[S]earch [N]eovim [H]elp' })
    vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>/', fzf.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sG', fzf.live_grep_native, { desc = '[S]earch [G]rep (Native)' })
    vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = '[S] Find existing [B]uffers' })

    -- Optional extras
    vim.keymap.set('n', '<leader>gs', fzf.git_status, { desc = '[S]earch [G]it Status' })
    vim.keymap.set('n', '<leader>sgc', fzf.git_commits, { desc = '[S]earch [G]it [C]ommits' })
    vim.keymap.set('n', '<leader>sh', fzf.git_bcommits, { desc = '[S]earch [H]istory' })

    -- Custom blame picker with vertical layout override
    vim.keymap.set('n', '<leader>sb', fzf.git_blame, { desc = '[S]earch [B]lame (vertical view)' })

    vim.keymap.set('n', '<leader>c/', function()
      fzf.grep_curbuf { prompt_title = 'Grep in Current Buffer' }
    end, { desc = 'Fuzzily search in [c]urrent buffer [/] ' })

    vim.keymap.set('n', '<leader>s/', function()
      fzf.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sn', function()
      fzf.files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
