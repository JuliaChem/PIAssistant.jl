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

    ####################################################################################################################
    # Toolbar
    ####################################################################################################################
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
    set_gtk_property!(pdfToolbar, :sensitive, false)

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

    signal_connect(mainPIWin, "key-press-event") do widget, event
        if event.keyval == 65307
            destroy(mainPIWin)
        end
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
    set_gtk_property!(saveToolbar, :sensitive, false)

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

    ####################################################################################################################
    # Setting frame
    ####################################################################################################################
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

    settingGridLeft = Grid()
    set_gtk_property!(settingGridLeft, :row_spacing, 10)

    settingGridRight = Grid()
    set_gtk_property!(settingGridLeft, :row_spacing, 10)

    ####################################################################################################################
    # Base Case Design
    ####################################################################################################################
    global idxBC = 1
    global idxEq = zeros(1, idxBC)

    baseCaseFrame = Frame(" Base Case Design ")
    set_gtk_property!(baseCaseFrame, :height_request, (hNb - 30)/2)
    set_gtk_property!(baseCaseFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(baseCaseFrame, :label_xalign, 0.50)

    baseCaseGrid = Grid()
    set_gtk_property!(baseCaseGrid, :column_spacing, 10)
    set_gtk_property!(baseCaseGrid, :row_spacing, 10)
    set_gtk_property!(baseCaseGrid, :margin_top, 5)
    set_gtk_property!(baseCaseGrid, :margin_bottom, 10)
    set_gtk_property!(baseCaseGrid, :margin_left, 10)
    set_gtk_property!(baseCaseGrid, :margin_right, 10)

    # TreeView for Base Case Design
    wBC = (h / 2) - 15
    baseCaseFrameTree = Frame()
    set_gtk_property!(baseCaseFrameTree, :height_request, (hNb - 30)/2 - 75)
    set_gtk_property!(baseCaseFrameTree, :width_request, wBC - 20)
    baseCaseScroll = ScrolledWindow()
    push!(baseCaseFrameTree, baseCaseScroll)

    # Table for Case Design
    baseCaseList = ListStore(String, String, String, String, String)

    # Visual Table for Case Design
    baseCaseTreeView = TreeView(TreeModel(baseCaseList))
    set_gtk_property!(baseCaseTreeView, :reorderable, true)
    set_gtk_property!(baseCaseTreeView, :enable_grid_lines, 3)
    set_gtk_property!(baseCaseTreeView, :activate_on_single_click, true)
    selBC = Gtk.GAccessor.selection(baseCaseTreeView)
    selBC = Gtk.GAccessor.mode(selBC, Gtk.GConstants.GtkSelectionMode.SINGLE)

    # Set selectable
    selmodelBaseCase = G_.selection(baseCaseTreeView)

    renderTxt1 = CellRendererText()
    renderTxt2 = CellRendererText()
    set_gtk_property!(renderTxt1, :editable, true)
    set_gtk_property!(renderTxt2, :editable, false)

    c1 = TreeViewColumn("ID", renderTxt2, Dict([("text", 0)]))
    c2 = TreeViewColumn("Name", renderTxt1, Dict([("text", 1)]))
    c3 = TreeViewColumn("Equipments", renderTxt2, Dict([("text", 2)]))
    c4 = TreeViewColumn("Criterion", renderTxt2, Dict([("text", 3)]))
    c5 = TreeViewColumn("Status", renderTxt2, Dict([("text", 4)]))

    signal_connect(renderTxt1, "edited") do widget, path, text
        idxTree = parse(Int, path)

        if baseCaseList[idxTree + 1, 2] != text
            t = zeros(1, length(baseCaseList))
            for i=1:length(baseCaseList)
                t[i] = text == baseCaseList[i,2]
            end

            if sum(t) == 1
                warn_dialog("Name for base case design is already in use!", mainPIWin)
            else
                baseCaseList[idxTree + 1, 2] = text
                currentID = selected(selmodelBaseCase)
                set_gtk_property!(equipmentFrame, :label, " Equipments for $(baseCaseList[currentID, 2]) ")
            end
        end
    end

    signal_connect(baseCaseTreeView, :row_activated) do widget, path, column
        currentID = selected(selmodelBaseCase)
        set_gtk_property!(equipmentFrame, :label, " Equipments for $(baseCaseList[currentID, 2]) ")
        set_gtk_property!(addEq, :sensitive, true)
    end

    # Allows to select rows
    for c in [c1, c2, c3, c4, c5]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(baseCaseTreeView, c1, c2, c3, c4, c5)
    push!(baseCaseScroll, baseCaseTreeView)

    baseCaseGrid[1:3, 1] = baseCaseFrameTree

    # Buttons for base case design
    addBC = Button("Add")
    set_gtk_property!(addBC, :width_request, (wBC - 5*10)/4)
    signal_connect(addBC, :clicked) do widget
        global idxBC

        # Set default name
        baseCaseName = @sprintf("Base Case_%i", idxBC)

        if length(baseCaseList) == 0
            push!(baseCaseList, (length(baseCaseList) + 1, baseCaseName, "Incomplete", "Incomplete", "Incomplete"))
            set_gtk_property!(clearBC, :sensitive, true)
            set_gtk_property!(deleteBC, :sensitive, true)
            set_gtk_property!(saveToolbar, :sensitive, true)
            set_gtk_property!(pdfToolbar, :sensitive, true)
            global idxBC += 1
            global idxEq = zeros(1, idxBC)
        else
            t = zeros(1, length(baseCaseList))
            push!(baseCaseList, (length(baseCaseList) + 1, baseCaseName, "Incomplete", "Incomplete", "Incomplete"))
            set_gtk_property!(clearBC, :sensitive, true)
            set_gtk_property!(deleteBC, :sensitive, true)
            set_gtk_property!(saveToolbar, :sensitive, true)
            set_gtk_property!(pdfToolbar, :sensitive, true)
            global idxBC += 1
            global idxEq = zeros(1, idxBC)
        end
    end

    deleteBC = Button("Delete")
    set_gtk_property!(deleteBC, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(deleteBC, :sensitive, false)
    signal_connect(deleteBC, :clicked) do widget
        if hasselection(selBC)
            currentID = selected(selBC)
            deleteat!(baseCaseList, currentID)

            if length(baseCaseList)==0
                global idxBC = 1
                set_gtk_property!(clearBC, :sensitive, false)
                set_gtk_property!(deleteBC, :sensitive, false)
                set_gtk_property!(saveToolbar, :sensitive, false)
                set_gtk_property!(pdfToolbar, :sensitive, false)
                set_gtk_property!(addEq, :sensitive, false)
                set_gtk_property!(equipmentFrame, :label, " Equipments ")
            end
            global idxEq = zeros(1, idxBC)
        end
    end

    clearBC = Button("Clear")
    set_gtk_property!(clearBC, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearBC, :sensitive, false)
    signal_connect(clearBC, :clicked) do widget
        empty!(baseCaseList)
        set_gtk_property!(clearBC, :sensitive, false)
        set_gtk_property!(deleteBC, :sensitive, false)
        set_gtk_property!(saveToolbar, :sensitive, false)
        set_gtk_property!(pdfToolbar, :sensitive, false)
        set_gtk_property!(addEq, :sensitive, false)
        set_gtk_property!(equipmentFrame, :label, " Equipments ")
        global idxBC = 1
    end

    baseCaseGrid[1, 2] = addBC
    baseCaseGrid[2, 2] = deleteBC
    baseCaseGrid[3, 2] = clearBC

    push!(baseCaseFrame, baseCaseGrid)

    ####################################################################################################################
    # Equipments
    ####################################################################################################################
    global listEqPhenomena = DataFrames.DataFrame(ID = Float64[], Name = String[], Phenomena = Array[])

    # Add avilable aquipments and phenomenas
    push!(listEqPhenomena, (1, "Batch Reactor", ["M" "R" "H/C"]))
    push!(listEqPhenomena, (2, "Semi-Batch Reactor", ["M" "R" "H/C"]))
    push!(listEqPhenomena, (3, "CSTR Reactor", ["M" "R" "H/C"]))
    push!(listEqPhenomena, (4, "PFR Reactor", ["M" "R" "H/C"]))
    push!(listEqPhenomena, (5, "Pack-Bed Reactor", ["M" "R" "H/C"]))
    push!(listEqPhenomena, (6, "Flash Column", ["2phM", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (7, "Distillation Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (8, "Azeotropic Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (9, "Extractive Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (10, "Absorption Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (11, "Stripping Column", ["2phM", "H", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (12, "Crystallization", ["2phM", "C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (13, "Liquid-Liquid Extraction", ["M", " PC", "PS"]))
    push!(listEqPhenomena, (14, "Membrane Pervaporation", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (15, "Membrane Reactor", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (16, "Reactive Distillation", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (17, "Divided Wall Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (18, "Reactive Divided Wall Column", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (19, "Azeotropic Column with Reaction", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (20, "Azeotropic Divided Wall Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (21, "Azeotropic Divided Wall Column with Reaction", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (22, "Extractive Column with Reaction", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (23, "Extractive Divided Wall Column", ["2phM", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (24, "Extractive Divided Wall Column with Reaction", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (25, "Absorption Column witn Reaction", ["2phM", "R", "H/C", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (26, "Stripping Column with Reaction", ["2phM", "H", "PC", "PT", "PS"]))
    push!(listEqPhenomena, (27, "Liquid-Liquid Extraction with Reaction", ["M", "R", "PC", "PS"]))
    push!(listEqPhenomena, (28, "Reactive Crystallization", ["2phM", "R", "C", "PC", "PT", "PS"]))

    equipmentFrame = Frame(" Equipments ")
    set_gtk_property!(equipmentFrame, :height_request, (hNb - 30)/2)
    set_gtk_property!(equipmentFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(equipmentFrame, :label_xalign, 0.50)

    equipmentGrid = Grid()
    set_gtk_property!(equipmentGrid, :column_spacing, 10)
    set_gtk_property!(equipmentGrid, :row_spacing, 10)
    set_gtk_property!(equipmentGrid, :margin_top, 5)
    set_gtk_property!(equipmentGrid, :margin_bottom, 10)
    set_gtk_property!(equipmentGrid, :margin_left, 10)
    set_gtk_property!(baseCaseGrid, :margin_right, 10)

    # TreeView for Base Case Design
    wBC = (h / 2) - 15
    equipmentFrameTree = Frame()
    set_gtk_property!(equipmentFrameTree, :height_request, (hNb - 30)/2 - 75)
    set_gtk_property!(equipmentFrameTree, :width_request, wBC - 20)
    equipmentScroll = ScrolledWindow()
    push!(equipmentFrameTree, equipmentScroll)

    # Table for Case Design
    equipmentList = ListStore(String, String, String, String, String)

    # Visual Table for Case Design
    equipmentTreeView = TreeView(TreeModel(equipmentList))
    set_gtk_property!(equipmentTreeView, :reorderable, true)
    set_gtk_property!(equipmentTreeView, :enable_grid_lines, 3)

    # Set selectable
    selmodelequipment = G_.selection(equipmentTreeView)

    renderTxt3 = CellRendererText()
    renderTxt4 = CellRendererText()
    set_gtk_property!(renderTxt3, :editable, true)
    set_gtk_property!(renderTxt4, :editable, false)

    c1 = TreeViewColumn("ID", renderTxt3, Dict([("text", 0)]))
    c2 = TreeViewColumn("Equipment", renderTxt4, Dict([("text", 1)]))
    c3 = TreeViewColumn("Phenomena", renderTxt4, Dict([("text", 2)]))

    # Allows to select rows
    for c in [c1, c2, c3]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(equipmentTreeView, c1, c2, c3)
    push!(equipmentScroll, equipmentTreeView)

    equipmentGrid[1:4, 1] = equipmentFrameTree

    # Edited
    signal_connect(renderTxt3, "edited") do widget, path, text
        idxTreeEq = parse(Int, path) + 1
        idxIDEq = parse(Int, text)

        if idxIDEq >= 1 && idxIDEq <= 28
            println(idxTreeEq)
            println(idxIDEq)
            equipmentList[idxTreeEq, 1] = text
            equipmentList[idxTreeEq, 2] = listEqPhenomena[idxIDEq, 2]
            equipmentList[idxTreeEq, 3] = string(listEqPhenomena[idxIDEq, 3])
        else
            warn_dialog("No equipment specified for option $(idxIDEq), see Help", mainPIWin)
        end
    end

    # Buttons for base case design
    addEq = Button("Add")
    set_gtk_property!(addEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(addEq, :sensitive, false)
    signal_connect(addEq, :clicked) do widget
         push!(equipmentList, ("not specified", "not specified", "not specified", "not specified"))
         set_gtk_property!(clearEq, :sensitive, true)
         set_gtk_property!(deleteEq, :sensitive, true)
    end

    deleteEq = Button("Delete")
    set_gtk_property!(deleteEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(deleteEq, :sensitive, false)
    signal_connect(deleteEq, :clicked) do widget
        if hasselection(selmodelequipment)
            currentID = selected(selmodelequipment)
            deleteat!(equipmentList, currentID)

            if length(equipmentList)==0
                set_gtk_property!(deleteEq, :sensitive, false)
                set_gtk_property!(clearEq, :sensitive, false)
                set_gtk_property!(equipmentFrame, :label, " Equipments ")
            end
        end
    end

    clearEq = Button("Clear")
    set_gtk_property!(clearEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearEq, :sensitive, false)
    signal_connect(clearEq, :clicked) do widget
        empty!(equipmentList)
        set_gtk_property!(clearEq, :sensitive, false)
        set_gtk_property!(deleteEq, :sensitive, false)
        set_gtk_property!(equipmentFrame, :label, " Equipments ")
    end

    helpEq = Button("Help")
    set_gtk_property!(helpEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(helpEq, :sensitive, true)

    equipmentGrid[1, 2] = addEq
    equipmentGrid[2, 2] = deleteEq
    equipmentGrid[3, 2] = clearEq
    equipmentGrid[4, 2] = helpEq

    push!(equipmentFrame, equipmentGrid)

    ####################################################################################################################
    settingFrameRigth = Frame("Intensification Criterion")
    set_gtk_property!(settingFrameRigth, :height_request, hNb - 20)
    set_gtk_property!(settingFrameRigth, :width_request, (h / 2) - 15)
    set_gtk_property!(settingFrameRigth, :label_xalign, 0.50)

    settingGridLeft[1, 1] = baseCaseFrame
    settingGridLeft[1, 2] = equipmentFrame

    settingGridRight[1, 1] = settingFrameRigth

    settingGrid[1, 1] = settingGridLeft
    settingGrid[2, 1] = settingGridRight
    push!(settingFrame, settingGrid)

    ####################################################################################################################
    # Results frame
    ####################################################################################################################
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
