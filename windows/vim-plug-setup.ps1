$nvimPath = '~\AppData\Local\nvim\autoload'
If (test-path $nvimPath) {Remove-Item $nvimPath -recurse}
md $nvimPath

$vimPath = '~\vimfiles\autoload'
If (test-path $vimPath) {Remove-Item $vimPath -recurse}
md $vimPath

$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\AppData\Local\nvim\autoload\plug.vim"
  )
)
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\vimfiles\autoload\plug.vim"
  )
)
