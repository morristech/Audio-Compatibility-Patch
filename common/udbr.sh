#!/system/bin/sh
# This script will be executed in post-fs-data mode
# More info in the main Magisk thread

#### v INSERT YOUR CONFIG.SH MODID v ####
MODID=udbr
#### ^ INSERT YOUR CONFIG.SH MODID ^ ####

########## v DO NOT REMOVE v ##########
rm -rf /cache/magisk/audmodlib

if [ ! -d /magisk/$MODID ]; then
  AUDMODLIBPATH=/magisk/audmodlib

  SLOT=$(getprop ro.boot.slot_suffix 2>/tmp/null)
  if [ "$SLOT" ]; then
    SYSTEM=/system/system
  else
    SYSTEM=/system
  fi

  if [ ! -d "$SYSTEM/vendor" ] || [ -L "$SYSTEM/vendor" ]; then
    VENDOR=/vendor
  elif [ -d "$SYSTEM/vendor" ] || [ -L "/vendor" ]; then
    VENDOR=$SYSTEM/vendor
  fi

  ### FILE LOCATIONS ###
  # AUDIO EFFECTS
  CONFIG_FILE=$SYSTEM/etc/audio_effects.conf
  VENDOR_CONFIG=$VENDOR/etc/audio_effects.conf
  HTC_CONFIG_FILE=$SYSTEM/etc/htc_audio_effects.conf
  OTHER_VENDOR_FILE=$SYSTEM/etc/audio_effects_vendor.conf
  OFFLOAD_CONFIG=$SYSTEM/etc/audio_effects_offload.conf
  # AUDIO POLICY
  AUD_POL=$SYSTEM/etc/audio_policy.conf
  AUD_POL_CONF=$SYSTEM/etc/audio_policy_configuration.xml
  AUD_OUT_POL=$VENDOR/etc/audio_output_policy.conf
  V_AUD_POL=$VENDOR/etc/audio_policy.conf
  ########## ^ DO NOT REMOVE ^ ##########

  #### v INSERT YOUR REMOVE PATCH OR RESTORE v ####
  # RESTORE BACKED UP CONFIGS
  if [ -f $AUD_POL.bak ] || [ -f $AUD_POL_CONF.bak ] || [ -f $AUD_OUT_POL.bak ] || [ -f $V_AUD_POL.bak ]; then
    for RESTORE in $AUD_POL $AUD_POL_CONF $AUD_OUT_POL $V_AUD_POL; do
      if [ -f $RESTORE.bak ]; then
        cp -f $AUDMODLIBPATH$RESTORE.bak $AUDMODLIBPATH$RESTORE
      fi
    done
  fi
  #### ^ INSERT YOUR REMOVE PATCH OR RESTORE ^ ####

  rm -f /magisk/.core/post-fs-data.d/$MODID.sh
  reboot
fi
