# i3wm Reference Guide

A quick reference for debugging, testing, and understanding this i3 configuration.

---

## Configuration Structure

```
~/.config/i3/
├── config              # Main entry point (includes all modules)
├── keybindings.conf    # Key bindings
├── window.conf         # Window rules (for_window, assign)
├── workspace.conf      # Workspace definitions & assignments
├── gaps.conf           # Gaps (inner/outer, smart gaps)
├── bar.conf            # i3bar / i3status configuration
├── autostart.conf      # Programs to launch on startup
├── gaps.conf           # Gap settings
├── themes/
│   ├── doom-tomorrow-night.conf
│   └── gruvbox.conf
├── status.toml         # i3status-rs configuration (if used)
└── i3-reference.md     # This file
```

**Include Order (matters):**
1. Theme (colors) — must be first so variables exist
2. Autostart
3. Keybindings
4. Window rules
5. Workspace rules
6. Gaps
7. Bar

---

## Testing & Validating Configuration

### Syntax Check (Dry Run)
```bash
# Validate config without restarting
i3 -C -c ~/.config/i3/config

# Or shorthand
i3 --config-check
```
**Exit code 0 = valid.** Errors show file, line, and offending token.

### Reload Config (Live)
```bash
# Reload in-place (preserves windows)
i3-msg reload

# Or via keybinding (default: $mod+Shift+r)
```

### Restart i3 (Full Reset)
```bash
# Restarts i3, re-reads config, keeps windows
i3-msg restart

# Or via keybinding ($mod+Shift+e → restart)
```

---

## Debugging Commands

### Inspect Window Properties (WM_CLASS, role, type)
```bash
# Click target window after running
xprop WM_CLASS
xprop WM_WINDOW_ROLE
xprop _NET_WM_WINDOW_TYPE
```

**Typical output:**
```
WM_CLASS(STRING) = "blueman-manager", "Blueman-manager"
WM_WINDOW_ROLE(STRING) = "preferences"
_NET_WM_WINDOW_TYPE(ATOM) = _NET_WM_WINDOW_TYPE_DIALOG
```

Use the **first string** (instance) or **second string** (class) in `for_window` rules:
```i3
for_window [class="Blueman-manager"] floating enable
for_window [instance="blueman-manager"] floating enable
```

### List All Window Criteria
```bash
# See all properties of the clicked window
xprop
```

### Query i3 Tree (All Windows/Containers)
```bash
# JSON output of entire tree
i3-msg -t get_tree

# Pretty-printed (requires jq)
i3-msg -t get_tree | jq '.nodes[] | recurse(.nodes[]) | select(.window_properties?) | {class: .window_properties.class, instance: .window_properties.instance, title: .name, floating: .floating}'

# Only floating windows
i3-msg -t get_tree | jq '.. | select(.floating == "user_on" or .floating == "auto_on") | {class: .window_properties.class, title: .name}'
```

### Get Workspaces
```bash
i3-msg -t get_workspaces
```

### Get Version & Info
```bash
i3 --version
i3-msg -t get_version
```

### Simulate Keybindings (Test Without Pressing Keys)
```bash
# Execute a binding command directly
i3-msg 'workspace 2'
i3-msg 'exec alacritty'
i3-msg 'floating toggle'
```

---

## Window Rules (`for_window`) — Debugging Tips

### Rule Priority
Rules are evaluated **top to bottom**. First match wins for each property.

```i3
# This applies to ALL windows (catch-all)
for_window [class="^.*"] border pixel 2

# More specific rules AFTER can override border, floating, etc.
for_window [class="pavucontrol"] floating enable, border none
```

### Common Criteria
| Criteria | Example | Matches |
|----------|---------|---------|
| `class` | `[class="Firefox"]` | WM_CLASS second string |
| `instance` | `[instance="firefox"]` | WM_CLASS first string |
| `window_role` | `[window_role="preferences"]` | WM_WINDOW_ROLE |
| `window_type` | `[window_type="dialog"]` | _NET_WM_WINDOW_TYPE |
| `title` | `[title="^Open File"]` | Window title (regex) |
| `con_id` | `[con_id="123456"]` | Internal container ID |

### Regex in Criteria
- Use PCRE regex: `[class=".*[Cc]alculator.*"]`
- Anchors: `^` (start), `$` (end)
- Case-insensitive: `(?i)` prefix or character classes `[Cc]`

### Multiple Commands in One Rule
```i3
for_window [class="pavucontrol"] \
    floating enable, \
    resize set 800 600, \
    move position center, \
    sticky enable, \
    border none
```

### Debug Why a Rule Isn't Applying
1. Check exact class/instance with `xprop WM_CLASS`
2. Verify rule appears **after** any catch-all that might conflict
3. Test with `i3-msg -t get_tree | jq` to see current floating state
4. Reload config: `i3-msg reload`

---

## Useful Keybindings (Default in This Config)

| Binding | Action |
|---------|--------|
| `$mod+Enter` | Open terminal |
| `$mod+d` | Launcher (rofi) |
| `$mod+Shift+q` | Kill window |
| `$mod+Shift+r` | Reload config |
| `$mod+Shift+e` | Exit menu (lock, logout, reboot…) |
| `$mod+f` | Fullscreen toggle |
| `$mod+Shift+space` | Floating toggle |
| `$mod+[1-9]` | Switch workspace |
| `$mod+Shift+[1-9]` | Move window to workspace |
| `$mod+arrows/hjkl` | Focus / move / resize |
| `$mod+r` | Resize mode |

---

## Logging & Error Messages

### i3 Log Location
```bash
# Default: ~/.local/share/i3/log or ~/.i3/i3log
# Or via systemd journal if started that way
journalctl --user -u i3 -f
```

### Enable Debug Logging (Temporary)
```bash
# Start i3 with verbose logging to stdout
i3 -V -d all 2>&1 | tee ~/i3-debug.log
```
**Don't run this inside an existing i3 session.**

---

## Common Issues & Fixes

| Symptom | Likely Cause | Fix |
|---------|--------------|-----|
| Config error on line X | Syntax typo, unknown keyword | Run `i3 -C` to see exact error |
| Window not floating | Wrong class/instance, rule order | Check `xprop WM_CLASS`, move rule lower |
| Gaps not working | `gaps.conf` not included or i3-gaps not installed | Verify include, install `i3-gaps` |
| Bar not showing | `bar.conf` issue, i3status not running | Check `i3-msg -t get_bar_config` |
| Keybinding not working | Conflicting binding, wrong modifier | Check `i3-msg -t get_binding_state` |
| Workspace assignment fails | Workspace name mismatch | Use `$wsN` variables defined in workspace.conf |

---

## Reload Workflow (Recommended)

```bash
# 1. Edit config
vim ~/.config/i3/window.conf

# 2. Validate
i3 -C -c ~/.config/i3/config

# 3. If valid, reload live
i3-msg reload

# 4. Test the change (open target app, check behavior)
```

---

## Resources

- **Official docs:** https://i3wm.org/docs/userguide.html
- **Reference card:** https://i3wm.org/docs/refcard.html
- **i3-msg IPC:** https://i3wm.org/docs/ipc.html
- **Criteria reference:** https://i3wm.org/docs/userguide.html#window_criteria