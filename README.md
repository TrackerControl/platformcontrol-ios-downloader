# PlatformControl App Store Downloader

*This project is part of PlatformControl: <https://github.com/OxfordHCC/PlatformControl>*

This project helps you to download iOS apps at scale.

This is accomplished by an AutoHotkey script that clicks 'Download' in the iTunes Windows application for a list of apps.

At the same time, the script circumvents most pop-ups that occur during the download process at scale.

## Requirements
- A Windows computer
- An Apple account

It is advised to use a dedicated iTunes account for the downloading process.

## Setup
1. Install the latest [AutoHotkey](https://www.autohotkey.com/).
2. Install [iTunes 12.6.5.3](https://support.apple.com/en-us/HT208079).
3. Open iTunes, log in to your account; then, disable password for purchases in settings, and set language to English (UK).
4. Fill in your iTunes password into `instrumentor.ahk`, and change the variable `DownloadsDir` to reflect your iTunes media folder.
5. Add a list of URLs with apps to download to your `apps.txt`.

Note that some antivirus software classifies AutoHotkey as malware. AutoHotkey is usually safe, but use is at your own risk.

## Usage
Run `instrumentor.ahk`.

The apps in `apps.txt` will then be downloaded to your iTunes Media folder.

Depending on your internet connection, the downloading might be too quick or too slow for iTunes to handle. Change the `waitTime` variable in `instrumentor.ahk` to change the time (in milliseconds) to wait between trying to download different apps.

Sometimes, the downloading process gets stuck. To overcome this, you can add a link to the provided `autostart.bat` to your Windows autostart. This batch script restarts your machine and the downloading every hour.

## Citation

If you use this project as part of your academic studies, please kindly cite the below article:

```
@article{kollnig2021_iphone_android,
      title={Are iPhones Really Better for Privacy? A Comparative Study of iOS and Android Apps}, 
      author={Konrad Kollnig and Anastasia Shuba and Reuben Binns and Max {Van Kleek} and Nigel Shadbolt},
      year={2021},
      journal={arXiv preprint arXiv:2109.13722}
}
```

## License
This project is licensed under an MIT license.

*This product has not been endorsed or certified by Apple Inc. All rights regarding the name and brand iTunes and Apple belong to their owners. This project is solely for research purposes without any commercial affiliation.*
