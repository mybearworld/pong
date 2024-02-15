import mroew/project
import mroew/sprite

pub fn main() {
  project.project(stage())
  |> project.export("pong.sb3")
}

fn stage() {
  sprite.sprite("Stage")
  |> sprite.costume("Blank", "./assets/blank.svg")
}
