using Gtk.ShortNames, DataFrames, DefaultApplication, Mustache, Luxor

# Path to index logo
if Sys.iswindows()
    global indexImgPath =
        joinpath(dirname(Base.source_path()), "figures\\index_logo.png")
    global indexImgPathT =
        joinpath(dirname(Base.source_path()), "C:\\Windows\\Temp\\index_logo_temp.png")
end

if Sys.islinux()
    global indexImgPath =
        joinpath(dirname(Base.source_path()), "figures/index_logo.png")
    global indexImgPathT =
        joinpath(dirname(Base.source_path()), "/tmp/index_logo_temp.png")
end

function PIAssistantGUI()
    global ws, hs = screen_size()

    # Creates a temporary Image as index.
    Drawing(round(ws/3.5), round(hs/(3.5*0.563)), indexImgPathT)

    origin()
    background("white")

    img = readpng(indexImgPath)
    w = img.width
    h = img.height

    scale((ws/3.5)/w, (hs/3.5)/h)
    placeimage(img, -w/2, -h/2, 1)

    finish()
    preview()

    indexImg = Image()
    set_gtk_property!(indexImg, :file, indexImgPathT)

    winIndex = Window(indexImg)
    set_gtk_property!(winIndex, :decorated, false)
    set_gtk_property!(winIndex, :window_position, 3)
    set_gtk_property!(winIndex, :accept_focus, true)
    set_gtk_property!(winIndex, :width_request, round(ws/3.5))
    set_gtk_property!(winIndex, :height_request, round(hs/(3.5*0.563)))

    Gtk.showall(winIndex)

    sleep(2)
    destroy(winIndex)
end
