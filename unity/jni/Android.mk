LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := unwind

MY_ROOT := $(LOCAL_PATH)/../../..

LOCAL_SRC_FILES := \
	$(MY_ROOT)/src/mi/init.c \
	$(MY_ROOT)/src/mi/flush_cache.c \
	$(MY_ROOT)/src/mi/mempool.c \
	$(MY_ROOT)/src/mi/strerror.c \
	$(MY_ROOT)/src/mi/backtrace.c \
	$(MY_ROOT)/src/mi/dyn-cancel.c \
	$(MY_ROOT)/src/mi/dyn-info-list.c \
	$(MY_ROOT)/src/mi/dyn-register.c \
	$(MY_ROOT)/src/mi/map.c \
	$(MY_ROOT)/src/mi/Lmap.c \
	$(MY_ROOT)/src/mi/Ldyn-extract.c \
	$(MY_ROOT)/src/mi/Lfind_dynamic_proc_info.c \
	$(MY_ROOT)/src/mi/Lget_proc_info_by_ip.c \
	$(MY_ROOT)/src/mi/Lget_proc_name.c \
	$(MY_ROOT)/src/mi/Lput_dynamic_unwind_info.c \
	$(MY_ROOT)/src/mi/Ldestroy_addr_space.c \
	$(MY_ROOT)/src/mi/Lget_reg.c \
	$(MY_ROOT)/src/mi/Lset_reg.c \
	$(MY_ROOT)/src/mi/Lget_fpreg.c \
	$(MY_ROOT)/src/mi/Lset_fpreg.c \
	$(MY_ROOT)/src/mi/Lset_caching_policy.c \
	$(MY_ROOT)/src/mi/Gdyn-extract.c \
	$(MY_ROOT)/src/mi/Gfind_dynamic_proc_info.c \
	$(MY_ROOT)/src/mi/Gget_accessors.c \
	$(MY_ROOT)/src/mi/Gget_proc_info_by_ip.c \
	$(MY_ROOT)/src/mi/Gget_proc_name.c \
	$(MY_ROOT)/src/mi/Gput_dynamic_unwind_info.c \
	$(MY_ROOT)/src/mi/Gdestroy_addr_space.c \
	$(MY_ROOT)/src/mi/Gget_reg.c \
	$(MY_ROOT)/src/mi/Gset_reg.c \
	$(MY_ROOT)/src/mi/Gget_fpreg.c \
	$(MY_ROOT)/src/mi/Gset_fpreg.c \
	$(MY_ROOT)/src/mi/Gset_caching_policy.c \
	$(MY_ROOT)/src/dwarf/Lexpr.c \
	$(MY_ROOT)/src/dwarf/Lfde.c \
	$(MY_ROOT)/src/dwarf/Lparser.c \
	$(MY_ROOT)/src/dwarf/Lpe.c \
	$(MY_ROOT)/src/dwarf/Lstep_dwarf.c \
	$(MY_ROOT)/src/dwarf/Lfind_proc_info-lsb.c \
	$(MY_ROOT)/src/dwarf/Lfind_unwind_table.c \
	$(MY_ROOT)/src/dwarf/Gexpr.c \
	$(MY_ROOT)/src/dwarf/Gfde.c \
	$(MY_ROOT)/src/dwarf/Gfind_proc_info-lsb.c \
	$(MY_ROOT)/src/dwarf/Gfind_unwind_table.c \
	$(MY_ROOT)/src/dwarf/Gparser.c \
	$(MY_ROOT)/src/dwarf/Gpe.c \
	$(MY_ROOT)/src/dwarf/Gstep_dwarf.c \
	$(MY_ROOT)/src/dwarf/global.c \
	$(MY_ROOT)/src/os-common.c \
	$(MY_ROOT)/src/os-linux.c \
	$(MY_ROOT)/src/Los-common.c \
	$(MY_ROOT)/src/ptrace/_UPT_accessors.c \
	$(MY_ROOT)/src/ptrace/_UPT_access_fpreg.c \
	$(MY_ROOT)/src/ptrace/_UPT_access_mem.c \
	$(MY_ROOT)/src/ptrace/_UPT_access_reg.c \
	$(MY_ROOT)/src/ptrace/_UPT_create.c \
	$(MY_ROOT)/src/ptrace/_UPT_destroy.c \
	$(MY_ROOT)/src/ptrace/_UPT_find_proc_info.c \
	$(MY_ROOT)/src/ptrace/_UPT_get_dyn_info_list_addr.c \
	$(MY_ROOT)/src/ptrace/_UPT_put_unwind_info.c \
	$(MY_ROOT)/src/ptrace/_UPT_get_proc_name.c \
	$(MY_ROOT)/src/ptrace/_UPT_reg_offset.c \
	$(MY_ROOT)/src/ptrace/_UPT_resume.c
	
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../include $(LOCAL_PATH)/../../src

ifeq ($(TARGET_ARCH_ABI), arm64-v8a)
	LOCAL_SRC_FILES += $(MY_ROOT)/src/elf64.c
else
	LOCAL_SRC_FILES += $(MY_ROOT)/src/elf32.c
endif

ifeq ($(TARGET_ARCH_ABI), armeabi-v7a)
	LOCAL_SRC_FILES += \
		$(MY_ROOT)/src/dl-iterate-phdr.c \
		$(MY_ROOT)/src/arm/is_fpreg.c \
		$(MY_ROOT)/src/arm/regname.c \
		$(MY_ROOT)/src/arm/Gcreate_addr_space.c \
		$(MY_ROOT)/src/arm/Gget_proc_info.c \
		$(MY_ROOT)/src/arm/Gget_save_loc.c \
		$(MY_ROOT)/src/arm/Gglobal.c \
		$(MY_ROOT)/src/arm/Ginit.c \
		$(MY_ROOT)/src/arm/Ginit_local.c \
		$(MY_ROOT)/src/arm/Ginit_remote.c \
		$(MY_ROOT)/src/arm/Gregs.c \
		$(MY_ROOT)/src/arm/Gresume.c \
		$(MY_ROOT)/src/arm/Gstep.c \
		$(MY_ROOT)/src/arm/Lcreate_addr_space.c \
		$(MY_ROOT)/src/arm/Lget_proc_info.c \
		$(MY_ROOT)/src/arm/Lget_save_loc.c \
		$(MY_ROOT)/src/arm/Lglobal.c \
		$(MY_ROOT)/src/arm/Linit.c \
		$(MY_ROOT)/src/arm/Linit_local.c \
		$(MY_ROOT)/src/arm/Linit_remote.c \
		$(MY_ROOT)/src/arm/Lregs.c \
		$(MY_ROOT)/src/arm/Lresume.c \
		$(MY_ROOT)/src/arm/Lstep.c \
		$(MY_ROOT)/src/arm/getcontext.S \
		$(MY_ROOT)/src/arm/Gis_signal_frame.c \
		$(MY_ROOT)/src/arm/Gex_tables.c \
		$(MY_ROOT)/src/arm/Lis_signal_frame.c \
		$(MY_ROOT)/src/arm/Lex_tables.c

	LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../include/tdep-arm
else ifeq ($(TARGET_ARCH_ABI), arm64-v8a)
	LOCAL_SRC_FILES += \
		$(MY_ROOT)/src/aarch64/is_fpreg.c \
		$(MY_ROOT)/src/aarch64/regname.c \
		$(MY_ROOT)/src/aarch64/Gcreate_addr_space.c \
		$(MY_ROOT)/src/aarch64/Gget_proc_info.c \
		$(MY_ROOT)/src/aarch64/Gget_save_loc.c \
		$(MY_ROOT)/src/aarch64/Gglobal.c \
		$(MY_ROOT)/src/aarch64/Ginit.c \
		$(MY_ROOT)/src/aarch64/Ginit_local.c \
		$(MY_ROOT)/src/aarch64/Ginit_remote.c \
		$(MY_ROOT)/src/aarch64/Gregs.c \
		$(MY_ROOT)/src/aarch64/Gresume.c \
		$(MY_ROOT)/src/aarch64/Gstep.c \
		$(MY_ROOT)/src/aarch64/Lcreate_addr_space.c \
		$(MY_ROOT)/src/aarch64/Lget_proc_info.c \
		$(MY_ROOT)/src/aarch64/Lget_save_loc.c \
		$(MY_ROOT)/src/aarch64/Lglobal.c \
		$(MY_ROOT)/src/aarch64/Linit.c \
		$(MY_ROOT)/src/aarch64/Linit_local.c \
		$(MY_ROOT)/src/aarch64/Linit_remote.c \
		$(MY_ROOT)/src/aarch64/Lregs.c \
		$(MY_ROOT)/src/aarch64/Lresume.c \
		$(MY_ROOT)/src/aarch64/Lstep.c \
		$(MY_ROOT)/src/aarch64/Gis_signal_frame.c \
		$(MY_ROOT)/src/aarch64/Lis_signal_frame.c

	LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../include/tdep-aarch64
else ifeq ($(TARGET_ARCH_ABI), x86)
	LOCAL_SRC_FILES += \
		$(MY_ROOT)/src/x86/is_fpreg.c \
		$(MY_ROOT)/src/x86/regname.c \
		$(MY_ROOT)/src/x86/Gcreate_addr_space.c \
		$(MY_ROOT)/src/x86/Gget_proc_info.c \
		$(MY_ROOT)/src/x86/Gget_save_loc.c \
		$(MY_ROOT)/src/x86/Gglobal.c \
		$(MY_ROOT)/src/x86/Ginit.c \
		$(MY_ROOT)/src/x86/Ginit_local.c \
		$(MY_ROOT)/src/x86/Ginit_remote.c \
		$(MY_ROOT)/src/x86/Gregs.c \
		$(MY_ROOT)/src/x86/Gresume.c \
		$(MY_ROOT)/src/x86/Gstep.c \
		$(MY_ROOT)/src/x86/Lcreate_addr_space.c \
		$(MY_ROOT)/src/x86/Lget_proc_info.c \
		$(MY_ROOT)/src/x86/Lget_save_loc.c \
		$(MY_ROOT)/src/x86/Lglobal.c \
		$(MY_ROOT)/src/x86/Linit.c \
		$(MY_ROOT)/src/x86/Linit_local.c \
		$(MY_ROOT)/src/x86/Linit_remote.c \
		$(MY_ROOT)/src/x86/Lregs.c \
		$(MY_ROOT)/src/x86/Lresume.c \
		$(MY_ROOT)/src/x86/Lstep.c \
		$(MY_ROOT)/src/x86/getcontext-linux.S \
		$(MY_ROOT)/src/x86/Gos-linux.c \
		$(MY_ROOT)/src/x86/Los-linux.c

	LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../include/tdep-x86
else
	$(warning Unsupported target architecture $(TARGET_ARCH_ABI).)
endif

LOCAL_CFLAGS := \
	-Werror \
	-Wno-unused-parameter \
	-Wno-macro-redefined \
	-Wno-header-guard \
	-Wno-absolute-value \
	-Wno-inline-asm \
	-fvisibility=hidden \
	-DHAVE_CONFIG_H \
	-DNDEBUG \
	-DUNW_LOCAL_ONLY \

#LOCAL_CFLAGS += -Wno-#pragma-messages

ifeq ($(APP_OPTIM), debug)
	#LOCAL_CFLAGS += -UNDEBUG
	#LOCAL_CFLAGS += -DDEBUG
	LOCAL_CFLAGS += -U_FORTIFY_SOURCE
endif

include $(BUILD_STATIC_LIBRARY)
