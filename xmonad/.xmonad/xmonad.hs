import XMonad

import XMonad.Config.Desktop

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName

import XMonad.Layout.NoBorders

import XMonad.Util.EZConfig

import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

main :: IO ()
main = do 
    dbus <- D.connectSession
    -- Request access to the DBus name
    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

    xmonad
        $ myConfig { logHook = dynamicLogWithPP (myLogHook dbus) } 
        `additionalKeys` [
            ((mod4Mask, xK_p), spawn "rofi -modi window,run,ssh,drun -show-icons -show drun -theme onedark")
        ]

myStartupHook = do
    spawn "polybar xmonad"
    spawn "picom -b"
    spawn "nm-applet"
    spawn "1password --silent"
    setWMName "LG3D"

myLayout = (smartBorders tiled) ||| (smartBorders (Mirror tiled)) ||| (noBorders Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 0.55

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myConfig =  desktopConfig
    { terminal          = "alacritty"
    , modMask           = mod4Mask
    , borderWidth       = 2
    , focusFollowsMouse = True 
    , manageHook        = manageDocks <+> manageHook desktopConfig
    , handleEventHook   = docksEventHook <+> handleEventHook desktopConfig
    , startupHook       = myStartupHook <+> startupHook desktopConfig
    , layoutHook        = desktopLayoutModifiers $ myLayout
    , normalBorderColor = "#353b45"
    , focusedBorderColor= "#c678dd"
    }

-- Override the PP values as you would otherwise, adding colors etc depending
-- on  the statusbar used
myLogHook :: D.Client -> PP
myLogHook dbus = def { ppOutput = dbusOutput dbus }

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal objectPath interfaceName memberName) {
            D.signalBody = [D.toVariant $ UTF8.decodeString str]
        }
    D.emit dbus signal
  where
    objectPath = D.objectPath_ "/org/xmonad/Log"
    interfaceName = D.interfaceName_ "org.xmonad.Log"
    memberName = D.memberName_ "Update"

