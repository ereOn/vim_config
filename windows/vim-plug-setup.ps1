$path = '~\AppData\Local\nvim\autoload'
If (test-path $path) {Remove-Item $path -recurse}
md $path
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile(
  $uri,
  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
    "~\AppData\Local\nvim\autoload\plug.vim"
  )
)

$pluginsPath = '~\AppData\Local\nvim\plugged'
If (-Not (test-path $pluginsPath)) {md $pluginsPath}
