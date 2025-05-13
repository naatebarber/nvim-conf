#!/bin/bash
echo "Installing rust analyzer via rustup"
rustup component add rust-analyzer
echo "Installing typescript-language-server via npm (sudo)"
sudo npm i -g typescript typescript-language-server
echo "Installing pyright via npm"
sudo npm i -g pyright
echo "Installing ripgrep"
cargo install ripgrep
echo "Installing stylua"
cargo install stylua
