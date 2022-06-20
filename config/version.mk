# Copyright (C) 2016 The Pure Nexus Project
# Copyright (C) 2016 The JDCTeam
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

BANANA_MOD_VERSION = 12
BANANA_BUILD_TYPE := UNOFFICIAL
BANANA_BUILD_ZIP_TYPE := VANILLA

ifeq ($(BANANA_BETA),true)
    BANANA_BUILD_TYPE := BETA
endif

ifeq ($(GAPPS_VERSION), true)
    $(call inherit-product, vendor/gapps/common/common-vendor.mk)
    BANANA_BUILD_ZIP_TYPE := GAPPS
endif

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

ifeq ($(BANANA_OFFICIAL), true)
    BANANA_BUILD_TYPE := OFFICIAL

PRODUCT_PACKAGES += \
    Updater
endif

BANANA_VERSION := BananaDroid-v$(BANANA_MOD_VERSION)-$(CURRENT_DEVICE)-$(BANANA_BUILD_TYPE)-$(shell date -u +%Y%m%d)-$(BANANA_BUILD_ZIP_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.banana.version=$(BANANA_VERSION) \
  ro.banana.releasetype=$(BANANA_BUILD_TYPE) \
  ro.banana.ziptype=$(BANANA_BUILD_ZIP_TYPE) \
  ro.modversion=$(BANANA_MOD_VERSION)

BANANA_DISPLAY_VERSION := BananaDroid-$(BANANA_MOD_VERSION)-$(BANANA_BUILD_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.banana.display.version=$(BANANA_DISPLAY_VERSION)
