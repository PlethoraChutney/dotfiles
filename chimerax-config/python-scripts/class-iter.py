def classiter(session, vser, label_text):
    from chimerax.core.commands import run
    root_model = list(vser)[0]
    vols = root_model.child_models()
    run(session, f"perframe \"vser play #{root_model.id[0]} jump $1; 2dlab delete; 2dlab text '{label_text} $1' xpos 0.025 ypos 0.95 font Inter\" range 0,{len(vols) - 1} frames {len(vols)} interval 10")

def register_command(logger):
    from chimerax.core.commands import register, CmdDesc, StringArg, FloatArg, ModelsArg, IntArg

    desc = CmdDesc(
        required = [
            ("vser", ModelsArg),
            ("label_text", StringArg),
        ],
        synopsis = "Rotate maps independently"
    )

    register("classiter", desc, classiter, logger = logger)

register_command(session.logger)
