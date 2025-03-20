import webbrowser
from libqtile import bar, widget, hook, qtile
from libqtile.config import Screen
from colors import GruvboxDark

colors = GruvboxDark

widget_defaults = dict(
    font="hack nerd font",
    fontsize=14,
    padding=3,

    background=GruvboxDark[0]
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [

             widget.Image(
                 filename = "~/.config/qtile/icons/infinity-icon.png",
                 scale = "False",
                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm)},
                 ),

                widget.CurrentLayout(
                    foreground = GruvboxDark[1],
                    padding = 6,
                    ),
                widget.Spacer(length = 2),
                widget.GroupBox(
                     fontsize = 12,
                     margin_y = 5,
                     margin_x = 8,
                     padding_y = 0,
                     padding_x = 1,
                     borderwidth = 3,
                     active = GruvboxDark[8],
                     inactive = GruvboxDark[9],
                     rounded = False,
                     highlight_color = GruvboxDark[2],
                     highlight_method = "line",
                     this_current_screen_border = GruvboxDark[7],
                     this_screen_border = GruvboxDark[4],
                     other_current_screen_border = GruvboxDark[7],
                     other_screen_border = GruvboxDark[4],
                    ),

                widget.WidgetBox(
                        text_closed = '⏵',
                        text_open = '⏴',
                        close_button_location = 'right',
                        foreground = colors[9],
                        widgets = [
                        
                                widget.Sep(),
                        widget.CPU(
                            background=colors[9],
                             format = ' Cpu: {load_percent}%',
                            foreground = colors[1],
                             padding = 6, 
                             ),
                        widget.Sep( 
                            foreground = colors[1],
                            background=colors[9],
                                   ),
                        widget.Memory(
                                background=colors[9],
                                foreground = colors[1],
                                 padding = 6, 
                                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')},
                                 format = '{MemUsed: .0f}{mm}',
                                 fmt = '🖥  Mem: {} used',
                                 ),
                        widget.Sep( 
                            foreground = colors[1],
                            background=colors[9],
                                   ),
                        widget.DF(

                                background=colors[9],
                                 update_interval = 60,
                                foreground = colors[1],
                                 padding = 6, 
                                 mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e df')},
                                 partition = '/',
                                 #format = '[{p}] {uf}{m} ({r:.0f}%)',
                                 format = '{uf}{m} free',
                                 fmt = '🖴  Disk: {}',
                                 visible_on_warn = False,
                                 ),


                            ],
                        ),
                widget.Prompt(
                    font="hack nerd font",
                    fontsize=14,
                    padding=3,
                    ),
                widget.WindowName(
                    foreground = GruvboxDark[3],
                    padding = 6,
                    max_chars = 40
                    ),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                #widget.TextBox("default config", name="default"),
                #widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                widget.GenPollText(
                    update_interval = 300,
                    func = lambda: subprocess.check_output("printf $(uname -r)", shell=True, text=True),
                    foreground = GruvboxDark[4],
                    padding = 6,
                    fmt = '❤  {}',
                ),
                    widget.Cmus(),
                widget.KeyboardLayout(
                    configured_keyboards=['br'],
                    foreground = GruvboxDark[8],
                    padding = 6,
                    fmt = '⌨  Kbd: {}',
                ),
                widget.Volume(
                    foreground = GruvboxDark[9],
                    padding = 6,
                    fmt = '🕫  Vol: {}',
                    ),
                widget.Clock(
                    foreground = GruvboxDark[3],
                    padding = 6, 
                    format = "⏱  %a, %b %d - %H:%M",
                 ),
                    widget.Battery(
                         format="{char} {percent:2.0%} ({hour:d}:{min:02d})",
                    charge_char="",
                    discharge_char=" ",
                    full_char="",
                    empty_char="",
                    unknown_char="",
                    update_interval=60,
                    show_short_text=False,
                    foreground=colors[7],
                        ),

                widget.Systray(padding = 3),
                widget.QuickExit(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]
