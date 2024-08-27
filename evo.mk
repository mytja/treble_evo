$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
$(call inherit-product, vendor/lineage/config/BoardConfigSoong.mk)
$(call inherit-product, device/lineage/sepolicy/common/sepolicy.mk)

override PRODUCT_NAME := treble_arm64_bgN
override PRODUCT_DEVICE := evolution_gsi_arm64_ab
override PRODUCT_BRAND := google
override PRODUCT_SYSTEM_BRAND := google
override PRODUCT_MODEL := Evolution X 9.3

# No kernel image
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_NO_KERNEL_IMAGE := true
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

#BUILD_BROKEN_DUP_RULES := true
TARGET_BOOT_ANIMATION_RES := 1080

# SELinux
SELINUX_IGNORE_NEVERALLOWS := true
TARGET_USES_PREBUILT_VENDOR_SEPOLICY := true

# Evolution X
EVO_BUILD_TYPE := Unofficial

# Additional packages
PRODUCT_PACKAGES += \
  AuroraStorePrivilegedExtension \
  F-DroidPrivilegedExtension \
  OpenEUICC
