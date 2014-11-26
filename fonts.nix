{ config, pkgs, ... }:

{
  fonts = {
    enableFontConfig = false;
    fontconfig = rec {
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <!-- Default fonts -->
          <alias>
            <family>sans-serif</family>
            <prefer><family>DejaVu Sans</family></prefer>
          </alias>
          <alias>
            <family>serif</family>
            <prefer><family>DejaVu Serif</family></prefer>
          </alias>
          <alias>
            <family>monospace</family>
            <prefer><family>Source Code Pro</family></prefer>
          </alias>

          <!-- Settings for all fonts -->
          <match target="font">
            <edit mode="assign" name="hintstyle"><const>hintslight</const></edit>
            <edit mode="assign" name="embeddedbitmap"><bool>false</bool></edit>
            <edit mode="assign" name="antialias"><bool>true</bool></edit>
            <edit mode="assign" name="rgba"><const>rgb</const></edit>
            <edit mode="assign" name="lcdfilter"><const>lcddefault</const></edit>
            <edit mode="assign" name="hinting"><bool>true</bool></edit>
            <edit mode="assign" name="autohint"><bool>false</bool></edit>
          </match>

          <!-- Reject bitmap fonts -->
          <selectfont>
            <rejectfont>
              <pattern><patelt name="scalable"><bool>false</bool></patelt></pattern>
            </rejectfont>
          </selectfont>
        </fontconfig>
      '';
      oldLocalConf = localConf;
    };

    infinality = {
      enable = true;
      extraConf = ''
        <!-- Uncomment this to reject all bitmap fonts -->
        <!-- Make sure to run this as root if having problems:  fc-cache -f -->
        <selectfont>
          <rejectfont>
            <pattern>
              <patelt name="scalable" >
                <bool>false</bool>
              </patelt>
            </pattern>
          </rejectfont>
        </selectfont>

        <!-- Ban Type-1 fonts because they render poorly -->
        <!-- Comment this out to allow all Type 1 fonts -->
        <selectfont>
          <rejectfont>
            <pattern>
              <patelt name="fontformat" >
                <string>Type 1</string>
              </patelt>
            </pattern>
          </rejectfont>
        </selectfont>

        <!-- Globally use embedded bitmaps in fonts like Calibri? -->
        <match target="font" >
          <edit name="embeddedbitmap" mode="assign">
            <bool>false</bool>
          </edit>
        </match>

        <!-- Substitute truetype fonts in place of bitmap ones? -->
        <match target="pattern" >
          <edit name="prefer_outline" mode="assign">
            <bool>true</bool>
          </edit>
        </match>

        <!-- Do font substitutions for the set style? -->
        <!-- NOTE: Custom substitutions in 42-repl-global.conf will still be done -->
        <!-- NOTE: Corrective substitutions will still be done -->
        <match target="pattern" >
          <edit name="do_substitutions" mode="assign">
            <bool>false</bool>
          </edit>
        </match>

        <!-- Make (some) monospace/coding TTF fonts render as bitmaps? -->
        <!-- courier new, andale mono, monaco, etc. -->
        <match target="pattern" >
          <edit name="bitmap_monospace" mode="assign">
            <bool>false</bool>
          </edit>
        </match>

        <!-- Force autohint always -->
        <!-- Useful for debugging and for free software purists -->
        <match target="font">
          <edit name="force_autohint" mode="assign">
            <bool>false</bool>
          </edit>
        </match>

        <!-- Set DPI.  dpi should be set in ~/.Xresources to 96 -->
        <!-- Setting to 72 here makes the px to pt conversions work better (Chrome) -->
        <!-- Some may need to set this to 96 though -->
        <match target="pattern">
          <edit name="dpi" mode="assign">
            <double>96</double>
          </edit>
        </match>

        <!-- Use Qt subpixel positioning on autohinted fonts? -->
        <!-- This only applies to Qt and autohinted fonts. Qt determines subpixel positioning based on hintslight vs. hintfull, -->
        <!--   however infinality patches force slight hinting inside freetype, so this essentially just fakes out Qt. -->
        <!-- Should only be set to true if you are not doing any stem alignment or fitting in environment variables -->
        <match target="pattern" >
          <edit name="qt_use_subpixel_positioning" mode="assign">
            <bool>true</bool>
          </edit>
        </match>
      '';
    };
  };
}
