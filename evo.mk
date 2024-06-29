$(call inherit-product, device/phh/treble/lineage.mk)
$(call inherit-product, vendor/lineage/config/BoardConfigSoong.mk)

TARGET_NO_KERNEL_OVERRIDE := true
TARGET_NO_KERNEL_IMAGE := true
TARGET_BOOT_ANIMATION_RES := 1080
BOARD_EXT4_SHARE_DUP_BLOCKS := true
BUILD_BROKEN_DUP_RULES := true
