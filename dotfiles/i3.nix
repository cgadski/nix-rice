{modkey, term, font}:
''
# modkey
set $mod ${modkey}

# display settings
font pango:${font}
new_window pixel 3

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# easy access commands
bindsym $mod+Return exec ${term}
bindsym $mod+Shift+q kill
bindsym $mod+d exec dmenu_run

# change focus
bindsym $mod+j focus left
bindsym $mod+k focus down
bindsym $mod+l focus up
bindsym $mod+semicolon focus right

# move focused window
bindsym $mod+Shift+j move left
bindsym $mod+Shift+k move down
bindsym $mod+Shift+l move up
bindsym $mod+Shift+semicolon move right

# cursor keys
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# DO THE SPLITS
bindsym $mod+h split h
bindsym $mod+v split v

# window states
bindsym $mod+f fullscreen toggle
bindsym $mod+Shift+space floating toggle

# container layouts
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# focus mode (tiling / floating)
bindsym $mod+space focus mode_toggle

# focus parents and children 
bindsym $mod+a focus parent
bindsym $mod+z focus child

# workspace switching
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10
bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

# reload, restart, quit
bindsym $mod+Shift+c reload
bindsym $mod+Shift+r restart
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'End X session?' -b 'yes' 'i3-msg exit'"

# resize window 
bindsym $mod+r mode "resize"

mode "resize" {
  bindsym j resize shrink width 10 px or 10 ppt
  bindsym k resize grow height 10 px or 10 ppt
  bindsym l resize shrink height 10 px or 10 ppt
  bindsym semicolon resize grow width 10 px or 10 ppt

  # woeful arrow keys
  bindsym Left resize shrink width 10 px or 10 ppt
  bindsym Down resize grow height 10 px or 10 ppt
  bindsym Up resize shrink height 10 px or 10 ppt
  bindsym Right resize grow width 10 px or 10 ppt

  # exit mode
  bindsym Return mode "default"
  bindsym Escape mode "default"
}

# runs the i3bar
bar { }
''
