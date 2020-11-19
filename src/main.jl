# General Settings
if Sys.iswindows()
    # Icons path on Windows
    global ico1 = joinpath(dirname(Base.source_path()), "icons\\icon_new.ico")
    global ico2 = joinpath(dirname(Base.source_path()), "icons\\icon_pdf.ico")
    global ico3 = joinpath(dirname(Base.source_path()), "icons\\icon_close.ico")
    global ico4 = joinpath(dirname(Base.source_path()), "icons\\icon_settings.ico")
    global ico5 = joinpath(dirname(Base.source_path()), "icons\\icon_help.ico")
    global ico6 = joinpath(dirname(Base.source_path()), "icons\\icon_open.ico")
    global ico7 = joinpath(dirname(Base.source_path()), "icons\\icon_save.ico")
end

if Sys.islinux()
    # Icons path on Linux
    global ico1 = joinpath(dirname(Base.source_path()), "icons/icon_new.ico")
    global ico2 = joinpath(dirname(Base.source_path()), "icons/icon_pdf.ico")
    global ico3 = joinpath(dirname(Base.source_path()), "icons/icon_close.ico")
    global ico4 = joinpath(dirname(Base.source_path()), "icons/icon_settings.ico")
    global ico5 = joinpath(dirname(Base.source_path()), "icons/icon_help.ico")
    global ico6 = joinpath(dirname(Base.source_path()), "icons/icon_open.ico")
    global ico7 = joinpath(dirname(Base.source_path()), "icons/icon_save.ico")
end

# TODO: check compatibility to macOS

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
    closeToolbarImg = Image()
    set_gtk_property!(closeToolbarImg, :file, ico3)
    set_gtk_property!(closeToolbar, :icon_widget, closeToolbarImg)
    set_gtk_property!(closeToolbar, :label, "Close")
    set_gtk_property!(closeToolbar, :tooltip_markup, "Close")
    signal_connect(closeToolbar, :clicked) do widget
        destroy(mainPIWin)
    end

    helpToolbar = ToolButton("")
    helpToolbarImg = Image()
    set_gtk_property!(helpToolbarImg, :file, ico5)
    set_gtk_property!(helpToolbar, :icon_widget, helpToolbarImg)
    set_gtk_property!(helpToolbar, :label, "Help")
    set_gtk_property!(helpToolbar, :tooltip_markup, "Help")

    openToolbar = ToolButton("")
    openToolbarImg = Image()
    set_gtk_property!(openToolbarImg, :file, ico6)
    set_gtk_property!(openToolbar, :icon_widget, openToolbarImg)
    set_gtk_property!(openToolbar, :label, "Open")
    set_gtk_property!(openToolbar, :tooltip_markup, "Open")

    saveToolbar = ToolButton("")
    saveToolbarImg = Image()
    set_gtk_property!(saveToolbarImg, :file, ico7)
    set_gtk_property!(saveToolbar, :icon_widget, saveToolbarImg)
    set_gtk_property!(saveToolbar, :label, "Save")
    set_gtk_property!(saveToolbar, :tooltip_markup, "Save")

    # Toolbar
    mainToolbar = Toolbar()
    set_gtk_property!(mainToolbar, :height_request, (h * 0.70) * 0.10)
    set_gtk_property!(mainToolbar, :toolbar_style, 2)
    push!(mainToolbar, newToolbar)
    push!(mainToolbar, SeparatorToolItem())
    push!(mainToolbar, openToolbar)
    push!(mainToolbar, pdfToolbar)
    push!(mainToolbar, saveToolbar)
    push!(mainToolbar, SeparatorToolItem())
    push!(mainToolbar, settingsToolbar)
    push!(mainToolbar, helpToolbar)
    push!(mainToolbar, SeparatorToolItem())
    push!(mainToolbar, closeToolbar)

    # Main grid
    mainGrid = Grid()
    set_gtk_property!(mainGrid, :column_homogeneous, true)
    set_gtk_property!(mainGrid, :row_homogeneous, false)

    gridToolbar = Grid()
    set_gtk_property!(gridToolbar, :column_homogeneous, true)
    set_gtk_property!(gridToolbar, :row_homogeneous, false)

    frameToolbar = Frame()
    push!(frameToolbar, mainToolbar)
    gridToolbar[1, 1] = frameToolbar

    bGrid = Grid()
    set_gtk_property!(bGrid, :column_spacing, 0)
    set_gtk_property!(bGrid, :row_spacing, 0)
    set_gtk_property!(bGrid, :margin_top, 0)
    set_gtk_property!(bGrid, :margin_bottom, 0)
    set_gtk_property!(bGrid, :margin_left, 0)
    set_gtk_property!(bGrid, :margin_right, 0)

    # Main notebook
    mainNotebook = Notebook()

    # Height for notebook
    hNb = (h * 0.70) - (h * 0.70) * 0.10 - 40

    ###############################################################################
    # Base case design
    ###############################################################################
    settingFrame = Frame()
    set_gtk_property!(settingFrame, :height_request, hNb)
    set_gtk_property!(settingFrame, :width_request, h)

    settingGrid = Grid()
    set_gtk_property!(settingGrid, :column_spacing, 10)
    set_gtk_property!(settingGrid, :row_spacing, 10)
    set_gtk_property!(settingGrid, :margin_top, 10)
    set_gtk_property!(settingGrid, :margin_bottom, 10)
    set_gtk_property!(settingGrid, :margin_left, 10)
    set_gtk_property!(settingGrid, :margin_right, 10)

    # Base case design frames
    settingFrameLeft = Frame("Base Case Design")
    set_gtk_property!(settingFrameLeft, :height_request, hNb - 20)
    set_gtk_property!(settingFrameLeft, :width_request, (h / 2) - 15)
    set_gtk_property!(settingFrameLeft, :label_xalign, 0.50)

    settingFrameRigth = Frame("Intensification Criterion")
    set_gtk_property!(settingFrameRigth, :height_request, hNb - 20)
    set_gtk_property!(settingFrameRigth, :width_request, (h / 2) - 15)
    set_gtk_property!(settingFrameRigth, :label_xalign, 0.50)

    settingGrid[1, 1] = settingFrameLeft
    settingGrid[2, 1] = settingFrameRigth
    push!(settingFrame, settingGrid)

    ###############################################################################
    # Results frame
    ###############################################################################
    resultsFrame = Frame()
    set_gtk_property!(resultsFrame, :height_request, hNb)
    set_gtk_property!(resultsFrame, :width_request, h)

    push!(mainNotebook, settingFrame, "Settings")
    push!(mainNotebook, resultsFrame, "Results")

    bGrid[1, 1] = mainNotebook

    mainGrid[1, 1] = gridToolbar
    mainGrid[1, 2] = bGrid

    push!(mainPIWin, mainGrid)
    Gtk.showall(mainPIWin)
end
