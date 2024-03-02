-- according to my design i've created the box for only 15 categories and each category having 9 shortcuts
-- if you want to customize the UI of it then it's up to you

local shortcut_list = {
    c1 = {
        name = "malware analysis",
        shortcuts = {
            { path = "ShortcutName1", link = "https://marcoramilli.com/2023/09/23/malware-persistence-locations-windows-and-linux/" },
            { path = "ShortcutName2", link = "https://www.unicorn-engine.org/" },
            { path = "ShortcutName2", link = "https://wiki.bi0s.in/reversing/roadmap/" },

            { path = "ShortcutName2", link = "https://wiki.bi0s.in/" },
            { path = "ShortcutName2", link = "https://malwareunicorn.org/workshops/re101.html#0" },
            { path = "ShortcutName2", link = "https://www.youtube.com/@OALABS" },

            { path = "ShortcutName2", link = "https://www.malware-traffic-analysis.net/" },
            { path = "ShortcutName2", link = "https://any.run/" },
            { path = "ShortcutName2", link = "https://google.com" },
        }
    },
    c2 = {
        name = "osdev",
        shortcuts = {
            { path = "ShortcutName3", link = "https://wiki.osdev.org/Expanded_Main_Page" },
            { path = "ShortcutName4", link = "https://github.com/mit-pdos/xv6-public" },
            { path = "ShortcutName4", link = "https://github.com/Stichting-MINIX-Research-Foundation/minix" },

            { path = "ShortcutName4", link = "https://github.com/torvalds/linux" },
            { path = "ShortcutName4", link = "https://littleosbook.github.io/" },
            { path = "ShortcutName4", link = "https://iitd-plos.github.io/os-nptel/" },

            { path = "ShortcutName4", link = "https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf" },
            { path = "ShortcutName4", link = "https://wiki.osdev.org/James_Molloy%27s_Tutorial_Known_Bugs" },
            { path = "ShortcutName4", link = "http://littleosbook.github.io/" },
        }
    },
    c3 = {
        name = "ricing",
        shortcuts = {
            { path = "ShortcutName3", link = "https://awesomewm.org/doc/api/documentation/07-my-first-awesome.md.html#" },
            { path = "ShortcutName4", link = "https://vicious.readthedocs.io/" },
            { path = "ShortcutName4", link = "https://github.com/andOrlando/rubato" },

            { path = "ShortcutName4", link = "https://www.reddit.com/r/unixporn/" },
            { path = "ShortcutName4", link = "https://www.reddit.com/r/awesomewm/" },
            { path = "ShortcutName4", link = "https://i3wm.org/docs/userguide.html" },

            { path = "ShortcutName4", link = "https://swaywm.org/" },
        }
    },
    c4 = {
        name = "rootkit development",
        shortcuts = {
            { path = "ShortcutName3", link = "https://xcellerator.github.io/" },
            { path = "ShortcutName4", link = "https://github.com/rootkit-io/awesome-malware-development" },
            { path = "ShortcutName4", link = "https://thepaperweight.medium.com/top-resources-for-malware-development-red-teaming-73c36d202926" },

            { path = "ShortcutName4", link = "https://h0mbre.github.io/Learn-C-By-Creating-A-Rootkit/#" },
            { path = "ShortcutName4", link = "https://www.cyberark.com/resources/threat-research-blog/fantastic-rootkits-and-where-to-find-them-part-1" },
        }
    },
    c5 = {
        name = "machine learning and deep learning",
        shortcuts = {
            { path = "", link = "https://github.com/keon/awesome-nlp" },
            { path = "", link = "https://github.com/brianspiering/awesome-dl4nlp" },
            { path = "", link = "https://huggingface.co/" },

            { path = "", link = "https://www.openml.org/" },
            { path = "", link = "https://course.fast.ai/" },
            { path = "", link = "https://www.kaggle.com/" },

            { path = "", link = "https://www.youtube.com/playlist?list=PL_iWQOsE6TfVmKkQHucjPAoRtIJYt8a5A" },
            { path = "", link = "https://www.youtube.com/playlist?list=PLqYmG7hTraZCDxZ44o4p3N5Anz3lLRVZF" },
            { path = "", link = "https://www.youtube.com/watch?v=UU1WVnMk4E8&t=1055s" },
        }
    },
    c6 = {
        name = "mathematics",
        shortcuts = {
            { path = "", link = "https://www.youtube.com/watch?v=0z6AhrOSrRs" },
            { path = "", link = "https://www.youtube.com/watch?v=8ZI55Inh1_A&list=PLeo1K3hjS3uuKaU2nBDwr6zrSOTzNCs0l" },
            { path = "", link = "https://www.youtube.com/watch?v=2MuDZIAzBMY&list=PLoROMvodv4rOpr_A7B9SriE_iZmkanvUg" },

            { path = "", link = "https://www.youtube.com/watch?v=rmVRLeJRkl4&list=PLoROMvodv4rMFqRtEuo6SGjY4XbRIVRd4" },
            { path = "", link = "https://www.youtube.com/watch?v=Ixl3nykKG9M&t=4810s&pp=ygUgbWF0aGVtYXRpY3MgZm9yIG1hY2hpbmUgbGVhcm5pbmc%3D" },

        }
    },
    c7 = {
        name = "dev space",
        shortcuts = {
            { path = "", link = "https://snack.expo.dev/" },
            { path = "", link = "https://replit.com/" },
            { path = "", link = "https://colab.research.google.com/" },

            { path = "", link = "https://github.com/codespaces" },

        }
    },
    c8 = {
        name = "hacking stuff",
        shortcuts = {
            { path = "", link = "https://tryhackme.com/" },
            { path = "", link = "https://www.hackthebox.com/" },
            { path = "", link = "https://picoctf.org/" },

            { path = "", link = "https://crackmes.one/" },
            { path = "", link = "https://ctf.hacker101.com/" },
        }
    },
    c9 = {
        name = "bug bounty",
        shortcuts = {
            { path = "", link = "https://www.bugcrowd.com/" },
            { path = "", link = "https://yeswehack.com/" },
            { path = "", link = "https://www.intigriti.com/" },

            { path = "", link = "https://www.hackerone.com/" },
        }
    },




}

return shortcut_list
