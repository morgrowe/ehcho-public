#!/bin/bash
# Quick script to disable the "Set Desktop Picture" feature within Photos.
# Design to work with a LaunchDaemon
#
#	Last updated: 5th October 2015

whoami=$(whoami)
photosContainer=/Users/$whoami/Library/Containers/com.apple.Photos
photoDesktop=$photosContainer/Data/Library/Caches/Photos\ Desktop
photosDesktopCheck=$photosContainer/.DisabledSetDesktopPicture

chmod=/bin/chmod
mkdir=/bin/mkdir
touch=/usr/bin/touch

# Maybe needs a bit of a delay
/bin/sleep 3

# Has this script run before? If no, continue, if yes, exit
if [ ! -f "$photosDesktopCheck" ]; then

	# Has the application created its container yet? If yes, move on
	if [ -d "$photosContainer" ]; then

		# Is there already a Photos Desktop folder? If yes, change its permissions,
		# if no, make it and change its permissions
		if [ -d "$photoDesktop" ]; then

			# Deny all access
			$chmod 000 "$photoDesktop"

			# Create marker
			$touch "$photosDesktopCheck"


		else

			# Make the directory and deny all access
			$mkdir "$photoDesktop"
			$chmod 000 "$photoDesktop"

			# Create marker
			$touch "$photosDesktopCheck"

		fi

	fi

fi

exit 0