palette.update({

            # Not Sure
            "focused selectable": ("black", "dark cyan"),
            "focused sidebar": ("black", "light gray", "underline"),
            
            #Variables
            "variables": ("white", "default"),
            "var label": ("light cyan", "default"),
            "var value": ("white", "default"),
            "focused var label": ("black", "light gray"),
            "focused var value": ("black", "light gray"),
            
            #Stack
            "stack": ("white", "default"),
            "frame name": ("light cyan", "default"),
            "frame class": ("light cyan", "default"),
            "frame location": ("white", "default"),

            "current frame name": ("light cyan","default"),
            "current frame class": ("light cyan", "default"),
            "current frame location": ("white", "default"),

            "focused frame name": ("black", "light gray"),
            "focused frame class": (add_setting("white", "bold"), "light gray"),
            "focused frame location": ("black", "light gray"),

            "focused current frame name": ("black", "light gray"),
            "focused current frame class": ("black", "light gray"),
            "focused current frame location": ("black", "light gray"),

            #Breakpoints 
            "breakpoint marker": ("dark red", "default"),
            "breakpoint": ("default", "default"),
            "breakpoint source": ("light red", "default"),
            "focused breakpoint": ("black", "light gray"),
            "focused current breakpoint": ("black", "light gray"),
            "current breakpoint": ("light cyan", "default"),

            "search box": ("default", "default"),
            
            #Source
            "source": ("white", "default"),
            "highlighted source": ("white", "light cyan"),
            "current source": ("black", "light gray"),
            "focused source": ("black", "light gray"),
            "current focused source": ("black", "light gray"),

            "line number": ("light cyan", "default"),
            "keyword": ("dark cyan", "default"),
            "name": ("white", "default"),
            "literal": ("dark cyan", "default"),
            "string": ("light cyan", "default"),
            "doublestring": ("light cyan", "default"),
            "singlestring": ("light cyan", "default"),
            "docstring": ("light cyan", "default"),
            "backtick": ("light green", "default"),
            "punctuation": ("white", "default"),
            "comment": ("light gray", "default"),
            "classname": ("dark cyan", "default"),
            "funcname": ("light cyan", "default"),


            # {{{ shell

            "command line edit": ("white", "default"),
            "command line prompt": (add_setting("white", "bold"), "default"),

            "command line output": (add_setting("white", "bold"), "default"),
            "command line input": (add_setting("white", "bold"), "default"),
            "command line error": (add_setting("light red", "bold"), "default"),

            "focused command line output": ("black", "light gray"),
            "focused command line input": (add_setting("white", "bold"), "light gray"),
            "focused command line error": ("black", "light gray"),

            "command line clear button": (add_setting("white", "bold"), "default"),
            "command line focused button": ("black", "light gray"), # White
            # doesn't work in curses mode

            # }}}

        })
