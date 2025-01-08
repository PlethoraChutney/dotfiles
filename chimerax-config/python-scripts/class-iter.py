def classiter(session, vser, label_text, frameduration = 10):
    from chimerax.core.commands import run
    root_model = list(vser)[0]
    vols = root_model.child_models()
    run(session, f"perframe \"vser play #{root_model.id[0]} jump $1; 2dlab delete; 2dlab text '{label_text} $1' xpos 0.025 ypos 0.95 font Inter\" range 0,{len(vols) - 1} frames {len(vols)} interval {frameduration}")

def register_command(logger):
    from chimerax.core.commands import register, CmdDesc, StringArg, ModelsArg, IntArg

    desc = CmdDesc(
        required = [
            ("vser", ModelsArg),
            ("label_text", StringArg),
        ],
        optional = [
            ("frameduration", IntArg)
        ],
        synopsis = "Display and label a volume series. Each volume is shown for {frameduration} frames."
    )

    register("classiter", desc, classiter, logger = logger)

register_command(session.logger)
