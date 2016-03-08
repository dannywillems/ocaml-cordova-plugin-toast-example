(* TODO
type cb_succ
type cb_err
*)

(* -------------------------------------------------------------------------- *)

(**
 * Object representing the style of a toast
 *)
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
val create_toast_styling :
  ?opacity:float      ->
  ?bg_color:string    ->
  ?text_color:string  ->
  ?radius:int         ->
  ?h_padding:int      ->
  ?v_padding:int      ->
  unit                ->
  toast_styling
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Options *)

(**
 * Time during the toast must be shown
 *)
type duration
val short  : duration
val long   : duration

(**
 * The toast position
 *)
type position
val top    : position
val bottom : position
val center : position

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
val create_options : string -> duration -> position -> toast_styling -> options
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
val toast : unit -> toast Js.t
(* -------------------------------------------------------------------------- *)
