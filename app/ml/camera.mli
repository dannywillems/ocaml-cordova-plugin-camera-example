(* -------------------------------------------------------------------------- *)
(* OCaml types for the options object *)
(* See the official documentation to know what does it mean *)
type destination_type
val data_url : destination_type
val file_uri : destination_type
val native_uri : destination_type
val destination_type_to_int : destination_type -> int

type encoding_type
val jpeg : encoding_type
val png : encoding_type
val encoding_type_to_int : encoding_type -> int

type media_type
val picture : media_type
val video : media_type
val allmedia : media_type
val media_type_to_int : media_type -> int

type picture_source_type
val photo_library : picture_source_type
val source_camera : picture_source_type
val saved_photo_album : picture_source_type
val picture_source_type_to_int : picture_source_type -> int

type pop_over_array_direction
val arrow_up : pop_over_array_direction
val arrow_down : pop_over_array_direction
val arrow_left : pop_over_array_direction
val arrow_right : pop_over_array_direction
val pop_over_array_direction_to_int : pop_over_array_direction -> int

type direction
val back : direction
val front : direction
val direction_to_int : direction -> int
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

val create_camera_pop_over_options :
  ?x:int                              ->
  ?y:int                              ->
  ?width:int                          ->
  ?height:int                         ->
  ?arrow_dir:pop_over_array_direction ->
  unit                                -> camera_pop_over_options
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

val create_options :
  ?quality:int                                            ->
  ?destination_type:destination_type                      ->
  ?source_type:picture_source_type                        ->
  ?allow_edit:bool                                        ->
  ?encoding_type:encoding_type                            ->
  ?target_width:int option                                ->
  ?target_height:int option                               ->
  ?media_type:media_type                                  ->
  ?correct_orientation:bool option                        ->
  ?save_to_photo_album:bool option                        ->
  ?pop_over_options:camera_pop_over_options option        ->
  ?camera_direction:direction                             ->
  unit                                                    -> options
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
val camera : unit -> camera Js.t
(* -------------------------------------------------------------------------- *)
