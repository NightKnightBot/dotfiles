import XMonad
import System.Exit (exitSuccess)
import qualified Data.Map as M
import qualified XMonad.StackSet as W

import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.ManageDocks (docks, avoidStruts)
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.Tabbed (tabbed, shrinkText, Theme(..))
import XMonad.Layout.ToggleLayouts (toggleLayouts, ToggleLayout(..))
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Util.SpawnOnce (spawnOnce)

------------------------------------------------------------------------
-- Layouts
------------------------------------------------------------------------

tiled = Tall 1 (3/100) (1/2)

tabTheme :: Theme
tabTheme = def { fontName = "xft:JetBrainsMono Nerd Font Mono:size=8" }

-- Fullscreen covers the bar (like i3); tiled/tabbed leave room for polybar.
myLayout = toggleLayouts (noBorders Full)
         $ avoidStruts (tiled ||| tabbed shrinkText tabTheme)

------------------------------------------------------------------------
-- Workspaces
------------------------------------------------------------------------

myWorkspaces :: [String]
myWorkspaces = map show [1 .. 10 :: Int]

------------------------------------------------------------------------
-- Startup (the exec lines from i3)
------------------------------------------------------------------------

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "dex --autostart --environment xmonad"
  spawnOnce "xss-lock --transfer-sleep-lock -- i3lock --nofork -e -i $HOME/dots/walls/blue-dunes.png"
  spawnOnce "xset s 300 5"
  spawnOnce "nm-applet"
  spawnOnce "picom"
  spawnOnce "copyq"
  spawnOnce "xwallpaper --zoom $HOME/dots/walls/win7/win7wallpaper.png"
  spawnOnce "dunst"
  spawnOnce "upower-notify"
  spawnOnce "polybar"
  spawnOnce "sxhkd"

------------------------------------------------------------------------
-- Helpers
------------------------------------------------------------------------

-- i3's "floating toggle"
toggleFloat :: Window -> X ()
toggleFloat w = windows $ \s ->
  if M.member w (W.floating s)
    then W.sink w s
    else W.float w (W.RationalRect 0.15 0.15 0.7 0.7) s

reloadXmonad :: X ()
reloadXmonad = spawn "xmonad --recompile && xmonad --restart"

------------------------------------------------------------------------
-- Keybindings
------------------------------------------------------------------------

myKeys :: [(String, X ())]
myKeys =
  [ -- reload / restart / exit
  , ("M-S-r", reloadXmonad)
  , ("M-S-q", io exitSuccess)

    -- kill
  , ("M-q", kill)

    -- focus (cycles through the window order; works well with tabs)
  , ("M-h",       windows W.focusUp)
  , ("M-k",       windows W.focusUp)
  , ("M-j",       windows W.focusDown)
  , ("M-l",       windows W.focusDown)
  , ("M-<Left>",  windows W.focusUp)
  , ("M-<Up>",    windows W.focusUp)
  , ("M-<Down>",  windows W.focusDown)
  , ("M-<Right>", windows W.focusDown)

    -- move (swap with neighbour in the window order)
  , ("M-S-h",       windows W.swapUp)
  , ("M-S-k",       windows W.swapUp)
  , ("M-S-j",       windows W.swapDown)
  , ("M-S-l",       windows W.swapDown)
  , ("M-S-<Left>",  windows W.swapUp)
  , ("M-S-<Up>",    windows W.swapUp)
  , ("M-S-<Down>",  windows W.swapDown)
  , ("M-S-<Right>", windows W.swapDown)

    -- layout
  , ("M-f", sendMessage ToggleLayout)  -- fullscreen <-> previous layout
  , ("M-w", sendMessage NextLayout)    -- tiled <-> tabbed

    -- floating
  , ("M-S-<Backspace>", withFocused toggleFloat)
  ]
  ++
  -- workspaces: M-1..9, M-0 (=10) to view, M-S-<n> to send window there
  [ ("M-" ++ m ++ k, windows $ f ws)
  | (ws, k) <- zip myWorkspaces (map show ([1 .. 9] ++ [0 :: Int]))
  , (f, m)  <- [(W.greedyView, ""), (W.shift, "S-")]
  ]

-- xmonad defaults that would grab keys sxhkd probably wants
myRemovedKeys :: [String]
myRemovedKeys =
  [ "M-<Space>"       -- rofi (sxhkd)
  , "M-<Return>"      -- alacritty (sxhkd)
  , "M-m"             -- rofimoji (sxhkd)
  , "M-S-e"           -- thunar (sxhkd)
  , "M-S-<Return>"    -- default terminal, unused
  , "M-p"             -- passmenu (sxhkd)
  ]

------------------------------------------------------------------------
-- Main
------------------------------------------------------------------------

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . docks
     $ def
         { modMask            = mod4Mask
         , terminal           = "alacritty"
         , workspaces         = myWorkspaces
         , layoutHook         = myLayout
         , startupHook        = myStartupHook
         , borderWidth        = 2
         , focusFollowsMouse  = True
         }
       `additionalKeysP` myKeys
       `removeKeysP`     myRemovedKeys
