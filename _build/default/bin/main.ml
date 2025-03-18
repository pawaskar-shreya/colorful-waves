open Claudius

let tick (t : int) (screen : Screen.t) (_prev : Framebuffer.t) (_inputs : Base.KeyCodeSet.t) : Framebuffer.t =
  let ft = (Float.of_int t) *. 0.05 in  (* Adjust speed of wave animation *)
  let width, height = Screen.dimensions screen in
  let buffer = Framebuffer.init (width, height) (fun _x _y -> 0) in

  for x = 0 to width - 1 do
    let fx = Float.of_int x /. 10. in
    let y = (sin (fx +. ft) *. 40.) +. (cos (fx *. 0.5 -. ft) *. 30.) +. (Float.of_int height /. 2.) in
    let color = (x + t) mod 15 + 1 in  (* Cycle colors over time *)
    Framebuffer.draw_line x (Int.of_float y) x (Int.of_float y + 3) color buffer;
  done;

  buffer

(* ----- *)

let () =
  Palette.generate_plasma_palette 15 |>  (* Generate a colorful gradient palette *)
  Screen.create 640 480 1 |>             (* Create screen with 640x480 resolution *)
  Base.run "Colorful Waves" None tick    (* Run animation loop *)
