#!/bin/bash

# Neovimの設定ディレクトリパス
NVIM_CONFIG_DIR="$HOME/.config/nvim"
# 仮想環境のパス
VENV_PATH="$NVIM_CONFIG_DIR/.venv"

echo "Neovim用のPython仮想環境をセットアップします..."
echo "場所: $VENV_PATH"

# 仮想環境が存在しない場合のみ作成
if [ ! -d "$VENV_PATH" ]; then
  echo "仮想環境を作成しています..."
  python3 -m venv "$VENV_PATH"
  if [ $? -ne 0 ]; then
    echo "エラー: 仮想環境の作成に失敗しました。"
    exit 1
  fi
else
  echo "仮想環境は既に存在します。"
fi

# pynvimをインストールまたはアップグレード
echo "pynvimをインストール/アップグレードします..."
"$VENV_PATH/bin/pip" install --upgrade pynvim

if [ $? -ne 0 ]; then
  echo "エラー: pynvimのインストールに失敗しました。"
  exit 1
fi

"$VENV_PATH/bin/pip" install --upgrade Send2Trash

echo "✅ セットアップが正常に完了しました！"
echo "NeovimのPythonパス: $VENV_PATH/bin/python"
