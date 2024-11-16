EVO_VERSION="9.6"
ROOT_DIR="$HOME/evo"

cd $ROOT_DIR
source build/envsetup.sh
ccache -M 50G -F 0

# Ensure that "su" is removed (the patch doesn't apply using patch-applying script for some dumbfuck reason)
echo "----- Removing su from builds -----"
cd $ROOT_DIR/build/make
git am $ROOT_DIR/patches/0002-personal/platform_build/000*-remove-su-from-builds.patch
git am --abort # if the patch has already been aplied, abort the process

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
lunch treble_arm64_bgN_slim-userdebug
make systemimage -j$(nproc --all)
compress

echo "----- Building normal variant -----"
variant=""
cd $ROOT_DIR
lunch treble_arm64_bgN-userdebug
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
