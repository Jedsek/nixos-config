sudo dnf copr enable -y flekz/helix-git
sudo dnf install -y helix-git

rm $editors_dir/helix/*.fish
mv $editors_dir/helix $nud/.config/