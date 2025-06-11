import pygetwindow as gw

for window in gw.getWindows():
    title = window.title
    if title:
        print(title)
