import webbrowser
from libqtile import bar, widget, hook, qtile
from libqtile.config import Screen
from theme import gruvbox_dark

widget_defaults = dict(
    font="Hack Nerd Font",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(),
                widget.Spacer(length=10),
                widget.GroupBox(
                    borderwidth=1,
                    disable_drag=True,
                    font="Hack",
                    highlight_method="text",
                    active=gruvbox_dark["foreground"],
                    this_current_screen_border=gruvbox_dark["yellow"],
                ),
                widget.WindowName(),
                widget.Spacer(length=20),
                widget.WidgetBox(
                    widgets=[
                        widget.CPU(fmt="{}"),
                        widget.Memory(fmt=" {} "),
                        widget.ThermalSensor(fmt="  {} ", font="Hack Nerd Font"),
                    ],
                ),
                widget.Systray(),
                widget.Spacer(length=10),
                widget.Sep(),
                widget.Volume(fmt=" 墳 {}", font="Hack Nerd Font"),
                widget.Spacer(
                    length=10,
                ),
                widget.Sep(),
                widget.Spacer(length=10),
                widget.OpenWeather(
                    fmt=" {} ",
                    font="Hack Nerd Font",
                    location="Florianopolis",
                    format="fln: {main_temp} °{units_temperature}",
                    mouse_callbacks={
                        "Button1": lambda: webbrowser.open_new_tab(
                            "https://wttr.in/florianopolis"
                        )
                    },
                ),
                widget.Spacer(length=10),
                widget.Sep(),
                widget.Spacer(length=10),
                widget.KeyboardLayout(
                    configured_keyboards=("br", "us"),
                    fmt=" {}",
                    font="Hack Nerd Font",
                ),
                widget.Spacer(length=10),
                widget.Sep(),
                widget.Battery(
                    format=" {char} {percent:2.0%} {hour:d}:{min:02d}/{watt:.2f}W",
                    charge_char="",
                    discharge_char="",
                    font="Hack Nerd Font",
                    empty_char="",
                    full_char="",
                    notify_bellow=20,
                    show_short_text=False,
                ),
                widget.Spacer(length=10),
                widget.Sep(),
                widget.Spacer(length=10),
                widget.Clock(
                    format="%H:%M:%S",
                    fmt=" {} ",
                    font="Hack Nerd Font",
                    mouse_callbacks={
                        "Button1": lambda: webbrowser.open_new_tab(
                            "https://calendar.google.com/calendar/u/0/r"
                        )
                    },
                ),
                widget.Clock(
                    format="%h %d %Y",
                    fmt=" {}",
                    font="Hack Nerd Font",
                    mouse_callbacks={
                        "Button1": lambda: webbrowser.open_new_tab(
                            "https://calendar.google.com/calendar/u/0/r"
                        )
                    },
                ),
                widget.Spacer(length=10),

            ],
            24,
            background=gruvbox_dark["background"],
            border_width=[0, 0, 0, 0],
            margin = 4,
            border_radius = 4
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]
