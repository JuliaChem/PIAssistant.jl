module PIAssistant
    # Developed by:
    # PhD. Arick Castillo Landero
    # PhD. Arturo Jimenez Gutierrez
    # PhD. Kelvyn B. Sánchez Sánchez
    # Instituto Tecnológico de Celaya/TecNM - México

    using Gtk.ShortNames, DataFrames, DefaultApplication, Mustache

    # Function to call the GUI
    export PIAssistantGUI()

    # Include the main file .fl
    include("mainPIGUI.jl")
end # module
