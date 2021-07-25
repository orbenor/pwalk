#!/bin/bash
#ls -d /gpfs/units/proteomics/Projects/*/ | sort| tr "\n" "\0" | xargs -0 -I % (du -sm ) #; stat --format ':%.19y,%n')
#ls -d /gpfs/units/proteomics/Projects/*/ | sort| tr "\n" "\0" | parallel 'du -sm {} ; echo {}'
#ls -d /gpfs/units/proteomics/Projects/*/ | sort| tr "\n" "\0" | xargs -0 du -sm  
#stat --format ':%.19y,%n' {} '
#for d in /gpfs/units/proteomics/Projects/*/; do
#	  du -sm "$d" ; find "$d" -print0 -exec stat --printf='%y,%n' {} \; | sort -nr | cut -d: -f2- | sed -e 1b -e '$!d' #| paste -s -d ',' 
#done
#
# 1  - inode
# 2  - parent-inode
# 3  - directory-depth
# 4  - "filename"
# 5  - "fileExtension"
# 6  - UID
# 7  - GID
# 8  - st_size
# 9  - st_dev
# 10 - st_blocks
# 11 - st_nlink
# 12 - "st_mode"
# 13 - st_atime
# 14 - st_mtime
# 15 - st_ctime
# 16 - pw_fcount
# 17 - pw_dirsum


for d in /gpfs/units/proteomics/Projects/*/; do
	((printf "$d,";du -sm "$d" | awk '{print $1/1024}';find "$d" -name "*" -type f -exec stat --format '%y' {} \; | cut -d- -f 1 | sort -n | uniq| sed -n '1p;$p')| tr '\n' ',' | tr '\n' ' ')|sed 's/.$//'; echo "" &

	# echo $d
#	(du -sm "$d" ;find "$d" -name ".*" -not -name ".*" -type f -print0 |xargs -0 stat --format ':%y %n' | sort -nr | cut -d: -f2- | sed -e 1b -e '$!d')| paste -s -d ',' 

	#du -BG "$d" &
	#du -sm	
done


# cat /it/data-Reduction/proteomics/6-Jul-2021-proteomics-report-date.csv | awk -F"," -v OFS=","# i;{print $4,$8,strftime("%Y",$13)}' > /it/data-Reduction/proteomics/atime-proteomics-report.csv
