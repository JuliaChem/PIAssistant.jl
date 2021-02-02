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
    set_gtk_property!(mainPIWin, :height_request, h * 0.70 - 10)
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
    set_gtk_property!(settingGridLeft, :row_spacing, 5)

    settingGridRight = Grid()
    set_gtk_property!(settingGridRight, :row_spacing, 5)

    ####################################################################################################################
    # Base Case Design
    ####################################################################################################################
    global idxBC = 1
    global idxEq = zeros(1, idxBC)
    global dictBC = Dict()

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
    baseCaseList = ListStore(String, String, String, String, String, String)

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
    c4 = TreeViewColumn("Metrics", renderTxt2, Dict([("text", 3)]))
    c5 = TreeViewColumn("Criterion", renderTxt2, Dict([("text", 4)]))
    c6 = TreeViewColumn("Status", renderTxt2, Dict([("text", 4)]))

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
                currentID = selected(selmodelBaseCase)
                dictBC["$(text)"] = pop!(dictBC, "$(baseCaseList[currentID, 2])")
                dictEq["$(text)"] = pop!(dictEq, "$(baseCaseList[currentID, 2])")
                baseCaseList[idxTree + 1, 2] = text
            end
        end
    end

    signal_connect(baseCaseTreeView, :row_activated) do widget, path, column
        currentID = selected(selmodelBaseCase)
        set_gtk_property!(addEq, :sensitive, true)
        set_gtk_property!(helpEq, :sensitive, true)
        set_gtk_property!(addMet, :sensitive, true)
        set_gtk_property!(helpMet, :sensitive, true)
        set_gtk_property!(addCr, :sensitive, true)
        set_gtk_property!(addCrSett, :sensitive, true)
        set_gtk_property!(helpCr, :sensitive, true)
        set_gtk_property!(helpCrSett, :sensitive, true)

        empty!(equipmentList)
        empty!(metricsList)

        newSel = length(dictEq["$(baseCaseList[currentID, 2])"])
        if newSel != 0
            set_gtk_property!(clearEq, :sensitive, true)
            set_gtk_property!(deleteEq, :sensitive, true)
        else
            set_gtk_property!(clearEq, :sensitive, false)
            set_gtk_property!(deleteEq, :sensitive, false)
        end

        for i = 1:newSel
            push!(
                equipmentList,
                (
                dictEq["$(baseCaseList[currentID, 2])"][i][1],
                dictEq["$(baseCaseList[currentID, 2])"][i][2],
                dictEq["$(baseCaseList[currentID, 2])"][i][3],
                ),
            )
        end

        newSelMet = length(dictMet["$(baseCaseList[currentID, 2])"])
        if newSelMet != 0
            set_gtk_property!(clearMet, :sensitive, true)
            set_gtk_property!(deleteMet, :sensitive, true)
        else
            set_gtk_property!(clearMet, :sensitive, false)
            set_gtk_property!(deleteMet, :sensitive, false)
        end

        for i = 1:newSelMet
            push!(
                metricsList,
                (
                dictMet["$(baseCaseList[currentID, 2])"][i][1],
                dictMet["$(baseCaseList[currentID, 2])"][i][2],
                dictMet["$(baseCaseList[currentID, 2])"][i][3],
                dictMet["$(baseCaseList[currentID, 2])"][i][4],
                ),
            )
        end
    end

    # Allows to select rows
    for c in [c1, c2, c3, c4, c5, c6]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(baseCaseTreeView, c1, c2, c3, c4, c5, c6)
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
            push!(baseCaseList, (length(baseCaseList) + 1, baseCaseName, "Incomplete", "Incomplete", "Incomplete", "Incomplete"))
            set_gtk_property!(clearBC, :sensitive, true)
            set_gtk_property!(deleteBC, :sensitive, true)
            set_gtk_property!(saveToolbar, :sensitive, true)
            set_gtk_property!(pdfToolbar, :sensitive, true)

            dictBC["$(baseCaseName)"] = []
            dictEq["$(baseCaseName)"] = []
            dictMet["$(baseCaseName)"] = []
            global idxBC += 1
            global idxEq = zeros(1, idxBC)
        else
            t = zeros(1, length(baseCaseList))
            push!(baseCaseList, (length(baseCaseList) + 1, baseCaseName, "Incomplete", "Incomplete", "Incomplete", "Incomplete"))
            set_gtk_property!(clearBC, :sensitive, true)
            set_gtk_property!(deleteBC, :sensitive, true)
            set_gtk_property!(saveToolbar, :sensitive, true)
            set_gtk_property!(pdfToolbar, :sensitive, true)

            dictBC["$(baseCaseName)"] = []
            dictEq["$(baseCaseName)"] = []
            dictMet["$(baseCaseName)"] = []

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
            delete!(dictBC, baseCaseList[currentID, 2])
            delete!(dictEq, baseCaseList[currentID, 2])
            deleteat!(baseCaseList, currentID)
            empty!(equipmentList)
            empty!(metricsList)

            if length(baseCaseList) > 0
                newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            end

            if length(baseCaseList)==0
                global idxBC = 1
                empty!(baseCaseList)
                empty!(equipmentList)
                empty!(metricsList)
                set_gtk_property!(clearBC, :sensitive, false)
                set_gtk_property!(clearEq, :sensitive, false)
                set_gtk_property!(deleteBC, :sensitive, false)
                set_gtk_property!(deleteEq, :sensitive, false)
                set_gtk_property!(saveToolbar, :sensitive, false)
                set_gtk_property!(pdfToolbar, :sensitive, false)
                set_gtk_property!(addEq, :sensitive, false)
                set_gtk_property!(helpEq, :sensitive, false)
                set_gtk_property!(addMet, :sensitive, false)
                set_gtk_property!(helpMet, :sensitive, false)
                set_gtk_property!(deleteMet, :sensitive, false)
                set_gtk_property!(clearMet, :sensitive, false)
                set_gtk_property!(equitMetNotebook, :page, 0)
                set_gtk_property!(addCr, :sensitive, false)
                set_gtk_property!(addCrSett, :sensitive, false)
                set_gtk_property!(helpCr, :sensitive, false)
                set_gtk_property!(helpCrSett, :sensitive, false)
            end
            global idxEq = zeros(1, idxBC)
        end
    end

    clearBC = Button("Clear")
    set_gtk_property!(clearBC, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearBC, :sensitive, false)
    signal_connect(clearBC, :clicked) do widget
        empty!(baseCaseList)
        empty!(equipmentList)
        empty!(metricsList)
        set_gtk_property!(clearBC, :sensitive, false)
        set_gtk_property!(clearEq, :sensitive, false)
        set_gtk_property!(deleteBC, :sensitive, false)
        set_gtk_property!(deleteEq, :sensitive, false)
        set_gtk_property!(saveToolbar, :sensitive, false)
        set_gtk_property!(pdfToolbar, :sensitive, false)
        set_gtk_property!(addEq, :sensitive, false)
        set_gtk_property!(helpEq, :sensitive, false)
        set_gtk_property!(addMet, :sensitive, false)
        set_gtk_property!(helpMet, :sensitive, false)
        set_gtk_property!(deleteMet, :sensitive, false)
        set_gtk_property!(clearMet, :sensitive, false)
        set_gtk_property!(addCr, :sensitive, false)
        set_gtk_property!(addCrSett, :sensitive, false)
        set_gtk_property!(helpCr, :sensitive, false)
        set_gtk_property!(helpCrSett, :sensitive, false)
        set_gtk_property!(equitMetNotebook, :page, 0)

        global dictBC = Dict()
        global dictEq = Dict()
        global idxBC = 1
    end

    baseCaseGrid[1, 2] = addBC
    baseCaseGrid[2, 2] = deleteBC
    baseCaseGrid[3, 2] = clearBC

    push!(baseCaseFrame, baseCaseGrid)

    ## Notebook for Equiptment and Criteria ############################################################################
    equitMetFrame = Frame()
    if Sys.iswindows()
        set_gtk_property!(equitMetFrame, :height_request, (hNb - 30)/2 - 3)
    else
        set_gtk_property!(equitMetFrame, :height_request, (hNb - 30)/2 - 21)
    end

    set_gtk_property!(equitMetFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(equitMetFrame, :margin_top, 10)

    equitMetNotebook = Notebook()
    push!(equitMetFrame, equitMetNotebook)
    ####################################################################################################################

    # Equipment ########################################################################################################
    global listEqPhenomena = DataFrames.DataFrame(ID = Float64[], Name = String[], Phenomena = Array[])
    global dictEq = Dict()

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

    equipmentFrame = Frame()
    set_gtk_property!(equipmentFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(equipmentFrame, :label_xalign, 0.50)

    equipmentGrid = Grid()
    set_gtk_property!(equipmentGrid, :column_spacing, 10)
    set_gtk_property!(equipmentGrid, :row_spacing, 10)
    set_gtk_property!(equipmentGrid, :margin_top, 5)
    set_gtk_property!(equipmentGrid, :margin_bottom, 10)
    set_gtk_property!(equipmentGrid, :margin_left, 10)
    set_gtk_property!(equipmentGrid, :margin_right, 10)

    # TreeView for Base Case Design
    wBC = (h / 2) - 15
    equipmentFrameTree = Frame()

    if Sys.iswindows()
        set_gtk_property!(equipmentFrameTree, :height_request, (hNb - 30)/2 - 110)
    else
        set_gtk_property!(equipmentFrameTree, :height_request, (hNb - 30)/2 - 101)
    end

    set_gtk_property!(equipmentFrameTree, :width_request, wBC - 20)
    set_gtk_property!(equipmentFrameTree, :margin_top, 5)
    equipmentScroll = ScrolledWindow()
    push!(equipmentFrameTree, equipmentScroll)

    # Table for Case Design
    equipmentList = ListStore(String, String, String)

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
            equipmentList[idxTreeEq, 1] = text
            equipmentList[idxTreeEq, 2] = listEqPhenomena[idxIDEq, 2]
            equipmentList[idxTreeEq, 3] = string(listEqPhenomena[idxIDEq, 3])

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictEq["$(baseCaseList[newidxBC,2])"] = []

            testEq = zeros(1, length(equipmentList))
            for i = 1:length(equipmentList)
                push!(
                    dictEq["$(baseCaseList[newidxBC,2])"],
                    (equipmentList[i, 1], equipmentList[i, 2], equipmentList[i, 3]),
                    )

                    if equipmentList[i, 1] == "not specified"
                        testEq[i] = 1
                    end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(equipmentList) >= 2
                if sum(testEq) == 0
                    baseCaseList[newidxBC, 3] = @sprintf("Equipments = %i, Complete", length(equipmentList))
                end
            end

        else
            warn_dialog("No equipment specified for option $(idxIDEq), see Help", mainPIWin)
        end
    end

    # Buttons for base case design
    addEq = Button("Add")
    set_gtk_property!(addEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(addEq, :sensitive, false)
    signal_connect(addEq, :clicked) do widget
         push!(equipmentList, ("not specified", "not specified", "not specified"))
         set_gtk_property!(clearEq, :sensitive, true)
         set_gtk_property!(deleteEq, :sensitive, true)

         newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
         push!(dictEq["$(baseCaseList[newidxBC,2])"], ("not specified", "not specified", "not specified"))

         newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))
         baseCaseList[newidxBC, 3] = "Incomplete"
    end

    deleteEq = Button("Delete")
    set_gtk_property!(deleteEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(deleteEq, :sensitive, false)
    signal_connect(deleteEq, :clicked) do widget
        if hasselection(selmodelequipment)
            currentID = selected(selmodelequipment)
            newidxBC = Gtk.index_from_iter(equipmentList, selected(selmodelequipment))
            deleteat!(equipmentList, currentID)

            currentIDBC = selected(selBC)
            nameBCSel = baseCaseList[currentIDBC, 2]
            dictEq[nameBCSel] = deleteat!(dictEq[nameBCSel], newidxBC)

            if length(equipmentList)==0
                set_gtk_property!(deleteEq, :sensitive, false)
                set_gtk_property!(clearEq, :sensitive, false)
            end

            if length(equipmentList) < 2
                newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))
                baseCaseList[newidxBC, 3] = "Incomplete"
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictEq["$(baseCaseList[newidxBC,2])"] = []

            testEq = zeros(1, length(equipmentList))
            for i = 1:length(equipmentList)
                push!(
                    dictEq["$(baseCaseList[newidxBC,2])"],
                    (equipmentList[i, 1], equipmentList[i, 2], equipmentList[i, 3]),
                    )

                    if equipmentList[i, 1] == "not specified"
                        testEq[i] = 1
                    end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(equipmentList) >= 2
                if sum(testEq) == 0
                    baseCaseList[newidxBC, 3] = @sprintf("Equipments= %i, Complete", length(equipmentList))
                end
            end

        end
    end

    clearEq = Button("Clear")
    set_gtk_property!(clearEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearEq, :sensitive, false)
    signal_connect(clearEq, :clicked) do widget
        currentIDBC = selected(selBC)
        nameBCSel = baseCaseList[currentIDBC, 2]
        dictEq[nameBCSel] = []
        empty!(equipmentList)
        set_gtk_property!(clearEq, :sensitive, false)
        set_gtk_property!(deleteEq, :sensitive, false)

        newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))
        baseCaseList[newidxBC, 3] = "Incomplete"
    end

    helpEq = Button("Help")
    set_gtk_property!(helpEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(helpEq, :sensitive, false)
    signal_connect(helpEq, :clicked) do widget
        # Equipment Help Win
        eqHelpWin = Window()
        set_gtk_property!(eqHelpWin, :title, "Equiptment Help")
        set_gtk_property!(eqHelpWin, :window_position, 3)
        set_gtk_property!(eqHelpWin, :accept_focus, true)
        set_gtk_property!(eqHelpWin, :resizable, false)
        set_gtk_property!(eqHelpWin, :width_request, h/2.5)

        eqFrameHelp = Frame("Equipment evailable")
        set_gtk_property!(eqFrameHelp, :label_xalign, 0.5)
        set_gtk_property!(eqFrameHelp, :margin_top, 5)
        set_gtk_property!(eqFrameHelp, :margin_bottom, 10)
        set_gtk_property!(eqFrameHelp, :margin_left, 10)
        set_gtk_property!(eqFrameHelp, :margin_right, 10)

        eqGridHelp = Grid()
        set_gtk_property!(eqGridHelp, :column_spacing, 10)
        set_gtk_property!(eqGridHelp, :row_spacing, 10)
        set_gtk_property!(eqGridHelp, :margin_top, 5)
        set_gtk_property!(eqGridHelp, :margin_bottom, 10)
        set_gtk_property!(eqGridHelp, :margin_left, 10)
        set_gtk_property!(eqGridHelp, :margin_right, 10)

        eqFrameTree = Frame()
        set_gtk_property!(eqFrameTree, :width_request, h/2.5 - 20)
        set_gtk_property!(eqFrameTree, :height_request, h/2 - 30 - 60)

        eqScroll = ScrolledWindow()
        push!(eqFrameTree, eqScroll)

        # Table for Equipment help
        eqList = ListStore(Int, String, String)

        # Load data from listEqPhenomena

        for i=1:size(listEqPhenomena)[1]
            push!(eqList, (listEqPhenomena[i,1], listEqPhenomena[i,2], string(listEqPhenomena[i,3])))
        end

        # Visual Table for Equipment help
        eqTreeView = TreeView(TreeModel(eqList))
        set_gtk_property!(eqTreeView, :reorderable, true)
        set_gtk_property!(eqTreeView, :enable_grid_lines, 3)

        # Set selectable
        selEqHelp = Gtk.GAccessor.selection(eqTreeView)
        selEqHelp = Gtk.GAccessor.mode(selEqHelp, Gtk.GConstants.GtkSelectionMode.SINGLE)
        selEqHelp = G_.selection(eqTreeView)

        renderTxteq = CellRendererText()
        set_gtk_property!(renderTxteq, :editable, false)

        c1 = TreeViewColumn("ID", renderTxteq, Dict([("text", 0)]))
        c2 = TreeViewColumn("Equipment", renderTxteq, Dict([("text", 1)]))
        c3 = TreeViewColumn("Phenomena", renderTxteq, Dict([("text", 2)]))

        # Allows to select rows
        for c in [c1, c2, c3]
            Gtk.GAccessor.resizable(c, true)
        end

        push!(eqTreeView, c1, c2, c3)
        push!(eqScroll, eqTreeView)

        eqClose = Button("Close")
        set_gtk_property!(eqClose, :label, "Close")
        set_gtk_property!(eqClose, :tooltip_markup, "Close")
        signal_connect(eqClose, :clicked) do widget
            destroy(eqHelpWin)
        end

        eqAdd = Button("Add")
        set_gtk_property!(eqAdd, :label, "Add")
        set_gtk_property!(eqAdd, :tooltip_markup, "Add")
        signal_connect(eqAdd, :clicked) do widget
            currentID = selected(selEqHelp)
            push!(equipmentList, (eqList[currentID, 1], eqList[currentID, 2], eqList[currentID, 3]))
            set_gtk_property!(clearEq, :sensitive, true)
            set_gtk_property!(deleteEq, :sensitive, true)

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictEq["$(baseCaseList[newidxBC,2])"] = []

            testEq = zeros(1, length(equipmentList))
            for i = 1:length(equipmentList)
                push!(dictEq["$(baseCaseList[newidxBC,2])"], (equipmentList[i, 1], equipmentList[i, 2], equipmentList[i, 3]))

                if equipmentList[i, 1] == "not specified"
                    testEq[i] = 1
                end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(equipmentList) >= 2
                if sum(testEq) == 0
                    baseCaseList[newidxBC, 3] = @sprintf("Equipments = %i, Complete", length(equipmentList))
                end
            end
        end

        signal_connect(eqTreeView, :row_activated) do widget, path, column
            currentID = selected(selEqHelp)
            push!(equipmentList, (eqList[currentID,1], eqList[currentID,2], eqList[currentID,3]))
            set_gtk_property!(clearEq, :sensitive, true)
            set_gtk_property!(deleteEq, :sensitive, true)

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictEq["$(baseCaseList[newidxBC,2])"] = []

            testEq = zeros(1, length(equipmentList))
            for i = 1:length(equipmentList)
                push!(dictEq["$(baseCaseList[newidxBC,2])"], (equipmentList[i, 1], equipmentList[i, 2], equipmentList[i, 3]))

                if equipmentList[i, 1] == "not specified"
                    testEq[i] = 1
                end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(equipmentList) >= 2
                if sum(testEq) == 0
                    baseCaseList[newidxBC, 3] = @sprintf("Equipments= %i, Complete", length(equipmentList))
                end
            end
        end

        eqGridHelp[1, 2] = eqAdd
        eqGridHelp[2, 2] = eqClose
        eqGridHelp[1:2, 1] = eqFrameTree
        push!(eqFrameHelp, eqGridHelp)
        push!(eqHelpWin, eqFrameHelp)
        Gtk.showall(eqHelpWin)
    end

    equipmentGrid[1, 2] = addEq
    equipmentGrid[2, 2] = deleteEq
    equipmentGrid[3, 2] = clearEq
    equipmentGrid[4, 2] = helpEq

    push!(equipmentFrame, equipmentGrid)
    ####################################################################################################################

    # Metrics ##########################################################################################################
    global listMet = DataFrames.DataFrame(ID = Int[], Metric = String[], Symbol = String[], Value = String[])
    global dictMet = Dict()

    # Add avilable aquipments and phenomenas
    push!(listMet, (1, "Operating cost", "OC", "not specified"))
    push!(listMet, (2, "Purchase cost", "PC", "not specified"))
    push!(listMet, (3, "Utility cost", "UC", "not specified"))
    push!(listMet, (4, "Profit", "Pr", "not specified"))
    push!(listMet, (5, "Return of investment", "ROI", "not specified"))
    push!(listMet, (6, "Human toxicity by ingestion", "HTPI", "not specified"))
    push!(listMet, (7, "Human toxicity by exposure", "HTPE", "not specified"))
    push!(listMet, (8, "Global Warming", "GWP", "not specified"))
    push!(listMet, (9, "Carcinogenics", "HTC", "not specified"))
    push!(listMet, (10, "Non carcinogenics", "HTNC", "not specified"))
    push!(listMet, (11, "Carbon footprint", "CF", "not specified"))
    push!(listMet, (12, "Fire and explosion damage index", "FEDI", "not specified"))

    metricsFrame = Frame()
    set_gtk_property!(metricsFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(metricsFrame, :label_xalign, 0.50)

    metricsGrid = Grid()
    set_gtk_property!(metricsGrid, :column_spacing, 10)
    set_gtk_property!(metricsGrid, :row_spacing, 10)
    set_gtk_property!(metricsGrid, :margin_top, 5)
    set_gtk_property!(metricsGrid, :margin_bottom, 10)
    set_gtk_property!(metricsGrid, :margin_left, 10)
    set_gtk_property!(metricsGrid, :margin_right, 10)

    # TreeView for Metrics
    wBC = (h / 2) - 15
    metricsFrameTree = Frame()

    if Sys.iswindows()
        set_gtk_property!(metricsFrameTree, :height_request, (hNb - 30)/2 - 110)
    else
        set_gtk_property!(metricsFrameTree, :height_request, (hNb - 30)/2 - 101)
    end

    set_gtk_property!(metricsFrameTree, :width_request, wBC - 20)
    set_gtk_property!(metricsFrameTree, :margin_top, 5)
    metricsScroll = ScrolledWindow()
    push!(metricsFrameTree, metricsScroll)

    # Table for Case Design
    metricsList = ListStore(String, String, String, String)

    # Visual Table for Case Design
    metricsTreeView = TreeView(TreeModel(metricsList))
    set_gtk_property!(metricsTreeView, :reorderable, true)
    set_gtk_property!(metricsTreeView, :enable_grid_lines, 3)

    # Set selectable
    selmodelMetrics = G_.selection(metricsTreeView)

    renderTxtM1 = CellRendererText()
    renderTxtM2 = CellRendererText()
    renderTxtM3 = CellRendererText()

    set_gtk_property!(renderTxtM1, :editable, true)
    set_gtk_property!(renderTxtM2, :editable, false)
    set_gtk_property!(renderTxtM3, :editable, true)

    c1 = TreeViewColumn("ID", renderTxtM1, Dict([("text", 0)]))
    c2 = TreeViewColumn("Metric", renderTxtM2, Dict([("text", 1)]))
    c3 = TreeViewColumn("Symbol", renderTxtM2, Dict([("text", 2)]))
    c4 = TreeViewColumn("Value", renderTxtM3, Dict([("text", 3)]))

    # Allows to select rows
    for c in [c1, c2, c3, c4]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(metricsTreeView, c1, c2, c3, c4)
    push!(metricsScroll, metricsTreeView)

    metricsGrid[1:4, 1] = metricsFrameTree

# TODO Add code for edited cell for 0both ID and value in Metrics
    signal_connect(renderTxtM1, "edited") do widget, path, text
        idxTreeMet = parse(Int, path) + 1
        idxIDMet = parse(Int, text)


                if idxIDMet >= 1 && idxIDMet <= 12
                    metricsList[idxTreeMet, 1] = text
                    metricsList[idxTreeMet, 2] = listMet[idxIDMet, 2]
                    metricsList[idxTreeMet, 3] = listMet[idxIDMet, 3]

                    newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
                    dictMet["$(baseCaseList[newidxBC,2])"] = []

                    testMet = zeros(1, length(metricsList))
                    for i = 1:length(metricsList)
                        push!(
                            dictMet["$(baseCaseList[newidxBC,2])"],
                            (metricsList[i, 1], metricsList[i, 2], metricsList[i, 3]), metricsList[i, 4],
                            )

                            if metricsList[i, 1] == "not specified"
                                testMet[i] = 1
                            end
                    end
                    newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

                    if length(metricsList) >= 1
                        if sum(testMet) == 0
                            baseCaseList[newidxBC, 4] = @sprintf("Metrics = %i, Complete", length(metricsList))
                        end
                    end

                else
                    warn_dialog("No metric specified for option $(idxIDMet), see Help", mainPIWin)
                end
    end

    # Buttons for base case design
    addMet = Button("Add")
    set_gtk_property!(addMet, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(addMet, :sensitive, false)
    signal_connect(addMet, :clicked) do widget
         push!(metricsList, ("not specified", "not specified", "not specified", "not specified"))
         set_gtk_property!(clearMet, :sensitive, true)
         set_gtk_property!(deleteMet, :sensitive, true)

         newidxMet = Gtk.index_from_iter(baseCaseList, selected(selBC))
         push!(dictMet["$(baseCaseList[newidxMet,2])"], ("not specified", "not specified", "not specified", "not specified"))

         baseCaseList[newidxMet, 4] = "Incomplete"
    end

    deleteMet = Button("Delete")
    set_gtk_property!(deleteMet, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(deleteMet, :sensitive, false)
    signal_connect(deleteMet, :clicked) do widget
        if hasselection(selmodelMetrics)
            currentID = selected(selmodelMetrics)
            newidxMet = Gtk.index_from_iter(metricsList, selected(selmodelMetrics))
            deleteat!(metricsList, currentID)

            currentIDBC = selected(selBC)
            nameBCSel = baseCaseList[currentIDBC, 2]
            dictMet[nameBCSel] = deleteat!(dictMet[nameBCSel], newidxMet)

            if length(metricsList)==0
                set_gtk_property!(deleteMet, :sensitive, false)
                set_gtk_property!(clearMet, :sensitive, false)
            end

            if length(metricsList) < 2
                newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))
                baseCaseList[newidxBC, 4] = "Incomplete"
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictMet["$(baseCaseList[newidxBC,2])"] = []

            testMet = zeros(1, length(metricsList))
            for i = 1:length(metricsList)
                push!(dictMet["$(baseCaseList[newidxBC,2])"], (metricsList[i, 1], metricsList[i, 2], metricsList[i, 3], 0))

                if metricsList[i, 1] == "not specified"
                    testMet[i] = 1
                end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(metricsList) >= 1
                if sum(testMet) == 0
                    baseCaseList[newidxBC, 4] = @sprintf("Metrics = %i, Complete", length(metricsList))
                end
            end
        end
    end

    clearMet = Button("Clear")
    set_gtk_property!(clearMet, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearMet, :sensitive, false)
    signal_connect(clearMet, :clicked) do widget
        currentIDBC = selected(selBC)
        nameBCSel = baseCaseList[currentIDBC, 2]
        dictEq[nameBCSel] = []
        empty!(metricsList)
        set_gtk_property!(clearMet, :sensitive, false)
        set_gtk_property!(deleteMet, :sensitive, false)

        newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))
        baseCaseList[newidxBC, 4] = "Incomplete"
    end

    helpMet = Button("Help")
    set_gtk_property!(helpMet, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(helpMet, :sensitive, false)
    signal_connect(helpMet, :clicked) do widget
        # Metrics Help Win
        metricsHelpWin = Window()
        set_gtk_property!(metricsHelpWin, :title, "Metrics Help")
        set_gtk_property!(metricsHelpWin, :window_position, 3)
        set_gtk_property!(metricsHelpWin, :accept_focus, true)
        set_gtk_property!(metricsHelpWin, :resizable, false)
        set_gtk_property!(metricsHelpWin, :width_request, h/2.5)

        metricsFrameHelp = Frame("Metrics evailable")
        set_gtk_property!(metricsFrameHelp, :label_xalign, 0.5)
        set_gtk_property!(metricsFrameHelp, :margin_top, 5)
        set_gtk_property!(metricsFrameHelp, :margin_bottom, 10)
        set_gtk_property!(metricsFrameHelp, :margin_left, 10)
        set_gtk_property!(metricsFrameHelp, :margin_right, 10)

        metricsGridHelp = Grid()
        set_gtk_property!(metricsGridHelp, :column_spacing, 10)
        set_gtk_property!(metricsGridHelp, :row_spacing, 10)
        set_gtk_property!(metricsGridHelp, :margin_top, 5)
        set_gtk_property!(metricsGridHelp, :margin_bottom, 10)
        set_gtk_property!(metricsGridHelp, :margin_left, 10)
        set_gtk_property!(metricsGridHelp, :margin_right, 10)

        metricsFrameTreeH = Frame()
        set_gtk_property!(metricsFrameTreeH, :width_request, h/2.5 - 20)
        set_gtk_property!(metricsFrameTreeH, :height_request, h/2 - 30 - 60)

        metricsScrollH = ScrolledWindow()
        push!(metricsFrameTreeH, metricsScrollH)

        # Table for Metrics help
        metList = ListStore(String, String, String)

        # Load data from listEqPhenomena

        for i=1:size(listMet)[1]
            push!(metList, (listMet[i,1], listMet[i,2], string(listMet[i,3])))
        end

        # Visual Table for Metrics help
        metricsTreeViewH = TreeView(TreeModel(metList))
        set_gtk_property!(metricsTreeViewH, :reorderable, true)
        set_gtk_property!(metricsTreeViewH, :enable_grid_lines, 3)

        # Set selectable
        selMetHelp = Gtk.GAccessor.selection(metricsTreeViewH)
        selMetHelp = Gtk.GAccessor.mode(selMetHelp, Gtk.GConstants.GtkSelectionMode.SINGLE)
        selMetHelp = G_.selection(metricsTreeViewH)

        renderTxtMet = CellRendererText()
        set_gtk_property!(renderTxtMet, :editable, false)

        c1 = TreeViewColumn("ID", renderTxtMet, Dict([("text", 0)]))
        c2 = TreeViewColumn("Metric", renderTxtMet, Dict([("text", 1)]))
        c3 = TreeViewColumn("Symbol", renderTxtMet, Dict([("text", 2)]))

        # Allows to select rows
        for c in [c1, c2, c3]
            Gtk.GAccessor.resizable(c, true)
        end

        push!(metricsTreeViewH, c1, c2, c3)
        push!(metricsScrollH, metricsTreeViewH)

        metricsClose = Button("Close")
        set_gtk_property!(metricsClose, :label, "Close")
        set_gtk_property!(metricsClose, :tooltip_markup, "Close")
        signal_connect(metricsClose, :clicked) do widget
            destroy(metricsHelpWin)
        end

        metricsAdd = Button("Add")
        set_gtk_property!(metricsAdd, :label, "Add")
        set_gtk_property!(metricsAdd, :tooltip_markup, "Add")
        signal_connect(metricsAdd, :clicked) do widget
            currentID = selected(selMetHelp)
            push!(metricsList, (metList[currentID, 1], metList[currentID, 2], metList[currentID, 3], "not specified"))
            set_gtk_property!(clearMet, :sensitive, true)
            set_gtk_property!(deleteMet, :sensitive, true)

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictMet["$(baseCaseList[newidxBC,2])"] = []

            testMet = zeros(1, length(metricsList))
            for i = 1:length(metricsList)
                push!(dictMet["$(baseCaseList[newidxBC,2])"], (metricsList[i, 1], metricsList[i, 2], metricsList[i, 3], metricsList[i, 4]))

                if metricsList[i, 1] == "not specified"
                    testMet[i] = 1
                end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(metricsList) >= 1
                if sum(testMet) == 0
                    baseCaseList[newidxBC, 4] = @sprintf("Metrics = %i, Complete", length(metricsList))
                end
            end
        end

        signal_connect(metricsTreeViewH, :row_activated) do widget, path, column
            currentID = selected(selMetHelp)
            push!(metricsList, (metList[currentID,1], metList[currentID,2], metList[currentID,3], "not specified"))
            set_gtk_property!(clearMet, :sensitive, true)
            set_gtk_property!(deleteMet, :sensitive, true)

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selBC))
            dictMet["$(baseCaseList[newidxBC,2])"] = []

            testMet = zeros(1, length(metricsList))
            for i = 1:length(metricsList)
                push!(dictMet["$(baseCaseList[newidxBC,2])"], (metricsList[i, 1], metricsList[i, 2], metricsList[i, 3], metricsList[i, 4]))

                if metricsList[i, 1] == "not specified"
                    testMet[i] = 1
                end
            end

            newidxBC = Gtk.index_from_iter(baseCaseList, selected(selmodelBaseCase))

            if length(metricsList) >= 1
                if sum(testMet) == 0
                    baseCaseList[newidxBC, 4] = @sprintf("Metrics = %i, Complete", length(metricsList))
                end
            end
        end

        metricsGridHelp[1, 2] = metricsAdd
        metricsGridHelp[2, 2] = metricsClose
        metricsGridHelp[1:2, 1] = metricsFrameTreeH
        push!(metricsFrameHelp, metricsGridHelp)
        push!(metricsHelpWin, metricsFrameHelp)
        Gtk.showall(metricsHelpWin)
    end

    metricsGrid[1, 2] = addMet
    metricsGrid[2, 2] = deleteMet
    metricsGrid[3, 2] = clearMet
    metricsGrid[4, 2] = helpMet

    push!(metricsFrame, metricsGrid)
    ####################################################################################################################

    ####################################################################################################################

    ####################################################################################################################
    # Criterion
    ####################################################################################################################
    criterionFrame = Frame(" Criterion ")
    set_gtk_property!(criterionFrame, :height_request, (hNb - 30)/2)
    set_gtk_property!(criterionFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(criterionFrame, :label_xalign, 0.50)

    criterionGrid = Grid()
    set_gtk_property!(criterionGrid, :column_spacing, 10)
    set_gtk_property!(criterionGrid, :row_spacing, 10)
    set_gtk_property!(criterionGrid, :margin_top, 5)
    set_gtk_property!(criterionGrid, :margin_bottom, 10)
    set_gtk_property!(criterionGrid, :margin_left, 10)
    set_gtk_property!(criterionGrid, :margin_right, 10)

    # TreeView for Base Case Design
    wBC = (h / 2) - 15
    criterionFrameTree = Frame()
    set_gtk_property!(criterionFrameTree, :height_request, (hNb - 30)/2 - 75)
    set_gtk_property!(criterionFrameTree, :width_request, wBC - 20)
    criterionScroll = ScrolledWindow()
    push!(criterionFrameTree, criterionScroll)

    # Table for Case Design
    criterionList = ListStore(String, String, String)

    # Visual Table for Case Design
    criterionTreeView = TreeView(TreeModel(criterionList))
    set_gtk_property!(criterionTreeView, :reorderable, true)
    set_gtk_property!(criterionTreeView, :enable_grid_lines, 3)

    # Set selectable
    selmodelcriterion = G_.selection(criterionTreeView)

    renderTxt5 = CellRendererText()
    renderTxt6 = CellRendererText()
    set_gtk_property!(renderTxt5, :editable, true)
    set_gtk_property!(renderTxt6, :editable, false)

    c1 = TreeViewColumn("ID", renderTxt5, Dict([("text", 0)]))
    c2 = TreeViewColumn("Criterion", renderTxt6, Dict([("text", 1)]))
    c3 = TreeViewColumn("Status", renderTxt6, Dict([("text", 2)]))

    # Allows to select rows
    for c in [c1, c2, c3]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(criterionTreeView, c1, c2, c3)
    push!(criterionScroll, criterionTreeView)

    criterionGrid[1:4, 1] = criterionFrameTree

    # Edited
    signal_connect(renderTxt5, "edited") do widget, path, text

    end

    # Buttons for base case design
    addCr = Button("Add")
    set_gtk_property!(addCr, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(addCr, :sensitive, false)
    signal_connect(addCr, :clicked) do widget
    end

    deleteCr = Button("Delete")
    set_gtk_property!(deleteCr, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(deleteCr, :sensitive, false)
    signal_connect(deleteCr, :clicked) do widget

    end

    clearCr = Button("Clear")
    set_gtk_property!(clearCr, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearCr, :sensitive, false)
    signal_connect(clearCr, :clicked) do widget

    end

    helpCr = Button("Help")
    set_gtk_property!(helpCr, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(helpCr, :sensitive, false)

    criterionGrid[1, 2] = addCr
    criterionGrid[2, 2] = deleteCr
    criterionGrid[3, 2] = clearCr
    criterionGrid[4, 2] = helpCr

    push!(criterionFrame, criterionGrid)

    ####################################################################################################################
    # Criterion Settings
    ####################################################################################################################
    crSettFrame = Frame(" Input Data for Criterion ")
    set_gtk_property!(crSettFrame, :height_request, (hNb - 30)/2)
    set_gtk_property!(crSettFrame, :width_request, (h / 2) - 15)
    set_gtk_property!(crSettFrame, :label_xalign, 0.50)

    crSettGrid = Grid()
    set_gtk_property!(crSettGrid, :column_spacing, 10)
    set_gtk_property!(crSettGrid, :row_spacing, 10)
    set_gtk_property!(crSettGrid, :margin_top, 5)
    set_gtk_property!(crSettGrid, :margin_bottom, 10)
    set_gtk_property!(crSettGrid, :margin_left, 10)
    set_gtk_property!(crSettGrid, :margin_right, 10)

    # TreeView for Base Case Design
    wBC = (h / 2) - 15
    crSettFrameTree = Frame()
    set_gtk_property!(crSettFrameTree, :height_request, (hNb - 30)/2 - 75)
    set_gtk_property!(crSettFrameTree, :width_request, wBC - 20)
    crSettScroll = ScrolledWindow()
    push!(crSettFrameTree, crSettScroll)

    # Table for Case Design
    crSettList = ListStore(String, String, String, String)

    # Visual Table for Case Design
    crSettTreeView = TreeView(TreeModel(crSettList))
    set_gtk_property!(crSettTreeView, :reorderable, true)
    set_gtk_property!(crSettTreeView, :enable_grid_lines, 3)

    # Set selectable
    selmodelcrSett = G_.selection(crSettTreeView)

    renderTxt7 = CellRendererText()
    renderTxt8 = CellRendererText()
    set_gtk_property!(renderTxt7, :editable, true)
    set_gtk_property!(renderTxt8, :editable, false)

    c1 = TreeViewColumn("ID", renderTxt8, Dict([("text", 0)]))
    c2 = TreeViewColumn("Equipment", renderTxt8, Dict([("text", 1)]))
    c3 = TreeViewColumn("Value", renderTxt7, Dict([("text", 2)]))

    # Allows to select rows
    for c in [c1, c2, c3]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(crSettTreeView, c1, c2, c3)
    push!(crSettScroll, crSettTreeView)

    crSettGrid[1:4, 1] = crSettFrameTree

    # Edited
    signal_connect(renderTxt7, "edited") do widget, path, text

    end

    # Buttons for base case design
    addCrSett = Button("Add")
    set_gtk_property!(addCrSett, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(addCrSett, :sensitive, false)
    signal_connect(addCrSett, :clicked) do widget
    end

    deleteCrSett = Button("Delete")
    set_gtk_property!(deleteCrSett, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(deleteCrSett, :sensitive, false)
    signal_connect(deleteCrSett, :clicked) do widget

    end

    clearCrSett = Button("Clear")
    set_gtk_property!(clearCrSett, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearCrSett, :sensitive, false)
    signal_connect(clearCrSett, :clicked) do widget

    end

    helpCrSett = Button("Help")
    set_gtk_property!(helpCrSett, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(helpCrSett, :sensitive, false)

    crSettGrid[1, 2] = addCrSett
    crSettGrid[2, 2] = deleteCrSett
    crSettGrid[3, 2] = clearCrSett
    crSettGrid[4, 2] = helpCrSett

    push!(crSettFrame, crSettGrid)


    push!(equitMetNotebook, equipmentFrame, "Equipment")
    push!(equitMetNotebook, metricsFrame, "Metrics")

    ####################################################################################################################
    settingGridLeft[1, 1] = baseCaseFrame
    settingGridLeft[1, 2] = equitMetFrame

    settingGridRight[1, 1] = criterionFrame
    settingGridRight[1, 2] = crSettFrame

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
