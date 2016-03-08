let on_device_ready _ =
  let t = Toast.toast () in
  (*
  let opt = Toast.create_options "Hello world" Toast.short
  Toast.top (Toast.create_toast_styling ()) in
  t##showWithOptions opt;
  *)
  t##showShortTop (Js.string "Hello world");
  Js._false

let _ =
  Dom.addEventListener Dom_html.document (Dom.Event.make "deviceready")
  (Dom_html.handler on_device_ready) Js._false
