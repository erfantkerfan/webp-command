#!/bin/bash
shopt -s extglob
array=( /var/www/laravel/public/img/teachers /var/www/laravel/public/img/slider /var/www/laravel/public/img/news )
for dir_upload in "${array[@]}"
do
	cd $dir_upload
	for f in $dir_upload $dir_upload/* $dir_upload/*/*;
	do
		if [ -d ${f} ]; then
		cd $f;
		find . -type f -size 0 -delete
		for i in *.jpg *.png *.jpeg; do
			if [ -f "$i" ]; then
				if [ -f "${i%.*}.webp" ]; then
					:
				else
					echo "$f/${i%.*}" ;
					cwebp -quiet -mt -m 6 -q 80 -sharp_yuv -alpha_filter best -pass 10 -segments 4 -af "$i" -o "${i%.*}.webp"
				fi
			fi
		done;
		fi
	done;
	find . -type f -iname \*.jpg -delete
	find . -type f -iname \*.png -delete
	find . -type f -iname \*.jpeg -delete
	echo "finished";
done
