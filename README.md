# dlp-utils

This is a utility script for `yt-dlp`, a powerful command-line program used to download videos from various video platforms.

## Getting Started

### Local Installation and Usage

To use `dlp-utils`, first download the script to your local system. Then change the permissions of the script to make it executable:

```bash
chmod +x dlp-utils
```

After that, simply run:

```bash
./dlp-utils [OPTIONS] <playlist URL>
```

### Running Directly Online

You can also run the script directly from an online source without a local installation, using either `curl` or `wget`:

**Using curl:**

```bash
curl -sSL https://raw.githubusercontent.com/printfer/dlp-utils/master/dlp-utils.sh | sh -s -- [OPTIONS] <playlist URL>
```

**Using wget:**

```bash
wget -qO- https://raw.githubusercontent.com/printfer/dlp-utils/master/dlp-utils.sh | sh -s -- [OPTIONS] <playlist URL>
```

## Options

The `dlp-utils` script supports several options to customize your download:

```
Usage: dlp-utils [OPTIONS] <playlist URL>
Options:
  -h, --help           Display this help message
  -v, --version        Show the version of the script
  -a, --audio-only     Download audio-only format of the media
  -s, --subtitles      Download all available subtitles
  -l, --language LANG  Specify subtitle language(s) as a comma-separated list. Refer to yt-dlp's --sub-langs format for more details.
  -m, --metadata       Embed metadata into the downloaded media
  -t, --thumbnail      Embed thumbnail into the downloaded media
```

## Additional Notes

- Make sure to provide a valid playlist URL when using the script.
- `yt-dlp` must be installed for the script to run. It will prompt for installation if not found.
- For the thumbnail embedding functionality, additional dependencies might be required. On Arch Linux, for example, you may need to install the `atomicparsley` and/or `python-mutagen` packages to embed thumbnails in specific media formats. Ensure to check and install necessary packages for your operating system to make use of this feature.

## License

[![](https://www.gnu.org/graphics/agplv3-with-text-162x68.png)](https://www.gnu.org/licenses/agpl-3.0.html)

This project is licensed under the AGPLv3 License. See the [LICENSE](LICENSE) file for more information.

Copyright © 2023 [Printfer](https://github.com/printfer)
