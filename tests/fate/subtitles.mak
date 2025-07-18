FATE_SUBTITLES_ASS-$(call ALLYES, AQTITLE_DEMUXER TEXT_DECODER ICONV) += fate-sub-aqtitle
fate-sub-aqtitle: CMD = fmtstdout ass -sub_charenc windows-1250 -i $(TARGET_SAMPLES)/sub/AQTitle_capability_tester.aqt

FATE_SUBTITLES_ASS-$(call ALLYES, AVDEVICE LAVFI_INDEV CCAPTION_DECODER MOVIE_FILTER MPEGTS_DEMUXER) += fate-sub-cc
fate-sub-cc: CMD = fmtstdout ass -f lavfi -i "movie=$(TARGET_SAMPLES)/sub/Closedcaption_rollup.m2v[out0+subcc]"

FATE_SUBTITLES_ASS-$(call ALLYES, AVDEVICE LAVFI_INDEV CCAPTION_DECODER MOVIE_FILTER MPEGTS_DEMUXER) += fate-sub-cc-realtime
fate-sub-cc-realtime: CMD = fmtstdout ass -real_time 1 -f lavfi -i "movie=$(TARGET_SAMPLES)/sub/Closedcaption_rollup.m2v[out0+subcc]"

FATE_SUBTITLES_ASS-$(call ALLYES, AVDEVICE LAVFI_INDEV CCAPTION_DECODER MOVIE_FILTER MPEGTS_DEMUXER) += fate-sub-cc-scte20
fate-sub-cc-scte20: CMD = fmtstdout ass -f lavfi -i "movie=$(TARGET_SAMPLES)/sub/scte20.ts[out0+subcc]"

FATE_SUBTITLES_ASS-$(call DEMDEC, ASS, ASS) += fate-sub-ass-to-ass-transcode
fate-sub-ass-to-ass-transcode: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/1ededcbd7b.ass

FATE_SUBTITLES_ASS-$(CONFIG_ASS_DEMUXER) += fate-sub-ssa-to-ass-remux
fate-sub-ssa-to-ass-remux: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/a9-misc.ssa -c copy

FATE_SUBTITLES-$(call ALLYES, ASS_DEMUXER MATROSKA_MUXER) += fate-binsub-mksenc
fate-binsub-mksenc: CMD = md5pipe -i $(TARGET_SAMPLES)/sub/1ededcbd7b.ass -c copy -f matroska -flags +bitexact -fflags +bitexact

FATE_SUBTITLES_ASS-$(call DEMDEC, JACOSUB, JACOSUB) += fate-sub-jacosub
fate-sub-jacosub: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/JACOsub_capability_tester.jss

FATE_SUBTITLES-$(call REMUX, JACOSUB) += fate-sub-jacosub-remux
fate-sub-jacosub-remux: CMD = transcode jacosub $(TARGET_SAMPLES)/sub/JACOsub_capability_tester.jss jacosub "-map 0 -c copy" "-map 0 -c copy"
fate-sub-jacosub-remux: CMP = diff

FATE_SUBTITLES-$(call DEMMUX, LRC, LRC) += fate-sub-lrc-remux
fate-sub-lrc-remux: CMD = fmtstdout lrc -i $(TARGET_SAMPLES)/sub/test-lrc.lrc

FATE_SUBTITLES_ASS-$(call DEMDEC, MICRODVD, MICRODVD) += fate-sub-microdvd
fate-sub-microdvd: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/MicroDVD_capability_tester.sub

FATE_SUBTITLES-$(call ALLYES, MICRODVD_DEMUXER MICRODVD_MUXER) += fate-sub-microdvd-remux
fate-sub-microdvd-remux: CMD = fmtstdout microdvd -i $(TARGET_SAMPLES)/sub/MicroDVD_capability_tester.sub -c:s copy

FATE_SUBTITLES_ASS-$(call DEMDEC, MOV, MOVTEXT) += fate-sub-movtext
fate-sub-movtext: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/MovText_capability_tester.mp4

FATE_SUBTITLES-$(call ENCDEC, MOVTEXT, MP4 MOV) += fate-binsub-movtextenc
fate-binsub-movtextenc: CMD = md5 -i $(TARGET_SAMPLES)/sub/MovText_capability_tester.mp4 -map 0 -scodec mov_text -f mp4 -flags +bitexact -fflags +bitexact -movflags +frag_keyframe+empty_moov

FATE_SUBTITLES_ASS-$(call DEMDEC, MPL2, MPL2) += fate-sub-mpl2
fate-sub-mpl2: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/MPL2_capability_tester.txt

FATE_SUBTITLES_ASS-$(call DEMDEC, MPSUB, TEXT) += fate-sub-mpsub
fate-sub-mpsub: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/MPSub_capability_tester.sub

FATE_SUBTITLES_ASS-$(call DEMDEC, MPSUB, TEXT) += fate-sub-mpsub-frames
fate-sub-mpsub-frames: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/MPSub_capability_tester_frames.sub

# FIXME?: The dts in the input file are not monotonous and so the
# timestamps of the remuxed file have been fixed up.
FATE_SUBTITLES-$(call REMUX, SUP) += fate-sub-pgs-remux
fate-sub-pgs-remux: CMD = transcode sup $(TARGET_SAMPLES)/sub/pgs_sub.sup sup "-copyts -c:s copy" "-copyts -c:s copy"

FATE_SUBTITLES_ASS-$(call DEMDEC, PJS, PJS) += fate-sub-pjs
fate-sub-pjs: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/PJS_capability_tester.pjs

FATE_SUBTITLES_ASS-$(call DEMDEC, REALTEXT, REALTEXT) += fate-sub-realtext
fate-sub-realtext: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/RealText_capability_tester.rt

FATE_SUBTITLES_ASS-$(call DEMDEC, SAMI, SAMI) += fate-sub-sami
fate-sub-sami: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/SAMI_capability_tester.smi

FATE_SUBTITLES_ASS-$(call DEMDEC, SAMI, SAMI) += fate-sub-sami2
fate-sub-sami2: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/SAMI_multilang_tweak_tester.smi

FATE_SUBTITLES_ASS-$(call DEMDEC, SRT, SUBRIP) += fate-sub-srt
fate-sub-srt: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/SubRip_capability_tester.srt

FATE_SUBTITLES_ASS-$(call DEMDEC, SRT, SUBRIP) += fate-sub-srt-badsyntax
fate-sub-srt-badsyntax: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/badsyntax.srt

FATE_SUBTITLES-$(call ALLYES, SRT_DEMUXER SUBRIP_DECODER SRT_MUXER) += fate-sub-srt-rrn-remux
fate-sub-srt-rrn-remux: CMD = fmtstdout srt -i $(TARGET_SAMPLES)/sub/ticket5032-rrn.srt -c:s copy

FATE_SUBTITLES-$(call ALLYES, SRT_DEMUXER SUBRIP_DECODER SRT_MUXER) += fate-sub-srt-madness-timeshift
fate-sub-srt-madness-timeshift: CMD = fmtstdout srt -itsoffset 3.14 -i $(TARGET_SAMPLES)/sub/madness.srt -c:s copy

FATE_SUBTITLES-$(call ALLYES, SRT_DEMUXER SUBRIP_DECODER SRT_MUXER) += fate-sub-srt-empty-events
fate-sub-srt-empty-events: CMD = fmtstdout srt -i $(TARGET_SAMPLES)/sub/empty-events-2167.srt -c:s copy

FATE_SUBTITLES_ASS-$(call DEMDEC, STL, STL) += fate-sub-stl
fate-sub-stl: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/STL_capability_tester.stl

FATE_SUBTITLES-$(call ALLYES, MOV_DEMUXER MOVTEXT_DECODER SUBRIP_ENCODER SRT_MUXER) += fate-sub-subripenc
fate-sub-subripenc: CMD = fmtstdout srt -i $(TARGET_SAMPLES)/sub/MovText_capability_tester.mp4 -scodec subrip

FATE_SUBTITLES_ASS-$(call ALLYES, SUBVIEWER1_DEMUXER SUBVIEWER1_DECODER ICONV) += fate-sub-subviewer1
fate-sub-subviewer1: CMD = fmtstdout ass -sub_charenc windows-1250 -i $(TARGET_SAMPLES)/sub/SubViewer1_capability_tester.sub

FATE_SUBTITLES_ASS-$(call DEMDEC, SUBVIEWER, SUBVIEWER) += fate-sub-subviewer
fate-sub-subviewer: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/SubViewer_capability_tester.sub

FATE_SUBTITLES_ASS-$(call DEMDEC, VPLAYER, VPLAYER) += fate-sub-vplayer
fate-sub-vplayer: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/VPlayer_capability_tester.txt

FATE_SUBTITLES_ASS-$(call DEMDEC, WEBVTT, WEBVTT) += fate-sub-webvtt
fate-sub-webvtt: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/WebVTT_capability_tester.vtt

FATE_SUBTITLES_ASS-$(call DEMDEC, WEBVTT, WEBVTT) += fate-sub-webvtt2
fate-sub-webvtt2: CMD = fmtstdout ass -i $(TARGET_SAMPLES)/sub/WebVTT_extended_tester.vtt

FATE_SUBTITLES-$(call ALLYES, SRT_DEMUXER SUBRIP_DECODER WEBVTT_ENCODER WEBVTT_MUXER) += fate-sub-webvttenc
fate-sub-webvttenc: CMD = fmtstdout webvtt -i $(TARGET_SAMPLES)/sub/SubRip_capability_tester.srt

FATE_SUBTITLES-$(call ALLYES, SRT_DEMUXER SUBRIP_DECODER TEXT_ENCODER SRT_MUXER) += fate-sub-textenc
fate-sub-textenc: CMD = fmtstdout srt -i $(TARGET_SAMPLES)/sub/SubRip_capability_tester.srt -c:s text

FATE_SUBTITLES_ASS-$(call ALLYES, MICRODVD_DEMUXER MICRODVD_DECODER ICONV) += fate-sub-charenc
fate-sub-charenc: CMD = fmtstdout ass -sub_charenc cp1251 -i $(TARGET_SAMPLES)/sub/cp1251-subtitles.sub

FATE_SUBTITLES-$(call DEMDEC, SCC, CCAPTION) += fate-sub-scc
fate-sub-scc: CMD = fmtstdout ass -ss 57 -i $(TARGET_SAMPLES)/sub/witch.scc
fate-sub-scc: CMP = diff

FATE_SUBTITLES-$(call DEMMUX, SCC, SCC) += fate-sub-scc-remux
fate-sub-scc-remux: CMD = fmtstdout scc -i $(TARGET_SAMPLES)/sub/witch.scc -ss 4:00 -map 0 -c copy

FATE_SUBTITLES-$(call DEMMUX, SCC, RCWT) += fate-sub-rcwt
fate-sub-rcwt: CMD = md5 -i $(TARGET_SAMPLES)/sub/witch.scc -map 0 -c copy -f rcwt
fate-sub-rcwt: CMP = oneline
fate-sub-rcwt: REF = d86f179094a5752d68aa97d82cf887b0

FATE_SUBTITLES-$(call FRAMECRC, MPEGTS, DVBSUB, DVBSUB_ENCODER) += fate-sub-dvb
fate-sub-dvb: CMD = framecrc -i $(TARGET_SAMPLES)/sub/dvbsubtest_filter.ts -map s:0 -c dvbsub

FATE_SUBTITLES-$(call ALLYES, PIPE_PROTOCOL SRT_DEMUXER SUBRIP_DECODER TTML_ENCODER TTML_MUXER) += fate-sub-ttmlenc
fate-sub-ttmlenc: CMD = fmtstdout ttml -i $(TARGET_SAMPLES)/sub/SubRip_capability_tester.srt

FATE_SUBTITLES-$(call ENCMUX, ASS, ASS) += $(FATE_SUBTITLES_ASS-yes)
FATE_SUBTITLES += $(FATE_SUBTITLES-yes)
FATE_SUBTITLES := $(if $(CONFIG_PIPE_PROTOCOL), $(FATE_SUBTITLES))

fate-sub-%: CMP = rawdiff

FATE_SAMPLES_FFMPEG += $(FATE_SUBTITLES)
fate-subtitles: $(FATE_SUBTITLES)
