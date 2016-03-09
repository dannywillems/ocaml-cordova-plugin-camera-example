let on_device_ready _ =
  let succ str = Dom_html.window##(alert str) in
  let err str = Dom_html.window##(alert str) in
  let camera = Camera.camera () in
  camera##(getPicture succ err (Camera.create_options
  ~save_to_photo_album:(Some true) ~allow_edit:false ()));
  Js._false

let _ =
  Dom.addEventListener Dom_html.document (Dom.Event.make "deviceready")
(Dom_html.handler on_device_ready) Js._false
