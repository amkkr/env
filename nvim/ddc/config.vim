call ddc#custom#patch_global('ui', ['native'])
call ddc#custom#patch_global('ui', ['pum'])
call ddc#custom#patch_global('sources', ['around', 'nvim-lsp'])

call ddc#custom#patch_global('sourceOptions', #{
    \   around: #{ mark: 'A' },
    \   nvim-lsp: #{
    \       mark: 'lsp',
    \   },
    \   _: #{
    \     matchers: ['matcher_head'],
    \     sorters: ['sorter_rank'],
    \     converters: ['converter_remove_overlap']
    \   }   
\})

call ddc#custom#patch_global('sourceParams', #{
    \   around: #{ maxSize: 500 },
    \   nvim-lsp: #{
    \       snippetEngine: denops#callback#register({
    \           body -> vsnip#anonymous(body)
    \       }),
    \       enableResolveItem: v:true,
    \       enableAdditionalTextEdit: v:true,
    \       confirmBehavior: 'replace',
    \   }
\})

call ddc#enable()

inoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

