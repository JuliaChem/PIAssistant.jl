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
    global wSc, hSc = screen_size()

    img = readpng(indexImgPath)
    wImg = img.width
    hImg = img.height

    # Ratio for proportion
    imgP = hImg/wImg

    x = round((hSc/2)/imgP)/wImg
    y = round(hSc/2)/hImg

    # Creates a temporary Image as index.
    Drawing(round((hSc/2)/imgP)+60, round(hSc/2)+60, indexImgPathT)

    origin()
    background("white")

    scale(x, y)
    placeimage(img, -wImg/2, -hImg/2, 1)
    finish()
    preview()

    indexImg = Image()
    set_gtk_property!(indexImg, :file, indexImgPathT)

    winIndex = Window(indexImg)
    set_gtk_property!(winIndex, :decorated, false)
    set_gtk_property!(winIndex, :window_position, 3)
    set_gtk_property!(winIndex, :accept_focus, true)
    set_gtk_property!(winIndex, :width_request, round((hSc/2)/imgP)+60)
    set_gtk_property!(winIndex, :height_request, round(hSc/2)+60)

    Gtk.showall(winIndex)

    sleep(2)
    destroy(winIndex)

    mainPI()
end
