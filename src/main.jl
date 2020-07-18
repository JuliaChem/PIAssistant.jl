# General Settings
if Sys.iswindows()
    # Icons path
    global ico1 = joinpath(dirname(Base.source_path()), "icons\\icon_new.ico")
    global ico2 = joinpath(dirname(Base.source_path()), "icons\\icon_pdf.ico")
    global ico3 = joinpath(dirname(Base.source_path()), "icons\\icon_close.ico")
    global ico4 = joinpath(dirname(Base.source_path()), "icons\\icon_settings.ico")
    global ico5 = joinpath(dirname(Base.source_path()), "icons\\icon_help.ico")
end

if Sys.islinux()
    # Icons path
    global ico1 = joinpath(dirname(Base.source_path()), "icons/icon_new.ico")
    global ico2 = joinpath(dirname(Base.source_path()), "icons/icon_pdf.ico")
    global ico3 = joinpath(dirname(Base.source_path()), "icons/icon_close.ico")
    global ico4 = joinpath(dirname(Base.source_path()), "icons/icon_settings.ico")
    global ico5 = joinpath(dirname(Base.source_path()), "icons/icon_help.ico")
end

function mainPI()
    # Measurement of screen size to allow compatibility to all screen devices
    global w, h = screen_size()

    # Main win
    mainPIWin = Window()
    # Properties for mainWin
    set_gtk_property!(mainPIWin, :title, "Process Intensification Assistant")
    set_gtk_property!(mainPIWin, :window_position, 3)
    set_gtk_property!(mainPIWin, :accept_focus, true)
    set_gtk_property!(mainPIWin, :resizable, false)
    set_gtk_property!(mainPIWin, :width_request, h * 1.0)
    set_gtk_property!(mainPIWin, :height_request, h * 0.70)
    set_gtk_property!(mainPIWin, :visible, false)

    ###############################################################################
    # Toolbar
    ################################################################################
    # Menu Icons
    newToolbar = ToolButton("")
    newToolbarImg = Image()
    set_gtk_property!(newToolbarImg, :file, ico1)
    set_gtk_property!(newToolbar, :icon_widget, newToolbarImg)
    set_gtk_property!(newToolbar, :label, "New")
    set_gtk_property!(newToolbar, :tooltip_markup, "New analysis")

    pdfToolbar = ToolButton("")
    pdfToolbarImg = Image()
    set_gtk_property!(pdfToolbarImg, :file, ico2)
    set_gtk_property!(pdfToolbar, :icon_widget, pdfToolbarImg)
    set_gtk_property!(pdfToolbar, :label, "Export")
    set_gtk_property!(pdfToolbar, :tooltip_markup, "Export report")

    settingsToolbar = ToolButton("")
    settingsToolbarImg = Image()
    set_gtk_property!(settingsToolbarImg, :file, ico4)
    set_gtk_property!(settingsToolbar, :icon_widget, settingsToolbarImg)
    set_gtk_property!(settingsToolbar, :label, "Settings")
    set_gtk_property!(settingsToolbar, :tooltip_markup, "Settings")


    closeToolbar = ToolButton("")
    closeToolbarImg= Image()
    set_gtk_property!(closeToolbarImg, :file, ico3)
    set_gtk_property!(closeToolbar, :icon_widget, closeToolbarImg)
    set_gtk_property!(closeToolbar, :label, "Close")
    set_gtk_property!(closeToolbar, :tooltip_markup, "Close")
    signal_connect(closeToolbar, :clicked) do widget
        destroy(mainPIWin)
    end

    helpToolbar = ToolButton("")
    helpToolbarImg= Image()
    set_gtk_property!(helpToolbarImg, :file, ico5)
    set_gtk_property!(helpToolbar, :icon_widget, helpToolbarImg)
    set_gtk_property!(helpToolbar, :label, "Help")
    set_gtk_property!(helpToolbar, :tooltip_markup, "Help")


    # Toolbar
    mainToolbar = Toolbar()
    set_gtk_property!(mainToolbar, :height_request, (h * 0.70)*0.10)
    set_gtk_property!(mainToolbar, :toolbar_style, 2)
    push!(mainToolbar, newToolbar)
    push!(mainToolbar, pdfToolbar)
    push!(mainToolbar, settingsToolbar)
    push!(mainToolbar, helpToolbar)
    push!(mainToolbar, closeToolbar)

    gridToolbar = Grid()
    set_gtk_property!(gridToolbar, :column_homogeneous, true)
    set_gtk_property!(gridToolbar, :row_homogeneous, false)

    frameToolbar = Frame()
    push!(frameToolbar, mainToolbar)
    gridToolbar[1, 1] = frameToolbar

    push!(mainPIWin, gridToolbar)
    Gtk.showall(mainPIWin)
end
