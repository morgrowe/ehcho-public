#!/bin/bash
# Bypass Chrome's first run dialog window

if [ "$(/usr/bin/id -u)" != 0 ]; then

	echo "This script must be run by root."
	exit 0

fi

for userTemplatePath in "/System/Library/User Template"/*; do

	#	Make directories for default settings
	/bin/mkdir -p "${userTemplatePath}"/Library/Application\ Support/Google/Chrome/Default

	#	Add First Run and Preferences files
	/usr/bin/touch "${userTemplatePath}"/Library/Application\ Support/Google/Chrome/First\ Run
	/usr/bin/touch "${userTemplatePath}"/Library/Application\ Support/Google/Chrome/Default/Preferences

	#	Permissions check
	/usr/sbin/chown -R root:wheel "${userTemplatePath}"/Library/Application\ Support/Google
	/bin/chmod -R 700 "${userTemplatePath}"/Library/Application\ Support/Google

done

exit 0