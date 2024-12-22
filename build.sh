echo "  _____            _       _   _              __  __ "
echo " | ____|_   _____ | |_   _| |_(_) ___  _ __   \ \/ / "
echo " |  _| \ \ / / _ \| | | | | __| |/ _ \| '_ \   \  /  "
echo " | |___ \ V / (_) | | |_| | |_| | (_) | | | |  /  \  "
echo " |_____| \_/ \___/|_|\__,_|\__|_|\___/|_| |_| /_/\_\ "
echo "                                                     "

ROOT_DIR="$(pwd)"
cd $ROOT_DIR

EVO_VERSION="$(awk '/EVO_VERSION := / {print $3}' $ROOT_DIR/vendor/lineage/config/version.mk)"
ANDROID_BUILD_VERSION="ap4a"

echo "Building Evolution X version $EVO_VERSION ($ANDROID_BUILD_VERSION)"
echo "---------------------------"

source build/envsetup.sh
ccache -M 50G -F 0

START_TIME=$(date +%s)
RELEASE_DATE=$(date +%Y%m%d)
RELEASE_DATE_FMT=$(date +%Y-%m-%d)

cd ~/evo

compress() {
    echo "----- Compressing the variant -----"
    cd $ROOT_DIR/out/target/product/tdgsi_arm64_ab
    xz -9 -T0 -v -z system.img
    mv system.img.xz $HOME/Downloads/evolution_arm64_bgN$variant-$EVO_VERSION-unofficial-$RELEASE_DATE.img.xz
}

echo "----- Building slim variant -----"
variant="_slim"
cd $ROOT_DIR
lunch treble_arm64_bgN_slim-$ANDROID_BUILD_VERSION-userdebug
make systemimage -j$(nproc --all)
compress

echo "----- Building normal variant -----"
variant=""
cd $ROOT_DIR
lunch treble_arm64_bgN-$ANDROID_BUILD_VERSION-userdebug
make systemimage -j$(nproc --all)
compress

echo "----- Done! -----"
echo "Start time: $START_TIME"
slim_size=$(wc -c < $HOME/Downloads/evolution_arm64_bgN_slim-$EVO_VERSION-unofficial-$RELEASE_DATE.img.xz)
echo "Slim size: $slim_size"
normal_size=$(wc -c < $HOME/Downloads/evolution_arm64_bgN-$EVO_VERSION-unofficial-$RELEASE_DATE.img.xz)
echo "Normal size: $normal_size"

echo "----- OTA -----"
echo "{
    \"version\": \"$RELEASE_DATE_FMT (Evolution X $EVO_VERSION)\",
    \"date\": \"$START_TIME\",
    \"variants\": [
        {
            \"name\": \"treble_arm64_bgN\",
            \"size\": \"$normal_size\",
            \"url\": \"https://github.com/mytja/treble_evo/releases/download/$RELEASE_DATE/evolution_arm64_bgN-$EVO_VERSION-unofficial-$RELEASE_DATE.img.xz\"
        },
        {
            \"name\": \"treble_arm64_bgN_slim\",
            \"size\": \"$slim_size\",
            \"url\": \"https://github.com/mytja/treble_evo/releases/download/$RELEASE_DATE/evolution_arm64_bgN_slim-$EVO_VERSION-unofficial-$RELEASE_DATE.img.xz\"
        }
    ]
}"
