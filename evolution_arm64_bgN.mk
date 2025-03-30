$(call inherit-product, device/mytja/evo/device.mk)

PRODUCT_NAME := evolution_arm64_bgN
#PRODUCT_MODEL := Evolution X GSI

# Additional packages
PRODUCT_PACKAGES += \
  Twelve \
  AudioFX
