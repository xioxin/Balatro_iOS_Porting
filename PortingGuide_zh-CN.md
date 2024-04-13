Balatro移植指南iOS指南
-------------------

> [!TIP]
> 本文章与项目仅提供移植思路。
> 所提供的ipa文件仅为Love2D游戏引擎，本人不提供Balatro游戏文件，请自行购买正版资源自行移植。
>
> 可以转载或制作成视频教程，但需要注明出处

## 用到的软件与文件

这里罗列了所有使用到的软件和文件，方便已经知道如何移植后快速查阅。教程中包含下载步骤，你可以直接从下方教程开始。

名称 | 描述 | 下载地址 
:-- | :-- | :-- 
Balatro.exe | 游戏本体 | Steam 下载 https://store.steampowered.com/app/2379780/Balatro/
Steamodded | 为 Balatro 添加Mod支持 | https://github.com/Steamopollys/Steamodded/releases (steamodded_injector.exe)
Python 3.x | Python 运行环境，用于运行解包脚本 | https://www.python.org/downloads/
love2d-unpacker.py | 游戏解包脚本 | https://gist.github.com/jojonas/8a49555f479030b358ec
balatro.love | 解包后的游戏本体 | 使用解包工具得到
AltStore | 用于将ipa安装到iPhone，也可以使用其他方法安装，例如巨魔或其他工具 | https://altstore.io
Balatro.ipa | 本项目编译的ipa安装包，Love2D在iOS的运行环境 | https://github.com/xioxin/Balatro_iOS_Porting/releases
LocalSend | （可选）方便从Windows发送文件到 iOS，你也可以使用其他方式发送文件 | https://localsend.org/
IOSAdaptation.lua | MOD 让游戏适配iOS分辨率 | https://github.com/xioxin/BalatroMods/blob/main/Mods/IOSAdaptation.lua
CustomFonts.lua | (可选) 安装字体替换mod，用于解决字体报错 | https://discord.com/channels/1116389027176787968/1210101577550008390
怀源黑体 | (可选) 替换字体，用于解决字体报错 | https://github.com/m13253/kaigen-gothic/blob/master/dist/CN/KaiGenGothicCN-Bold.ttf


# 教程
## 准备游戏文件

创建一个文件夹作为我们的工作目录，建议路径纯英文，防止出现bug。

在Steam中安装正版Balatro，在“库”页面，右键Balatro，点击管理，点击浏览本地文件。

找到 *Balatro.exe* 复制进工作目录备用

## 安装MOD加载器（Steamodded）

前往项目：https://github.com/Steamopollys/Steamodded

在 Releases 中找到 steamodded_injector.exe 下载到工作目录。

将工作目录准备的 *Balatro.exe* 文件拖放到 steamodded_injector.exe 程序上。

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

在电脑和手机均安装 LocalSend https://localsend.org/

使用 LocalSend 将 `balatro.love` 游戏文件发送到手机

打开系统的“文件”应用，将 `balatro.love` 从 “我的iPhone -> LocalSend” 复制到 “我的iPhone -> Balatro”（必须运行一次才会显示此目录）

运行手机上的Balatro，游戏成功运行，但是画面非常模糊，我们继续。

## 安装适配MOD

下载 [IOSAdaptation.lua](https://github.com/xioxin/BalatroMods/blob/main/Mods/IOSAdaptation.lua)

使用 LocalSend 将 `IOSAdaptation.lua` 发送到手机。

打开系统的“文件”应用，将 `IOSAdaptation.lua` 从 “我的iPhone -> LocalSend” 复制到 “我的iPhone -> Balatro -> balatro -> Mods“文件夹下。

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

如果遇到错误`TrueType Font glyph error: FT_Glyph_To_Bitmap failed (0x62)` 可以更换字体修复。

下载自定义字体mod [CustomFonts.lua](https://discord.com/channels/1116389027176787968/1210101577550008390) 
下载字体：推荐 [怀源黑体](https://github.com/m13253/kaigen-gothic/blob/master/dist/CN/KaiGenGothicCN-Bold.ttf) 重命名为 `font.ttf`

使用 LocalSend 将 `font.ttf` 和 `CustomFonts.lua` 发送到手机。

打开系统的“文件”应用，将 `font.ttf` 和 `CustomFonts.lua` 从 “我的iPhone -> LocalSend” 复制到 “我的iPhone -> Balatro -> balatro -> Mods“文件夹下。


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




