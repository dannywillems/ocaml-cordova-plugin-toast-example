type action =
  | ShortTop
  | ShortBottom
  | ShortCenter
  | LongTop
  | LongBottom
  | LongCenter
  | Hide

let action_to_str a = match a with
  | ShortTop -> "Short Top"
  | ShortBottom -> "Short Bottom"
  | ShortCenter -> "Short Center"
  | LongTop -> "Long Top"
  | LongBottom -> "Long Bottom"
  | LongCenter -> "Long Center"
  | Hide -> "Hide"

let new_button action text =
  let row = Dom_html.createDiv Dom_html.document in
  let col = Dom_html.createDiv Dom_html.document in
  let button = Dom_html.createButton Dom_html.document in
  row##.className := (Js.string "row");
  col##.className := (Js.string "col s12");
  button##.className := (Js.string "waves-effect waves-light btn");
  button##.innerHTML := (Js.string (action_to_str action));
  Lwt.async
  ( fun () ->
    Lwt_js_events.clicks button
    ( fun _ev _thread ->
      let t = Toast.toast () in
      ignore (match action with
      | ShortTop -> t##(showShortTop (Js.string text))
      | ShortBottom -> t##showShortBottom (Js.string text)
      | ShortCenter -> t##showShortCenter (Js.string text)
      | LongTop -> t##showLongTop (Js.string text)
      | LongBottom -> t##showLongBottom (Js.string text)
      | LongCenter -> t##showLongCenter (Js.string text)
      | Hide -> t##hide);
      Lwt.return ()
    )
  );
  Dom.appendChild col button;
  Dom.appendChild row col;
  row

let on_device_ready _ =
  (*
  let opt = Toast.create_options "Hello world" Toast.short
  Toast.top (Toast.create_toast_styling ()) in
  t##showWithOptions opt;
  *)
  let doc = Dom_html.document in
  let div = Dom_html.createDiv doc in
  div##.className := (Js.string "container center");
  Dom.appendChild div (new_button ShortBottom "Hello world");
  Dom.appendChild div (new_button ShortCenter "Hello world");
  Dom.appendChild div (new_button ShortTop "Hello world");
  Dom.appendChild div (new_button LongBottom "Hello world");
  Dom.appendChild div (new_button LongCenter "Hello world");
  Dom.appendChild div (new_button LongTop "Hello world");
  Dom.appendChild div (new_button Hide "");
  Dom.appendChild doc##.body div;
  Js._false

let _ =
  Dom.addEventListener Dom_html.document (Dom.Event.make "deviceready")
  (Dom_html.handler on_device_ready) Js._false
