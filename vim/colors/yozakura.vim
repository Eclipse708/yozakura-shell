" Yozakura (夜桜) — dark sakura colorscheme for Vim, 2026-10-05.
" Requires 'termguicolors' (set in ~/.vimrc). Matches the zsh / tmux / Windows Terminal palette.
"
"   bg #0b0a0d  surface #141218  raised #1a171c  rule #26222b  ash #4a3f4a
"   fg #d8cfd6  sakura #e8a4b8  plum #b58bb3  gold #d4a373  moon #8a9bc4
"   moss #8fa882  rose #c9697f  teal #8fb3b0  mist #8a7d8a  dusk #5c525e

set background=dark
highlight clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'yozakura'

function! s:hi(group, fg, bg, attr) abort
  let l:cmd = 'highlight ' . a:group
  let l:cmd .= ' guifg=' . (a:fg   ==# '' ? 'NONE' : a:fg)
  let l:cmd .= ' guibg=' . (a:bg   ==# '' ? 'NONE' : a:bg)
  let l:cmd .= ' gui='   . (a:attr ==# '' ? 'NONE' : a:attr)
  let l:cmd .= ' cterm=' . (a:attr ==# '' ? 'NONE' : a:attr)
  execute l:cmd
endfunction

let s:bg      = '#0b0a0d'
let s:surface = '#141218'
let s:raised  = '#1a171c'
let s:rule    = '#26222b'
let s:select  = '#3b2a35'
let s:ash     = '#4a3f4a'
let s:dusk    = '#5c525e'
let s:mist    = '#8a7d8a'
let s:fg      = '#d8cfd6'
let s:bright  = '#f2e9ef'
let s:sakura  = '#e8a4b8'
let s:plum    = '#b58bb3'
let s:gold    = '#d4a373'
let s:pale    = '#e8c09a'
let s:moon    = '#8a9bc4'
let s:moss    = '#8fa882'
let s:rose    = '#c9697f'
let s:teal    = '#8fb3b0'

" ---- editor chrome --------------------------------------------------------------------------
call s:hi('Normal',        s:fg,      s:bg,      '')
call s:hi('NonText',       s:ash,     '',        '')
call s:hi('SpecialKey',    s:ash,     '',        '')
call s:hi('EndOfBuffer',   s:rule,    '',        '')
call s:hi('LineNr',        s:dusk,    '',        '')
call s:hi('CursorLineNr',  s:sakura,  '',        'bold')
call s:hi('CursorLine',    '',        s:surface, '')
call s:hi('CursorColumn',  '',        s:surface, '')
call s:hi('ColorColumn',   '',        s:surface, '')
call s:hi('SignColumn',    s:dusk,    s:bg,      '')
call s:hi('FoldColumn',    s:dusk,    s:bg,      '')
call s:hi('Folded',        s:mist,    s:surface, 'italic')
call s:hi('VertSplit',     s:rule,    s:bg,      '')
call s:hi('StatusLine',    s:fg,      s:raised,  '')
call s:hi('StatusLineNC',  s:dusk,    s:surface, '')
call s:hi('TabLine',       s:dusk,    s:surface, '')
call s:hi('TabLineFill',   s:dusk,    s:surface, '')
call s:hi('TabLineSel',    s:bg,      s:sakura,  'bold')
call s:hi('WildMenu',      s:bg,      s:sakura,  'bold')
call s:hi('Pmenu',         s:fg,      s:raised,  '')
call s:hi('PmenuSel',      s:bg,      s:sakura,  'bold')
call s:hi('PmenuSbar',     '',        s:rule,    '')
call s:hi('PmenuThumb',    '',        s:ash,     '')
call s:hi('Visual',        '',        s:select,  '')
call s:hi('VisualNOS',     '',        s:select,  '')
call s:hi('Search',        s:bg,      s:gold,    '')
call s:hi('IncSearch',     s:bg,      s:sakura,  'bold')
call s:hi('CurSearch',     s:bg,      s:sakura,  'bold')
call s:hi('MatchParen',    s:sakura,  s:select,  'bold')
call s:hi('Cursor',        s:bg,      s:sakura,  '')
call s:hi('lCursor',       s:bg,      s:sakura,  '')
call s:hi('Conceal',       s:dusk,    '',        '')
call s:hi('Directory',     s:moon,    '',        'bold')
call s:hi('Title',         s:sakura,  '',        'bold')
call s:hi('ModeMsg',       s:plum,    '',        'bold')
call s:hi('MoreMsg',       s:moss,    '',        '')
call s:hi('Question',      s:moss,    '',        '')
call s:hi('ErrorMsg',      s:rose,    '',        'bold')
call s:hi('WarningMsg',    s:gold,    '',        '')
call s:hi('QuickFixLine',  '',        s:select,  '')
call s:hi('SpellBad',      s:rose,    '',        'undercurl')
call s:hi('SpellCap',      s:moon,    '',        'undercurl')
call s:hi('SpellLocal',    s:teal,    '',        'undercurl')
call s:hi('SpellRare',     s:plum,    '',        'undercurl')

" ---- diff -----------------------------------------------------------------------------------
call s:hi('DiffAdd',       s:moss,    '#15201a', '')
call s:hi('DiffChange',    '',        '#1c1a22', '')
call s:hi('DiffDelete',    s:rose,    '#241418', '')
call s:hi('DiffText',      s:gold,    '#2a2318', 'bold')
call s:hi('diffAdded',     s:moss,    '',        '')
call s:hi('diffRemoved',   s:rose,    '',        '')
call s:hi('diffChanged',   s:gold,    '',        '')
call s:hi('diffFile',      s:plum,    '',        'bold')
call s:hi('diffLine',      s:moon,    '',        '')

" ---- syntax ---------------------------------------------------------------------------------
call s:hi('Comment',        s:dusk,   '',  'italic')
call s:hi('SpecialComment', s:mist,   '',  'italic')
call s:hi('Todo',           s:gold,   '',  'bold')
call s:hi('Constant',       s:pale,   '',  '')
call s:hi('String',         s:gold,   '',  '')
call s:hi('Character',      s:gold,   '',  '')
call s:hi('Number',         s:pale,   '',  '')
call s:hi('Boolean',        s:pale,   '',  '')
call s:hi('Float',          s:pale,   '',  '')
call s:hi('Identifier',     s:fg,     '',  '')
call s:hi('Function',       s:sakura, '',  '')
call s:hi('Statement',      s:plum,   '',  '')
call s:hi('Conditional',    s:plum,   '',  '')
call s:hi('Repeat',         s:plum,   '',  '')
call s:hi('Label',          s:plum,   '',  '')
call s:hi('Operator',       s:mist,   '',  '')
call s:hi('Keyword',        s:plum,   '',  '')
call s:hi('Exception',      s:rose,   '',  '')
call s:hi('PreProc',        s:teal,   '',  '')
call s:hi('Include',        s:teal,   '',  '')
call s:hi('Define',         s:teal,   '',  '')
call s:hi('Macro',          s:teal,   '',  '')
call s:hi('PreCondit',      s:teal,   '',  '')
call s:hi('Type',           s:moon,   '',  '')
call s:hi('StorageClass',   s:moon,   '',  '')
call s:hi('Structure',      s:moon,   '',  '')
call s:hi('Typedef',        s:moon,   '',  '')
call s:hi('Special',        s:teal,   '',  '')
call s:hi('SpecialChar',    s:teal,   '',  '')
call s:hi('Tag',            s:plum,   '',  '')
call s:hi('Delimiter',      s:mist,   '',  '')
call s:hi('Debug',          s:rose,   '',  '')
call s:hi('Underlined',     s:moon,   '',  'underline')
call s:hi('Ignore',         s:dusk,   '',  '')
call s:hi('Error',          s:rose,   '',  'bold')

" ---- a few filetypes ------------------------------------------------------------------------
call s:hi('markdownH1',          s:sakura, '', 'bold')
call s:hi('markdownH2',          s:sakura, '', 'bold')
call s:hi('markdownH3',          s:plum,   '', 'bold')
call s:hi('markdownCode',        s:teal,   '', '')
call s:hi('markdownCodeBlock',   s:teal,   '', '')
call s:hi('markdownUrl',         s:moon,   '', 'underline')
call s:hi('markdownLinkText',    s:moon,   '', '')
call s:hi('markdownListMarker',  s:gold,   '', '')
call s:hi('gitcommitSummary',    s:fg,     '', '')
call s:hi('gitcommitOverflow',   s:rose,   '', '')
call s:hi('gitcommitBranch',     s:plum,   '', 'bold')
call s:hi('gitcommitSelectedFile',  s:moss, '', '')
call s:hi('gitcommitUntrackedFile', s:moon, '', '')
call s:hi('gitcommitDiscardedFile', s:gold, '', '')
call s:hi('shDerefSimple',       s:teal,   '', '')
call s:hi('shDerefVar',          s:teal,   '', '')
call s:hi('shQuote',             s:gold,   '', '')
call s:hi('shOption',            s:moon,   '', '')
call s:hi('cStorageClass',       s:moon,   '', '')
call s:hi('cFormat',             s:teal,   '', '')
call s:hi('pythonBuiltin',       s:moon,   '', '')
call s:hi('pythonDecorator',     s:sakura, '', '')
call s:hi('pythonDecoratorName', s:sakura, '', '')
call s:hi('jsonKeyword',         s:moon,   '', '')
call s:hi('yamlKey',             s:moon,   '', '')
call s:hi('javaAnnotation',      s:sakura, '', '')
call s:hi('kotlinAnnotation',    s:sakura, '', '')

delfunction s:hi
