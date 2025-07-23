# Neovimの設定ディレクトリパス
$NvimConfigDir = "$HOME\.config\nvim"
# 仮想環境のパス
$VenvPath = "$NvimConfigDir\.venv"

Write-Host "Neovim用のPython仮想環境をセットアップします..."
Write-Host "場所: $VenvPath"

# 仮想環境が存在しない場合のみ作成
if (-not (Test-Path $VenvPath)) {
  Write-Host "仮想環境を作成しています..."
  python -m venv $VenvPath
  if ($LASTEXITCODE -ne 0) {
    Write-Error "エラー: 仮想環境の作成に失敗しました。"
    exit 1
  }
} else {
  Write-Host "仮想環境は既に存在します。"
}

# pynvimをインストールまたはアップグレード
Write-Host "pynvimをインストール/アップグレードします..."
& "$VenvPath\Scripts\pip.exe" install --upgrade pynvim

if ($LASTEXITCODE -ne 0) {
  Write-Error "エラー: pynvimのインストールに失敗しました。"
  exit 1
}

Write-Host "✅ セットアップが正常に完了しました！" -ForegroundColor Green
Write-Host "NeovimのPythonパス: $VenvPath\Scripts\python.exe"
