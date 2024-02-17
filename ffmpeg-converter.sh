#!/bin/bash
VIDSOURCE="rtsp://<username>:<password>@<ip>:<port>/Streaming/channels/101"
AUDIO_OPTS="-c:a aac -b:a 160000 -ac 2"
VIDEO_OPTS="-s 854x480 -c:v libx264 -b:v 800000"
OUTPUT_HLS="-hls_time 10 -hls_list_size 10 -start_number 1 -hls_flags delete_segments"
ffmpeg -i "$VIDSOURCE" -y $AUDIO_OPTS $VIDEO_OPTS $OUTPUT_HLS cctv-stream/playlist.m3u8