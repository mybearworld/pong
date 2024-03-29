import mroew/project
import mroew/sprite
import mroew/blocks.{OInt, OString, c}
import mroew/blocks/control.{All}
import mroew/blocks/events
import mroew/blocks/motion
import mroew/blocks/looks
import mroew/blocks/ops
import mroew/blocks/sensing

pub fn main() {
  project.project(stage())
  |> project.add_sprite(ball())
  |> project.add_sprite(paddle())
  |> project.add_sprite(thumbnail())
  |> project.export("pong.sb3")
}

fn stage() {
  sprite.sprite("Stage")
  |> sprite.costume("Blank", "./assets/blank.svg", 0, 0)
}

fn thumbnail() {
  sprite.sprite("Thumbnail")
  |> sprite.costume("Thumbnail", "./assets/thumbnail.svg", 480, 360)
  |> sprite.blocks(
    events.on_flag()
    |> looks.hide(),
  )
}

fn ball() {
  sprite.sprite("Ball")
  |> sprite.costume("Ball", "./assets/ball.svg", 12, 12)
  |> sprite.blocks(
    events.on_flag()
    |> motion.position(
      ops.random(OInt(-220), OInt(220)),
      ops.random(OInt(0), OInt(160)),
    )
    |> motion.set_direction(ops.random(OInt(0), OInt(359)))
    |> c(
      control.forever()
      |> motion.move(OInt(8))
      |> motion.bounce_on_edge()
      |> c(
        control.cond(sensing.touching_sprite(OString("Paddle")))
        |> motion.turn(OInt(60)),
      )
      |> c(
        control.cond(
          motion.y()
          |> ops.lt(OInt(-165)),
        )
        |> control.stop(All),
      ),
    ),
  )
}

fn paddle() {
  sprite.sprite("Paddle")
  |> sprite.costume("Paddle", "./assets/paddle.svg", 68, 8)
  |> sprite.blocks(
    events.on_flag()
    |> c(
      control.forever()
      |> motion.position(sensing.mouse_x(), OInt(-160)),
    ),
  )
}
