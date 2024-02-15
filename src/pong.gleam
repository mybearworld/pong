import mroew/project
import mroew/sprite
import mroew/blocks.{OInt, c}
import mroew/blocks/control
import mroew/blocks/events
import mroew/blocks/motion
import mroew/blocks/ops

pub fn main() {
  project.project(stage())
  |> project.add_sprite(ball())
  |> project.export("pong.sb3")
}

fn stage() {
  sprite.sprite("Stage")
  |> sprite.costume("Blank", "./assets/blank.svg")
}

fn ball() {
  sprite.sprite("Ball")
  |> sprite.costume("Ball", "./assets/ball.svg")
  |> sprite.blocks(
    events.on_flag()
    |> motion.position(
      ops.random(OInt(-220), OInt(220)),
      ops.random(OInt(-160), OInt(160)),
    )
    |> motion.set_diretion(ops.random(OInt(0), OInt(359)))
    |> c(
      control.forever()
      |> motion.move(OInt(10))
      |> motion.bounce_on_edge(),
    ),
  )
}
