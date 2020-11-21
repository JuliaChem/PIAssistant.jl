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
    global idxBC = 1
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
    selBC = Gtk.GAccessor.selection(baseCaseTreeView)
    selBC = Gtk.GAccessor.mode(selBC, Gtk.GConstants.GtkSelectionMode.SINGLE)

    # Set selectable
    selmodelBaseCase = G_.selection(baseCaseTreeView)

    renderTxt = CellRendererText()

    c1 = TreeViewColumn("ID", renderTxt, Dict([("text", 0)]))
    c2 = TreeViewColumn("Name", renderTxt, Dict([("text", 1)]))
    c3 = TreeViewColumn("Equipments", renderTxt, Dict([("text", 2)]))
    c4 = TreeViewColumn("Criterion", renderTxt, Dict([("text", 3)]))
    c5 = TreeViewColumn("Status", renderTxt, Dict([("text", 4)]))

    # Allows to select rows
    for c in [c1, c2, c3, c4, c5]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(baseCaseTreeView, c1, c2, c3, c4, c5)
    push!(baseCaseScroll, baseCaseTreeView)

    baseCaseGrid[1:4, 1] = baseCaseFrameTree

    # Buttons for base case design
    addBC = Button("Add")
    set_gtk_property!(addBC, :width_request, (wBC - 5*10)/4)
    signal_connect(addBC, :clicked) do widget
        addBCWin = Window()
        set_gtk_property!(addBCWin, :title, "New Base Case Design")
        set_gtk_property!(addBCWin, :window_position, 3)
        set_gtk_property!(addBCWin, :width_request, h/3)
        set_gtk_property!(addBCWin, :height_request, h/5)
        set_gtk_property!(addBCWin, :accept_focus, true)

        addBCMainGrid = Grid()
        set_gtk_property!(addBCMainGrid, :margin_top, 10)
        set_gtk_property!(addBCMainGrid, :margin_left, 10)
        set_gtk_property!(addBCMainGrid, :margin_right, 10)
        set_gtk_property!(addBCMainGrid, :margin_bottom, 10)
        set_gtk_property!(addBCMainGrid, :column_spacing, 10)
        set_gtk_property!(addBCMainGrid, :row_spacing, 10)
        set_gtk_property!(addBCMainGrid, :column_homogeneous, true)
        set_gtk_property!(addBCMainGrid, :valign, 3)
        set_gtk_property!(addBCMainGrid, :halign, 3)

        addBCFrame = Frame()
        set_gtk_property!(addBCFrame, :width_request, h/3 - 20)
        set_gtk_property!(addBCFrame, :height_request, h/5 - 20)

        addBCGrid = Grid()
        set_gtk_property!(addBCGrid, :margin_top, 10)
        set_gtk_property!(addBCGrid, :margin_left, 10)
        set_gtk_property!(addBCGrid, :margin_right, 10)
        set_gtk_property!(addBCGrid, :margin_bottom, 10)
        set_gtk_property!(addBCGrid, :column_spacing, 10)
        set_gtk_property!(addBCGrid, :row_spacing, 10)
        set_gtk_property!(addBCGrid, :column_homogeneous, true)
        set_gtk_property!(addBCGrid, :valign, 3)
        set_gtk_property!(addBCGrid, :halign, 3)

        newBCLabel = Label("Enter name for new Base Case Design:")

        newBCEntry = Entry()
        set_gtk_property!(newBCEntry, :tooltip_markup, "Enter value")
        set_gtk_property!(newBCEntry, :width_request, h/4)
        set_gtk_property!(newBCEntry, :text, "")

        baseCaseEntryLabel = @sprintf("Base Case_%i", idxBC)
        set_gtk_property!(newBCEntry, :text, baseCaseEntryLabel)

        newBCAdd = Button("Add")
        signal_connect(newBCAdd, :clicked) do widget
            nameBC = get_gtk_property(newBCEntry, :text, String)

            if length(baseCaseList) == 0
                push!(baseCaseList, (length(baseCaseList)+1, nameBC, "Incomplete", "Incomplete", "Incomplete"))
                set_gtk_property!(clearBC, :sensitive, true)
                set_gtk_property!(deleteBC, :sensitive, true)
                set_gtk_property!(editBC, :sensitive, true)
                set_gtk_property!(saveToolbar, :sensitive, true)
                set_gtk_property!(pdfToolbar, :sensitive, true)
                global idxBC += 1
                destroy(addBCWin)
            else
                t = zeros(1, length(baseCaseList))
                for i=1:length(baseCaseList)
                    t[i] = nameBC == baseCaseList[i,2]
                end

                if sum(t) == 1
                    wmgs1 = warn_dialog("Name for base case design is already in use!", addBCWin)
                    set_gtk_property!(newBCEntry, :text, baseCaseEntryLabel)
                else
                    push!(baseCaseList, (length(baseCaseList)+1, nameBC, "Incomplete", "Incomplete", "Incomplete"))
                    set_gtk_property!(clearBC, :sensitive, true)
                    set_gtk_property!(deleteBC, :sensitive, true)
                    set_gtk_property!(editBC, :sensitive, true)
                    set_gtk_property!(saveToolbar, :sensitive, true)
                    set_gtk_property!(pdfToolbar, :sensitive, true)
                    global idxBC += 1
                    destroy(addBCWin)
                end
            end
        end

        signal_connect(addBCWin, "key-press-event") do widget, event
            if event.keyval == 65293
                nameBC = get_gtk_property(newBCEntry, :text, String)

                if length(baseCaseList) == 0
                    push!(baseCaseList, (length(baseCaseList)+1, nameBC, "Incomplete", "Incomplete", "Incomplete"))
                    set_gtk_property!(clearBC, :sensitive, true)
                    set_gtk_property!(deleteBC, :sensitive, true)
                    set_gtk_property!(editBC, :sensitive, true)
                    set_gtk_property!(saveToolbar, :sensitive, true)
                    set_gtk_property!(pdfToolbar, :sensitive, true)
                    global idxBC += 1
                    destroy(addBCWin)
                else
                    t = zeros(1, length(baseCaseList))
                    for i=1:length(baseCaseList)
                        t[i] = nameBC == baseCaseList[i,2]
                    end

                    if sum(t) == 1
                        wmgs1 = warn_dialog("Name for base case design is already in use!", addBCWin)
                        set_gtk_property!(newBCEntry, :text, baseCaseEntryLabel)
                    else
                        push!(baseCaseList, (length(baseCaseList)+1, nameBC, "Incomplete", "Incomplete", "Incomplete"))
                        set_gtk_property!(clearBC, :sensitive, true)
                        set_gtk_property!(deleteBC, :sensitive, true)
                        set_gtk_property!(editBC, :sensitive, true)
                        set_gtk_property!(saveToolbar, :sensitive, true)
                        set_gtk_property!(pdfToolbar, :sensitive, true)
                        global idxBC += 1
                        destroy(addBCWin)
                    end
                end
            end
        end
        newBCClose = Button("Close")
        signal_connect(newBCClose, :clicked) do widget
            destroy(addBCWin)
        end
        addBCGrid[1:2, 1] = newBCLabel
        addBCGrid[1:2, 2] = newBCEntry
        addBCGrid[1, 3] = newBCAdd
        addBCGrid[2, 3] = newBCClose

        push!(addBCFrame, addBCGrid)
        push!(addBCMainGrid, addBCFrame)
        push!(addBCWin, addBCMainGrid)
        Gtk.showall(addBCWin)
    end

    editBC = Button("Edit")
    set_gtk_property!(editBC, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(editBC, :sensitive, false)

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
                set_gtk_property!(editBC, :sensitive, false)
                set_gtk_property!(saveToolbar, :sensitive, false)
                set_gtk_property!(pdfToolbar, :sensitive, false)
            end
        end
    end

    clearBC = Button("Clear")
    set_gtk_property!(clearBC, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearBC, :sensitive, false)
    signal_connect(clearBC, :clicked) do widget
        empty!(baseCaseList)
        set_gtk_property!(clearBC, :sensitive, false)
        set_gtk_property!(deleteBC, :sensitive, false)
        set_gtk_property!(editBC, :sensitive, false)
        set_gtk_property!(saveToolbar, :sensitive, false)
        set_gtk_property!(pdfToolbar, :sensitive, false)
        global idxBC = 1
    end

    baseCaseGrid[1, 2] = addBC
    baseCaseGrid[2, 2] = editBC
    baseCaseGrid[3, 2] = deleteBC
    baseCaseGrid[4, 2] = clearBC

    push!(baseCaseFrame, baseCaseGrid)

    ####################################################################################################################
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

    renderTxt = CellRendererText()
    set_gtk_property!(renderTxt, :editable, true)

    c1 = TreeViewColumn("ID", renderTxt, Dict([("text", 0)]))
    c2 = TreeViewColumn("Name", renderTxt, Dict([("text", 1)]))
    c3 = TreeViewColumn("Equipment", renderTxt, Dict([("text", 2)]))
    c4 = TreeViewColumn("Phenomena", renderTxt, Dict([("text", 3)]))

    # Allows to select rows
    for c in [c1, c2, c3, c4]
        Gtk.GAccessor.resizable(c, true)
    end

    push!(equipmentTreeView, c1, c2, c3, c4)
    push!(equipmentScroll, equipmentTreeView)

    equipmentGrid[1:4, 1] = equipmentFrameTree

    # Buttons for base case design
    addEq = Button("Add")
    set_gtk_property!(addEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(addEq, :sensitive, false)

    editEq = Button("Edit")
    set_gtk_property!(editEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(editEq, :sensitive, false)

    deleteEq = Button("Delete")
    set_gtk_property!(deleteEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(deleteEq, :sensitive, false)

    clearEq = Button("Clear")
    set_gtk_property!(clearEq, :width_request, (wBC - 5*10)/4)
    set_gtk_property!(clearEq, :sensitive, false)

    equipmentGrid[1, 2] = addEq
    equipmentGrid[2, 2] = editEq
    equipmentGrid[3, 2] = deleteEq
    equipmentGrid[4, 2] = clearEq

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
