# Path to index logo
const indexImgPath = joinpath(dirname(Base.source_path()), "\\figures\\index_logo.png")

function PIAssistantGUI()

    indexImg = Image()
    set_gtk_property!(indexImg, :file, indexImgPath)

    Gtk.showall(indexImg)
end
