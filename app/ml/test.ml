let on_device_ready _ =
  let succ str =
    let doc = Dom_html.document in
    let x = Dom_html.createImg doc in
    x##.src := (Js.string str);
    x##.width := 200;
    Dom.appendChild doc##.body x
  in
  let err str = Dom_html.window##(alert (Js.string str)) in
  Cordova_camera.get_picture succ err ()

let _ = Cordova.Event.device_ready on_device_ready
