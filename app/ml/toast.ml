(* TODO
type cb_succ
type cb_err
*)

(* -------------------------------------------------------------------------- *)
type toast_styling =
  <
    opacity           : float Js.readonly_prop ;
    backgroundColor   : Js.js_string Js.t Js.readonly_prop ;
    textColor         : Js.js_string Js.t Js.readonly_prop ;
    cornerRadius      : int Js.readonly_prop ;
    horizontalPadding : int Js.readonly_prop ;
    verticalPadding   : int Js.readonly_prop
  > Js.t

(**
 * Create a toast style.
 * Default values to radius and paddin must be relative to the platform. Device
 * plugin must be used
 *)
let create_toast_styling ?(opacity=0.8) ?(bg_color="#333333")
  ?(text_color="#FFFFFF") ?(radius=20) ?(h_padding=16) ?(v_padding=12) () =
  object%js
    val opacity = opacity
    val backgroundColor = Js.string bg_color
    val textColor = Js.string text_color
    val cornerRadius = radius
    val horizontalPadding = h_padding
    val verticalPadding = v_padding
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Options *)

(**
 * Time during the toast must be shown
 *)
type duration = Short | Long
let short     = Short
let long      = Long

(**
 * The toast position
 *)
type position = Top | Bottom | Center
let top       = Top
let bottom    = Bottom
let center    = Center

(**
 * Options object for showWithOptions method
 *)
type options =
  <
    message : Js.js_string Js.t Js.readonly_prop ;
    duration : Js.js_string Js.t Js.readonly_prop ;
    position : Js.js_string Js.t Js.readonly_prop ;
    styling : toast_styling Js.readonly_prop
  > Js.t

(**
 * Constructor for an options object. Use ocaml type, and not Js type. The
 * transformation is done automatically.
 *)
let create_options m d p s =
  object%js
    val message = Js.string m
    val duration =
      match d with
      | Short   -> Js.string "short"
      | Long    -> Js.string "long"
    val position =
      match p with
      | Top     -> Js.string "top"
      | Center  -> Js.string "center"
      | Bottom  -> Js.string "bottom"
    val styling = s
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Binding to toast object *)
class type toast =
  object
    method showShortTop       : Js.js_string Js.t -> unit Js.meth
    method showShortCenter    : Js.js_string Js.t -> unit Js.meth
    method showShortBottom    : Js.js_string Js.t -> unit Js.meth
    method showLongTop        : Js.js_string Js.t -> unit Js.meth
    method showLongCenter     : Js.js_string Js.t -> unit Js.meth
    method showLongBottom     : Js.js_string Js.t -> unit Js.meth
    method hide               : unit Js.meth

    method showWithOptions    : options -> unit Js.meth

    (* TODO
    method showShortTop_cb    : Js.js_string Js.t -> cb_succ -> cb_err -> unit Js.meth
    method showShortCenter_cb : Js.js_string Js.t -> cb_succ -> cb_err -> unit Js.meth
    method showShortBottom_cb : Js.js_string Js.t -> cb_succ -> cb_err -> unit Js.meth
    method showLongTop_cb     : Js.js_string Js.t -> cb_succ -> cb_err -> unit Js.meth
    method showLongCenter_cb  : Js.js_string Js.t -> cb_succ -> cb_err -> unit Js.meth
    method showLongBottom_cb  : Js.js_string Js.t -> cb_succ -> cb_err -> unit Js.meth
    *)
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
let toast () = Js.Unsafe.js_expr ("window.plugins.toast")
(* -------------------------------------------------------------------------- *)
