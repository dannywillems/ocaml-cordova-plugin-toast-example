type action =
  | ShortTop
  | ShortBottom
  | ShortCenter
  | LongTop
  | LongBottom
  | LongCenter
  | Hide
  | Styling

let action_to_str a = match a with
  | ShortTop -> "Short Top"
  | ShortBottom -> "Short Bottom"
  | ShortCenter -> "Short center"
  | LongTop -> "Long Top"
  | LongBottom -> "Long Bottom"
  | LongCenter -> "Long Center"
  | Hide -> "Hide"
  | Styling -> "Styling"

let new_button action =
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
    | ShortTop -> Cordova_toast.show_short_top text
    | ShortBottom -> Cordova_toast.show_short_bottom text
    | ShortCenter -> Cordova_toast.show_short_center text
    | LongTop -> Cordova_toast.show_long_top text
    | LongBottom -> Cordova_toast.show_long_bottom text
    | LongCenter -> Cordova_toast.show_long_center text
    | Hide -> Cordova_toast.hide);
    Lwt.return ()
  );
  *)

  button##.onclick := Dom.handler
  (
    fun e ->
    ignore (match action with
    | ShortTop -> Cordova_toast.show_short_top t ()
    | ShortBottom -> Cordova_toast.show_short_bottom t ()
    | ShortCenter -> Cordova_toast.show_short_center t ()
    | LongTop -> Cordova_toast.show_long_top t ()
    | LongBottom -> Cordova_toast.show_long_bottom t ()
    | LongCenter -> Cordova_toast.show_long_center t ()
    | Styling ->
        Cordova_toast.show_with_options
          ~options:
          (
            Cordova_toast.create_options
              ~message:"Styling"
              ~duration:Cordova_toast.Long
              ~position:Cordova_toast.Center
              ~styling:
              (
                Cordova_toast.create_styling_toast
                  ~opacity:0.9
                  ~background_color:"red"
                  ~corner_radius:20
                  ~vertical_padding:30
                  ~horizontal_padding:30
                  ()
              )
              ()
          )
          ()
    | Hide -> Cordova_toast.hide ());
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
  Dom.appendChild div (new_button Styling);

  Dom.appendChild doc##.body div;
  Js._false

let _ =
  Dom.addEventListener Dom_html.document (Dom.Event.make "deviceready")
  (Dom_html.handler on_device_ready) Js._false
