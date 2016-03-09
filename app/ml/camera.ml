(* -------------------------------------------------------------------------- *)
(* OCaml types for the options object *)
(* See the official documentation to know what does it mean *)
(* ------------------------- *)
type destination_type = Data_url | File_uri | Native_uri
let data_url          = Data_url
let file_uri          = File_uri
let native_uri        = Native_uri
let destination_type_to_int v = match v with
  | Data_url -> 0
  | File_uri -> 1
  | Native_uri -> 2
(* ------------------------- *)

(* ------------------------- *)
type encoding_type = Jpeg | Png
let jpeg = Jpeg
let png = Png
let encoding_type_to_int v = match v with
  | Jpeg -> 0
  | Png -> 1
(* ------------------------- *)

(* ------------------------- *)
type media_type = Picture | Video | Allmedia
let picture = Picture
let video = Video
let allmedia = Allmedia
let media_type_to_int v = match v with
  | Picture -> 0
  | Video -> 1
  | Allmedia -> 2
(* ------------------------- *)

(* ------------------------- *)
type picture_source_type = Photolibrary | Camera | Saved_photo_album
let photo_library = Photolibrary
let source_camera = Camera
let saved_photo_album = Saved_photo_album
let picture_source_type_to_int v = match v with
  | Photolibrary -> 0
  | Camera -> 1
  | Saved_photo_album -> 2
(* ------------------------- *)

(* ------------------------- *)
type pop_over_array_direction =
  | Arrow_up
  | Arrow_down
  | Arrow_left
  | Arrow_right
  | Arrow_any
let arrow_up = Arrow_up
let arrow_down = Arrow_down
let arrow_left = Arrow_left
let arrow_right = Arrow_right
let arrow_any = Arrow_any
let pop_over_array_direction_to_int v = match v with
  | Arrow_up -> 1
  | Arrow_down -> 2
  | Arrow_left -> 4
  | Arrow_right -> 8
  | Arrow_any -> 15
(* ------------------------- *)

(* ------------------------- *)
type direction = Back | Front
let back = Back
let front = Front
let direction_to_int v = match v with
  | Back -> 0
  | Front -> 1
(* ------------------------- *)
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Interface to the cameraPopoverOptions object *)
type camera_pop_over_options =
  <
    x          : int Js.readonly_prop ;
    y          : int Js.readonly_prop ;
    width      : int Js.readonly_prop ;
    height     : int Js.readonly_prop ;
    arrowDir   : int Js.readonly_prop
  > Js.t

let create_camera_pop_over_options
  ?(x=0) ?(y=32) ?(width=320) ?(height=480) ?(arrow_dir=Arrow_any) () :
    camera_pop_over_options =
  object%js
    val x           = x
    val y           = y
    val width       = width
    val height      = height
    val arrowDir    = pop_over_array_direction_to_int arrow_dir
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Interface to the options javascript object *)
type options =
  <
    quality             : int Js.readonly_prop ;
    destinationType     : int Js.readonly_prop ;
    sourceType          : int Js.readonly_prop ;
    allowEdit           : bool Js.readonly_prop ;
    encodingType        : int Js.readonly_prop ;
    targetWidth         : int Js.optdef Js.readonly_prop ;
    targetHeight        : int Js.optdef Js.readonly_prop ;
    mediaType           : int Js.readonly_prop ;
    correctOrientation  : bool Js.optdef Js.readonly_prop ;
    saveToPhotoAlbum    : bool Js.optdef Js.readonly_prop ;
    popoverOptions      : camera_pop_over_options Js.optdef Js.readonly_prop ;
    cameraDirection     : int Js.readonly_prop
  > Js.t

let create_options
  ?(quality=50) ?(destination_type=File_uri)
  ?(source_type=Camera) ?(allow_edit=true) ?(encoding_type=Jpeg)
  ?(target_width=None) ?(target_height=None) ?(media_type=Picture)
  ?(correct_orientation=None) ?(save_to_photo_album=None)
  ?(pop_over_options=None) ?(camera_direction=Back) () : options =
  object%js
    val quality             = quality
    val destinationType     = destination_type_to_int destination_type
    val sourceType          = picture_source_type_to_int source_type
    val allowEdit           = allow_edit
    val encodingType        = encoding_type_to_int encoding_type
    val targetWidth         = match target_width with
      | None -> Js.undefined
      | Some x -> Js.def x
    val targetHeight        = match target_height with
      | None -> Js.undefined
      | Some x -> Js.def x
    val mediaType           = media_type_to_int media_type
    val correctOrientation  = match correct_orientation with
      | None -> Js.undefined
      | Some x -> Js.def x
    val saveToPhotoAlbum    = match save_to_photo_album with
      | None -> Js.undefined
      | Some x -> Js.def x
    val popoverOptions      = match pop_over_options with
      | None -> Js.undefined
      | Some x -> Js.def x
    val cameraDirection     = direction_to_int camera_direction
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Binding to the camera *)
class type camera =
  object
    method getPicture : (Js.js_string Js.t -> unit) ->
                        (Js.js_string Js.t -> unit) ->
                        options                     ->
                        unit Js.meth
    method cleanUp    : (unit -> unit)              ->
                        (unit -> unit)              ->
                        unit Js.meth
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Get the navigator.camera object *)
let camera () : camera Js.t = Js.Unsafe.js_expr ("navigator.camera")
(* -------------------------------------------------------------------------- *)
