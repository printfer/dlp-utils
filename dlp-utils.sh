#!/bin/sh

# The program name and version
PROG_NAME="dlp-utils"
VERSION="1.0"

# Function to show help message
show_help() {
    echo "Usage: $PROG_NAME [OPTIONS] <playlist URL>"
    echo "Options:"
    echo "  -h, --help         Display this help message"
    echo "  -a, --audio-only   Download only audio from the videos"
    echo "  -s, --subtitles    Download subtitles for the videos"
    echo "  -m, --metadata     Embed metadata in the downloaded file"
}

# Function to check if yt-dlp is installed
check_yt_dlp() {
    if ! command -v yt-dlp > /dev/null; then
        echo "$PROG_NAME: yt-dlp is required but it's not installed."
        exit 1
    fi
}

# Main function
main() {
    check_yt_dlp
    # Default values
    FORMAT=""
    SUBTITLES=""
    METADATA=""

    while :; do
        case $1 in
            -h|--help)
                show_help
                exit
            ;;
            -a|--audio-only)
                FORMAT="-f bestaudio"
            ;;
            -s|--subtitles)
                SUBTITLES="--write-subs"
            ;;
            -m|--metadata)
                METADATA="--add-metadata"
            ;;
            --)
                shift
                break
            ;;
            -*)
                echo "$PROG_NAME: Invalid option: $1"
                show_help
                exit 1
            ;;
            *)
                break
        esac
        shift
    done

    PLAYLIST_URL="$1"

    if [ -z "$PLAYLIST_URL" ]; then
        echo "$PROG_NAME: No playlist URL provided."
        show_help
        exit 1
    fi

    # Extract the playlist's name
    PLAYLIST_NAME=$(yt-dlp --flat-playlist --playlist-items 1 --print "%(playlist_title)s" "$PLAYLIST_URL")

    # Create a playlist file with the playlist's name
    echo "#EXTM3U" > "$PLAYLIST_NAME.m3u"

    # Download videos and write titles to the playlist file
    yt-dlp $FORMAT $SUBTITLES $METADATA --exec "basename {} >> \"$PLAYLIST_NAME.m3u\"" "$PLAYLIST_URL"
}

# Call the main function with all command line arguments
main "$@"
