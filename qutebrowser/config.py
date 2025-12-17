from qutebrowser.api import interceptor
config.load_autoconfig()
c.content.blocking.method = 'both'
c.content.blocking.adblock.lists = [
        "https://easylist.to/easylist/easylist.txt",
        "https://easylist.to/easylist/easyprivacy.txt",
        "https://easylist.to/easylist/fanboy-social.txt",
        "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
        "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt",
        "https://pgl.yoyo.org/adservers/serverlist.php?showintro=0;hostformat=hosts",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
        "https://www.i-dont-care-about-cookies.eu/abp/",
        "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt"]

c.content.pdfjs = True
c.content.autoplay = False

c.editor.command = ["wezterm", "-e", "nvim", "{file}", "-c", "normal {line}G{column0}l"]

c.input.insert_mode.auto_load = True
c.spellcheck.languages = ["en-US"]

c.tabs.background = True
c.tabs.title.format_pinned = '{index} {audio}'

c.url.open_base_url = True
c.url.start_pages = 'about:blank'
c.url.default_page = 'about:blank'
