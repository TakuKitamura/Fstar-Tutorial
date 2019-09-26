
function! VerifyFstar()
  let currentFileFullPath = expand("%:p")
  echo system ('fstarHelper -v ' . currentFileFullPath)
endfunction

function! ExecFstar()
  let currentFileFullPath = expand("%:p")
  echo system ('fstarHelper -e ' . currentFileFullPath)
endfunction

function! VerifyLowStar()
  let currentFileFullPath = expand("%:p")
  echo system ('fstarHelper -vl ' . currentFileFullPath)
endfunction


function! ExecLowStar()
  let currentFileFullPath = expand("%:p")
  echo system ('fstarHelper -el ' . currentFileFullPath)

endfunction

command! VerifyFstar call VerifyFstar()
command! ExecFstar call ExecFstar()
command! VerifyLowStar call VerifyLowStar()
command! ExecLowStar call ExecLowStar()