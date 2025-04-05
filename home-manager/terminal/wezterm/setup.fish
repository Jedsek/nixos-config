sudo dnf copr enable -y stefan-maassen/wezterm
sudo dnf install -y wezterm

mkdir $nud/.config/wezterm/
mv -f $terminals_dir/wezterm/keybinds.lua $nud/.config/wezterm/
mv -f $terminals_dir/wezterm/wezterm.lua $nud/.config/wezterm/