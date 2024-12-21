$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
$(call inherit-product, vendor/lineage/config/BoardConfigSoong.mk)
$(call inherit-product, device/lineage/sepolicy/common/sepolicy.mk)

PRODUCT_DEVICE := evolution_arm64_bgN
PRODUCT_BRAND := google
PRODUCT_SYSTEM_BRAND := google
PRODUCT_MANUFACTURER := google
PRODUCT_SYSTEM_MANUFACTURER := google
PRODUCT_MODEL := Evolution X GSI

WITH_ADB_INSECURE := true
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_NO_KERNEL_IMAGE := true
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false
TARGET_BOOT_ANIMATION_RES := 1080
override TARGET_SUPPORTS_64_BIT_APPS := true # To enable Face Unlock. Override seems to be required.

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
