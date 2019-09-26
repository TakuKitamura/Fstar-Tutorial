
function! VerifiedFstar()
  let currentFileName = expand('%:t')
  echo system ('/Users/kitamurataku/work/learnFstar/vim_setup.sh -verifiedFstar' . currentFileName)
endfunction

function! ExecFstar()
  let fileFullPath = expand('%:p:h')
  let fileName = expand('%:r')
  echo system ('/Users/kitamurataku/work/learnFstar/vim_setup.sh ' . fileFullPath . ' ' . fileName)
endfunction

command! VerifiedFstar call VerifiedFstar()
command! ExecFstar call ExecFstar()
