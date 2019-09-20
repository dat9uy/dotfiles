import XMonad
import XMonad.Config.Gnome
import XMonad.Util.EZConfig

import XMonad.Actions.CycleWS

import XMonad.Hooks.ManageDocks
import XMonad.Util.Scratchpad

import qualified XMonad.StackSet as W

myManageHook = manageDocks <+> manageScratchPad

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
    where
        h = 0.4
        w = 1
        t = 0
        l = 1 - w

main = xmonad $ gnomeConfig
    { terminal = "alacritty"
    , manageHook = myManageHook
    }
    `additionalKeysP`
        [("M-p", spawn "$(rofi -show run)")
        ,("M-<Down>", nextWS)
        ,("M-<Up>", prevWS)
        ,("M-y", scratchpadSpawnActionTerminal "stterm")
        ]
