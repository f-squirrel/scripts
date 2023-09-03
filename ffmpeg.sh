#!/usr/bin/env bash


VIDEO_PATH=${1}

echo Processing: ${VIDEO_PATH}

FFPMEG=ffpb

if ! [ -x "$(command -v ${FFPMEG})" ]; then
    FFPMEG=ffmpeg
fi

FONT_NAME="FontName=DejaVu Serif"
FONT_SIZE=24
SUBTITLE_INDEX=4
VIDEO_INDEX=0
AUDIO_INDEX=3

SUBTITLE_COMMAND="${VIDEO_PATH}:si=${SUBTITLE_INDEX}:force_style='FontName=${FONT_NAME},FontSize=${FONT_SIZE}'"

echo Subtitle command: ${SUBTITLE_COMMAND}

time ${FFPMEG} -i "${VIDEO_PATH}" \
    -map 0:v:${VIDEO_INDEX} \
    -map 0:a:${AUDIO_INDEX} \
    -c:v libx264 -crf 21 -c:a copy  \
    -vf subtitles="${SUBTITLE_COMMAND}" \
    ./subtitles.$(date +%s).mkv

