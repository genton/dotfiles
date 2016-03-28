import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Util.Run
import XMonad.Util.CustomKeys

import qualified Data.Map as M




main = do
   fitscreen <- spawnPipe vmw
   compositing <- spawnPipe xcompmgr 
   wallpaper <- spawnPipe wpaper
   xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig


-- init script
xcompmgr = "xcompmgr -fFc"
vmw = "vmware-user"
wpaper = "feh --bg-scale Downloads/wallpaper.jpg"

-- command to launch the bar
myBar = "xmobar"

-- Custom PP
myPP = xmobarPP {ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- key binding to toggle the gap for the bar
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- layout
myLayout = noBorders tiled ||| Mirror tiled ||| noBorders Full where
   -- default tiling algo
   tiled = spacing 5 $ Tall nmaster delta ratio
   -- default nb of windows in the master pane
   nmaster = 1
   -- default proportion of screen occupied by master pane
   ratio = 1/2
   -- percent of screen to increment by when resizing panes
   delta = 5/100

-- keys bindings
delkeys :: XConfig l -> [(KeyMask, KeySym)]
delkeys XConfig {XMonad.modMask = modMask} = []

inskeys :: XConfig l -> [((KeyMask, KeySym), X())]
inskeys conf@(XConfig {XMonad.modMask = modMask}) =
   [((mod4Mask, xK_p), spawn "dmenu_run -fn 'snap:size=9:antialias=true' -h 15")]

-- Main config
myConfig = defaultConfig
   { terminal = "urxvt"
   , modMask = mod4Mask
   , layoutHook = avoidStruts $ myLayout
   , keys = customKeys delkeys inskeys
   }
