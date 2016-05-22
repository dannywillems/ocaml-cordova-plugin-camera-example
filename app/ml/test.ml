let on_device_ready _ =
  let succ str =
    let doc = Dom_html.document in
    let x = Dom_html.createImg doc in
    x##.src := (Js.string str);
    x##.width := 200;
    Dom.appendChild doc##.body x
  in
  let err str = Dom_html.window##(alert (Js.string str)) in
  let camera = Cordova_camera.t () in
  camera#get_picture succ err ();
  Js._false

let _ =
  Dom.addEventListener Dom_html.document (Dom.Event.make "deviceready")
(Dom_html.handler on_device_ready) Js._false
