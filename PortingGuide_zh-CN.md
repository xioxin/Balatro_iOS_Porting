Balatro移植指南iOS指南
-------------------

> [!TIP]
> 本文章与项目仅提供移植思路。
> 所提供的ipa文件仅为Love2D游戏引擎，本人不提供Balatro游戏文件，请自行购买正版资源自行移植。
>
> 可以转载或制作成视频教程，但需要注明出处


## 准备游戏文件

创建一个文件夹作为我们的工作目录，建议路径纯英文，防止出现bug。

在Steam中安装正版Balatro，在“库”页面，右键Balatro，点击管理，点击浏览本地文件。

找到 *Balatro.exe* 复制进工作目录备用

## 安装MOD加载器（Steamodded）

确保关闭游戏！

前往项目：https://github.com/Steamopollys/Steamodded

在 Releases 中找到 steamodded_injector.exe 下载到工作目录。

将 *Balatro.exe* 文件拖放到 steamodded_injector.exe 程序上。

等待它完成。

## 游戏解包

安装Python环境：https://www.python.org/downloads/

下载[Love2D Unpacker](https://gist.github.com/jojonas/8a49555f479030b358ec)脚本保存到工作目录，命名为`love2d-unpacker.py`。

打开 PowerShell/终端，并进入工作目录，执行`python ./love2d-unpacker.py --love balatro.love Balatro.exe`

得到 `balatro.love` 文件。

## 使用 AltStore 安装 Balatro.ipa 到手机

下载ipa文件：https://github.com/xioxin/Balatro_iOS_Porting/releases

安装 https://altstore.io/ 到你的电脑。

并根据 AltStore 的指南，安装 **Balatro.ipa** 到你的 iPhone

在手机上运行一次 Balatro 会显示 No Game，结束掉应用。

打开系统的“文件”应用，将 `balatro.love` 复制到 我的iPhone -> Balatro 目录（必须运行一次才会显示此目录）

重启游戏，游戏成功运行，但是画面非常模糊。

## 安装适配MOD

将 [IOSAdaptation.lua](https://github.com/xioxin/BalatroMods/blob/main/Mods/IOSAdaptation.lua) 复制到 我的iPhone -> Balatro -> balatro -> Mods 文件夹下。

重新启动游戏，画面恢复清晰。

#### IOSAdaptation.lua
```
--- STEAMODDED HEADER
--- MOD_NAME: iOS adaptation
--- MOD_ID: IOSAdaptation
--- MOD_AUTHOR: [Xioxin]
--- MOD_DESCRIPTION: Adapt to iOS resolution

----------------------------------------------
------------MOD CODE -------------------------

function SMODS.INIT.IOSAdaptation()
    sendDebugMessage("IOS Adaptation!")
    if love.system.getOS() == 'iOS' then
        G.F_SAVE_TIMER = 5
        G.F_DISCORD = false
        G.F_CRASH_REPORTS = false
        G.F_BASIC_CREDITS = true
        G.F_NO_ERROR_HAND = true
        G.F_QUIT_BUTTON = false
        G.F_ENABLE_PERF_OVERLAY = false
        G.F_NO_SAVING = false
        G.F_MUTE = false
        G.F_SOUND_THREAD = true
        G.F_VIDEO_SETTINGS = false
        G.F_RUMBLE = 0.7
        G.F_CTA = false
        G.F_VERBOSE = true
        G.F_ENGLISH_ONLY = false
        love.window.updateMode(
            love.graphics.getWidth(),
            love.graphics.getHeight(),
            {
                fullscreen = true,
                vsync = G.SETTINGS.WINDOW.vsync,
                resizable = true,
                display = G.SETTINGS.WINDOW.selected_display,
                highdpi = true
        })
        love.resize(love.graphics.getWidth(),love.graphics.getHeight())
    end
end


----------------------------------------------
------------MOD CODE END----------------------
```

## 可能的字体Bug

如果遇到错误`TrueType Font glyph error: FT_Glyph_To_Bitmap failed (0x62)` 可以更换字体修复

安装字体替换mod [Custom Fonts](https://discord.com/channels/1116389027176787968/1210101577550008390) (自定义游戏字体。字体文件必须命名为 `font.ttf`)。

推荐字体：[怀源黑体](https://github.com/m13253/kaigen-gothic/blob/master/dist/CN/KaiGenGothicCN-Bold.ttf) 重命名为 `font.ttf` 与 `CustomFonts.lua` 一起存入Mods 目录。

#### CustomFonts.lua
```lua
--- STEAMODDED HEADER
--- MOD_NAME: Custom Font
--- MOD_ID: CustomFont
--- MOD_AUTHOR: [MathIsFun_]
--- MOD_DESCRIPTION: Allows setting the game font to a custom font. Must be named "font.ttf".

----------------------------------------------
------------MOD CODE -------------------------
function SMODS.INIT.CustomFont()
    local customfont_mod = SMODS.findModByID("CustomFont")
    if love.filesystem.exists(customfont_mod.path.."font.ttf") then
        G.LANG.font.FONT = love.graphics.newFont(customfont_mod.path.."font.ttf", G.TILESIZE * 10)
        G.LANG.font.FONTSCALE = 0.07 --Can be configured to adjust text size
    end
end
----------------------------------------------
------------MOD CODE END----------------------
```




