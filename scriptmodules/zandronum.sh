#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="zandronum"
rp_module_desc="Zandronum - Enhanced multiplayer port of the official DOOM source"
rp_module_licence="Sleepycat https://bitbucket.org/Torr_Samaho/zandronum/raw/c11f78a5b0286096da1bad5d40cbd54ac71f675d/LICENSE.txt"
rp_module_help="Add your own iwad and pwads to $romdir/ports/doom"
rp_module_section="exp"
rp_module_flags=""

function depends_zandronum() {
    getDepends cmake libsdl-sound1.2-dev libsdl1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev  libsdl-net1.2-dev libgtk2.0-dev libfluidsynth-dev libmpg123-dev libsndfile1-dev libgme-dev libglew-dev
}

function sources_zandronum() {
    hg clone https://bitbucket.org/ptitSeb/zandronum zandronum.mod
}

function build_zandronum() {
    cd zandronum.mod
    cmake .
    make
}

function install_zandronum() {
    md_ret_files=(
       'zandronum.mod/zandronum'
       'zandronum.mod/zandronum.pk3'
    )
}

function game_data_zandronum() {
    if [[ ! -f "$romdir/ports/doom/doom1.wad" ]]; then
        wget -nv -O "$romdir/ports/doom/doom1.wad" "$__archive_url/doom1.wad"
        chown $user:$user "$romdir/ports/doom/doom1.wad"
    fi
}

function configure_zandronum() {
    addPort "$md_id" "doom" "Doom" "DOOMWADDIR=$romdir/ports/doom $md_inst/zandronum -iwad %ROM%" "$romdir/ports/doom/doom1.wad"

    mkRomDir "ports/doom"

    mkUserDir "$home/.zandronum"
    moveConfigDir "$home/.config/zandronum" "$md_conf_root/doom"

    [[ "$md_mode" == "install" ]] && game_data_zandronum
}
