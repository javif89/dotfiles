function intake() {
	while read folder; do
		echo "Intaking changes from $folder"
		mkdir -p "$folder"
		cp -r "$HOME/.config/$folder/." "./$folder"
	done < tracked.txt

	echo "Copying bash profile"
	cp "$HOME/.bash_profile" ./.bash_profile
	cp "$HOME/.bashrc" ./.bashrc
}

function put() {
	while read folder; do
		echo "Putting changes from $folder"
		cp -r "./$folder" "$HOME/.config/$folder"
	done < tracked.txt

	echo "Putting bash profile"
	cp ./.bash_profile "$HOME/.bash_profile"
	cp ./.bashrc "$HOME/.bashrc"
}

function pushupdate() {
	git add .
	git commit -m "Update"
	git push
}

$1
