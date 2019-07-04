#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="doomseeker"
rp_module_desc="Doomseeker - Doomseeker is a cross-platform server browser for Doom. The goal of Doomseeker is to provide a smooth, consistant experience for Doom players regardless of port or platform. Doomseeker provides support for Chocolate Doom, Odamex, Sonic Robo Blast 2, Turok 2 Remaster, and Zandronum. With its plugin system support for even more can be added."
rp_module_licence="GPL2 https://bitbucket.org/Doomseeker/doomseeker/raw/d7dfe48e5b26de8509708f4ec535eeee9c7251d7/LICENSE"
rp_module_help="Notice. Doomseeker works only in Desktop mode. To use Doomseeker with any of the following source ports: Chocolate Doom, Odamex, Sonic Robo Blast 2, Turok 2 Remaster, and Zandronum, you must configure Doomseeker in settings to find it's client and configure wad location to be $romdir/ports/doom/."
rp_module_section="exp"
rp_module_flags=""

function depends_doomseeker() {
    getDepends g++ cmake libqt4-dev mercurial zlib1g-dev libbz2-dev qtmultimedia5-dev
}

function sources_doomseeker() {
    hg clone https://bitbucket.org/Doomseeker/doomseeker doomseeker
}

function build_doomseeker() {
    cd doomseeker
    cmake .
    make
    sudo make install
}

function install_doomseeker() {
    md_ret_files=(
       'doomseeker/doomseeker'
       'doomseeker/libwadseeker.so'
       'doomseeker/libwadseeker.so.2'
       'doomseeker/libwadseeker.so.2.0'
    )
}

function configure_doomseeker() {
    addPort "$md_id" "doomseeker" "Doomseeker" "$md_inst/doomseeker"

    moveConfigDir "$home/.config/doomseeker" "$md_conf_root/doomseeker"
}
