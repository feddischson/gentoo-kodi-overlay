# Copyright 2015 Daniel 'herrnst' Scheller, Team Kodi
# Distributed under the terms of the GNU General Public License v2
# $Id$

# @ECLASS: kodi-addon.eclass
# @MAINTAINER:
# nst@kodi.tv
# @BLURB: Helper for correct building and (importantly) installing Kodi addon packages.
# @DESCRIPTION:
# Provides a src_configure function for correct CMake configuration

inherit multilib cmake-utils

case "${EAPI:-0}" in
	4|5)
		EXPORT_FUNCTIONS src_prepare src_configure
		;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

# @FUNCTION: kodi-addon_src_prepare
# @DESCRIPTION:
# Prepare Kodi addon sources prior to configure
kodi-addon_src_prepare() {

	cmake-utils_src_prepare

	einfo Fixing up reference from platform to p8-platform in find_package\(\) calls in CMakeLists.txt...

	[[ -e ${S}/CMakeLists.txt ]] && \
		sed -i 's/find_package(platform REQUIRED)/find_package(p8-platform REQUIRED)/' ${S}/CMakeLists.txt
}

# @FUNCTION: kodi-addon_src_configure
# @DESCRIPTION:
# Configure handling for Kodi addons
kodi-addon_src_configure() {

	mycmakeargs+=(
		-DCMAKE_INSTALL_LIBDIR=$(get_libdir)/kodi
	)

	cmake-utils_src_configure
}
