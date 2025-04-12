TARGET_GAPPS_ARCH := arm64
include build/make/target/product/aosp_arm64.mk
$(call inherit-product, device/phh/treble/base.mk)
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
$(call inherit-product, device/lineage/sepolicy/common/sepolicy.mk)
$(call inherit-product, vendor/lineage/config/BoardConfigSoong.mk)

# Overwrite the inherited "emulator" characteristics
PRODUCT_CHARACTERISTICS := device

PRODUCT_DEVICE := tdgsi_arm64_ab
PRODUCT_BRAND := google
PRODUCT_SYSTEM_BRAND := google
PRODUCT_MANUFACTURER := google
PRODUCT_SYSTEM_MANUFACTURER := google

WITH_ADB_INSECURE := true
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_NO_KERNEL_IMAGE := true
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false
TARGET_BOOT_ANIMATION_RES := 1080
override TARGET_SUPPORTS_64_BIT_APPS := true # To enable Face Unlock. Override seems to be required.
override SELINUX_IGNORE_NEVERALLOWS := true
override BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
override BOARD_EXT4_SHARE_DUP_BLOCKS := true

TARGET_INCLUDE_ACCORD := false

# OTA
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.system.ota.json_url=https://raw.githubusercontent.com/mytja/treble_evo/vic/ota.json

# SELinux
TARGET_USES_PREBUILT_VENDOR_SEPOLICY := true

# Evolution X
EVO_BUILD_TYPE := Unofficial

# Evolution X overlays
PRODUCT_PACKAGES += \
  SettingsResGsi

# Additional packages
PRODUCT_PACKAGES += \
  OpenEUICC
