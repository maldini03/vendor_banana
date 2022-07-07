# Copyright (C) 2021-2022 BananaDroid
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

BANANA_MOD_VERSION = PisangSusu

ifndef BANANA_BUILD_TYPE
BANANA_BUILD_TYPE := UNOFFICIAL
endif

ifeq ($(BANANA_BUILD_TYPE), OFFICIAL)
PRODUCT_PACKAGES += \
    Updater
endif

TARGET_PRODUCT_SHORT := $(subst banana_,,$(BANANA_BUILD))

# GApps
ifeq ($(WITH_GAPPS),true)
IS_PHONE := true
$(call inherit-product, vendor/gms/products/gms.mk)

BANANA_EDITION := GAPPS
BANANA_BUILD_DATETIME := $(shell date +%s)
BANANA_BUILD_DATE := $(shell date -d @$(BANANA_BUILD_DATETIME) +"%Y%m%d-%H%M%S")
BANANA_VERSION := BananaDroid-$(BANANA_MOD_VERSION)-$(BANANA_EDITION)-$(BANANA_BUILD)-$(BANANA_BUILD_TYPE)-$(BANANA_BUILD_DATE)
BANANA_FINGERPRINT := BananaDroid/$(BANANA_MOD_VERSION)/$(BANANA_EDITION)/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(BANANA_BUILD_DATE)
BANANA_DISPLAY_VERSION := BananaDroid-$(BANANA_MOD_VERSION)-$(BANANA_EDITION)-$(BANANA_BUILD_TYPE)-$(BANANA_BUILD_DATE)
else
BANANA_EDITION := VANILLA
BANANA_BUILD_DATETIME := $(shell date +%s)
BANANA_BUILD_DATE := $(shell date -d @$(BANANA_BUILD_DATETIME) +"%Y%m%d-%H%M%S")
BANANA_VERSION := BananaDroid-$(BANANA_MOD_VERSION)-$(BANANA_EDITION)-$(BANANA_BUILD)-$(BANANA_BUILD_TYPE)-$(BANANA_BUILD_DATE)
BANANA_FINGERPRINT := BananaDroid/$(BANANA_MOD_VERSION)/$(BANANA_EDITION)/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(BANANA_BUILD_DATE)
BANANA_DISPLAY_VERSION := BananaDroid-$(BANANA_MOD_VERSION)-$(BANANA_EDITION)-$(BANANA_BUILD_TYPE)-$(BANANA_BUILD_DATE)

endif

PRODUCT_GENERIC_PROPERTIES += \
  ro.banana.version=$(BANANA_VERSION) \
  ro.banana.releasetype=$(BANANA_BUILD_TYPE) \
  ro.modversion=$(BANANA_MOD_VERSION) \
  ro.banana.build.date=$(BANANA_BUILD_DATETIME)\
  ro.banana.display.version=$(BANANA_DISPLAY_VERSION) \
  ro.banana.fingerprint=$(BANANA_FINGERPRINT)\
  ro.banana.edition=$(BANANA_EDITION)
