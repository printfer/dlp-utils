# dlp-utils

This is a utility script for `yt-dlp`, a powerful command-line program used to download videos from various video platforms.

## Usage

To use `dlp-utils`, first download the script to your local system. Then change the permissions of the script to make it executable:

```bash
chmod +x dlp-utils
```

After that, simply run:

```bash
./dlp-utils [OPTIONS] <playlist URL>
```

If you want to run the script directly from an online source without manually downloading it, you can do so with `curl` or `wget`.

Using curl:

```bash
curl -sSL https://raw.githubusercontent.com/printfer/dlp-utils/master/dlp-utils.sh | sh -s -- [OPTIONS] <playlist URL>
```

Using wget:

```bash
wget -qO- https://raw.githubusercontent.com/printfer/dlp-utils/master/dlp-utils.sh | sh -s -- [OPTIONS] <playlist URL>
```

## Notes

* You must provide a valid playlist URL.
* The script checks if `yt-dlp` is installed before running. If `yt-dlp` is not installed, it will print a message asking to install `yt-dlp`.
* For the thumbnail embedding functionality, additional dependencies might be required. On Arch Linux, for example, you may need to install the `atomicparsley` and/or `python-mutagen` packages to embed thumbnails in specific media formats. Ensure to check and install necessary packages for your operating system to make use of this feature.

## License

[![](https://www.gnu.org/graphics/agplv3-with-text-162x68.png)](https://www.gnu.org/licenses/agpl-3.0.html)

This project is licensed under the AGPLv3 License. See the [LICENSE](LICENSE) file for more information.

Copyright © 2023 [Printfer](https://github.com/printfer)
