function intake() {
	while read folder; do
		echo "Intaking changes from $folder"
		mkdir -p "$folder"
		cp -r "$HOME/.config/$folder/." "./$folder"
	done < tracked.txt
}

function put() {
	while read folder; do
		echo "Putting changes from $folder"
		cp -r "./$folder" "$HOME/.config/$folder"
	done < tracked.txt
}

function pushupdate() {
	git add .
	git commit -m "Update"
	git push
}

$1
