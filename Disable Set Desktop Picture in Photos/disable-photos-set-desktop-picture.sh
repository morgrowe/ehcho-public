#!/bin/bash
# Quick script to disable the "Set Desktop Picture" feature within Photos.
# Design to work with a LaunchDaemon
#
#	Last updated: 5th October 2015

whoami=$(/usr/bin/whoami)
photosAppVersion=$(/usr/bin/defaults read /Applications/Photos.app/Contents/version.plist CFBundleShortVersionString)

photosContainer=/Users/$whoami/Library/Containers/com.apple.Photos
photoDesktopYos=$photosContainer/Data/Library/Caches/Photos\ Desktop
photoDesktopElCap=$photosContainer/Data/Library/Application\ Support/Photos\ Desktop
photosDesktopCheck=$photosContainer/.DisabledSetDesktopPicture

chmod=/bin/chmod
mkdir=/bin/mkdir
touch=/usr/bin/touch

# Maybe needs a bit of a delay
/bin/sleep 3

# Has this script run before? If no, continue, if yes, exit
if [ ! -f "$photosDesktopCheck" ]; then
	
	# What version of photos is installed? El Cap and Yosemite are different
	if [[ "$photosAppVersion" == "1.2"* ]]; then
		
		photoDesktop=$photoDesktopElCap
	else

		photoDesktop=$photoDesktopYos

	fi

	# Has Photos run yet?
	if [ -d "$photosContainer" ]; then

		# Has the container for the wallpaper graphics been created?
		if [ -d "$photoDesktop" ]; then

			# If so, nuke it
			$chmod 000 "$photoDesktop"
			$touch "$photosDesktopCheck"

		else

			# If not, make it and then nuke it
			$mkdir "$photoDesktop"
			$chmod 000 "$photoDesktop"
			$touch "$photosDesktopCheck"

		fi

	fi

fi

exit 0