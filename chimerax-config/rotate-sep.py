def rotate_separately(session, models, axis, degrees, frames):
    from chimerax.core.commands import run
    base_ids = set(m.id[0] for m in models)
    for m_id in base_ids:
        run(session, f"turn {axis} {degrees} {frames} models #{m_id} center #{m_id}")

def register_command(logger):
    from chimerax.core.commands import register, CmdDesc, StringArg, FloatArg, ModelsArg, IntArg

    desc = CmdDesc(
        required = [
            ("models", ModelsArg),
            ("axis", StringArg),
            ("degrees", FloatArg),
            ("frames", IntArg)
        ],
        synopsis = "Rotate maps independently"
    )
    register("iturn_all", desc, rotate_separately, logger = logger)

register_command(session.logger)