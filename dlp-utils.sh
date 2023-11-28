#!/bin/sh

# Secure Shell Script Practices
set -euo pipefail

# The program name and version
PROG_NAME="dlp-utils"
VERSION="1.1"

# Function to show help message
show_help() {
    echo "Usage: $PROG_NAME [OPTIONS] <playlist URL>"
    echo "Options:"
    echo "  -h, --help           Display this help message"
    echo "  -v, --version        Show the version of the script"
    echo "  -a, --audio-only     Download audio-only format of the media"
    echo "  -s, --subtitles      Download all available subtitles"
    echo "  -l, --language LANG  Specify subtitle language(s) as a comma-separated list. Refer to yt-dlp's --sub-langs format for more details."
    echo "  -m, --metadata       Embed metadata into the downloaded media"
    echo "  -t, --thumbnail      Embed thumbnail into the downloaded media"
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
    LANGUAGES=""
    METADATA=""
    THUMBNAIL=""

    if [ $# -eq 0 ]; then
        show_help
        exit 1
    fi

    while [ $# -gt 0 ]; do
        case $1 in
            -h|--help)
                show_help
                exit
            ;;
            -v|--version)
                echo "$PROG_NAME version $VERSION"
                exit
            ;;
            -a|--audio-only)
                FORMAT="-x -f bestaudio"
            ;;
            -s|--subtitles)
                #SUBTITLES="--all-subs"
                SUBTITLES="--sub-langs all,-live_chat --write-subs"
            ;;
            -l|--language)
                shift
                if [ $# -eq 0 ] || echo "$1" | grep -qE '^(https?://|www\.)'; then
                    echo "$PROG_NAME: Invalid input for -l/--language. Please specify a language code."
                    show_help
                    exit 1
                fi
                LANGUAGES="--sub-langs $1 --write-subs"
                SUBTITLES="" # Clear the --all-subs flag if languages are specified
            ;;
            -m|--metadata)
                METADATA="--add-metadata"
            ;;
            -t|--thumbnail)
                THUMBNAIL="--embed-thumbnail"
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

    # Basic validation for playlist URL
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
    yt-dlp $FORMAT $SUBTITLES $LANGUAGES $METADATA $THUMBNAIL --exec "basename {} >> \"$PLAYLIST_NAME.m3u\"" "$PLAYLIST_URL"
}

# Call the main function with all command line arguments
main "$@"
