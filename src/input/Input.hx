package input;

import hxd.Event;

class Input {
  public var pointerPosition : h3d.col.Point;
  public var pointerDown : Bool;
  public var pointerWheel : Float;

  public var up : Bool;
  public var down : Bool;
  public var left : Bool;
  public var right : Bool;

  var camera : h3d.Camera;
  var tablePlane : h3d.col.Plane;

  public function new(s3d) {
    camera = s3d.camera;

    tablePlane = new h3d.col.Plane(0, 1, 0, 0);

    hxd.Window.getInstance().addEventTarget(onEvent);
  }

  function onEvent(event : hxd.Event) {
    // trace(event.toString());

    switch event.kind {
      case EMove:
        updatePointerPosition(event.relX, event.relY);
      case EPush:
        if (event.button == 0) {
          updatePointerPosition(event.relX, event.relY);
          pointerDown = true;
        }
      case ERelease:
        if (event.button == 0) {
          pointerDown = false;
        }
      case EWheel:
        pointerWheel = event.wheelDelta;
      case EKeyDown:
        switch event.keyCode {
          case 87: up    = true;
          case 83: down  = true;
          case 65: left  = true;
          case 68: right = true;
          default:
        }
      case EKeyUp:
        switch event.keyCode {
          case 87: up    = false;
          case 83: down  = false;
          case 65: left  = false;
          case 68: right = false;
          default:
        }
      default:
        trace(event);
    }
  }

  function updatePointerPosition(x, y) {
    pointerPosition =
      camera
        .rayFromScreen(x, y)
        .intersect(tablePlane);
  }
}
