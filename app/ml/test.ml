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
  | ShortCenter -> "Short center"
  | LongTop -> "Long Top"
  | LongBottom -> "Long Bottom"
  | LongCenter -> "Long Center"
  | Hide -> "Hide"

let new_button action =
  let toast = Cordova_toast.t () in

  let row = Dom_html.createDiv Dom_html.document in
  let col = Dom_html.createDiv Dom_html.document in
  let button = Dom_html.createButton Dom_html.document in
  let t = action_to_str action in
  row##.className := (Js.string "row");
  col##.className := (Js.string "col s12");
  button##.className := (Js.string "waves-effect waves-light btn");
  button##.innerHTML := (Js.string t);

  (*
  Lwt_js_events.clicks button
  ( fun ev thread ->
    ignore (match action with
    | ShortTop -> toast#show_short_top text
    | ShortBottom -> toast#show_short_bottom text
    | ShortCenter -> toast#show_short_center text
    | LongTop -> toast#show_long_top text
    | LongBottom -> toast#show_long_bottom text
    | LongCenter -> toast#show_long_center text
    | Hide -> toast#hide);
    Lwt.return ()
  );
  *)

  button##.onclick := Dom.handler
  (
    fun e ->
    ignore (match action with
    | ShortTop -> toast#show_short_top t
    | ShortBottom -> toast#show_short_bottom t
    | ShortCenter -> toast#show_short_center t
    | LongTop -> toast#show_long_top t
    | LongBottom -> toast#show_long_bottom t
    | LongCenter -> toast#show_long_center t
    | Hide -> toast#hide);
    Js._false
  );

  Dom.appendChild col button;
  Dom.appendChild row col;
  row

let on_device_ready _ =
  let doc = Dom_html.document in
  let div = Dom_html.createDiv doc in
  div##.className := (Js.string "container center");

  Dom.appendChild div (new_button ShortTop);
  Dom.appendChild div (new_button ShortBottom);
  Dom.appendChild div (new_button ShortCenter);
  Dom.appendChild div (new_button LongTop);
  Dom.appendChild div (new_button LongBottom);
  Dom.appendChild div (new_button LongCenter);
  Dom.appendChild div (new_button Hide);

  Dom.appendChild doc##.body div;
  Js._false

let _ =
  Dom.addEventListener Dom_html.document (Dom.Event.make "deviceready")
  (Dom_html.handler on_device_ready) Js._false
