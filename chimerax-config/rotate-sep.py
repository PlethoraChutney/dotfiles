def rotate_separately(session, axis, degrees, frames, models = None):
    """
    Rotate models independently (rather than rotating the whole scene).

    Parameters
    ----------
    axis: Scene axis about which to rotate
    degrees: Degrees per frame to rotate
    frames: Number of frames over which to rotate
    models: (optional) Models to rotate. If this argument is not provided,
        all models are rotated.
    """
    from chimerax.core.commands import run

    if models is None:
        models = session.models
    base_ids = set(m.id[0] for m in models)
    for m_id in base_ids:
        run(session, f"turn {axis} {degrees} {frames} models #{m_id} center #{m_id}")

def register_command(logger):
    from chimerax.core.commands import register, CmdDesc, StringArg, FloatArg, ModelsArg, IntArg

    desc = CmdDesc(
        required = [
            ("axis", StringArg),
            ("degrees", FloatArg),
            ("frames", IntArg)
        ],
        optional = [
            ("models", ModelsArg)
        ],
        synopsis = "Rotate maps independently"
    )
    register("rot_all", desc, rotate_separately, logger = logger)

register_command(session.logger)