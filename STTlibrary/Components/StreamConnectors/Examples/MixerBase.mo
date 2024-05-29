within STTlibrary.Components.StreamConnectors.Examples;
partial model MixerBase
  STTlibrary.Components.StreamConnectors.PressureBC p_H(p0 = 300000)  annotation (
    Placement(visible = true, transformation(origin = {-166, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.StreamConnectors.PressureBC p_C(p0 = 300000)  annotation (
    Placement(visible = true, transformation(origin = {-166, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.StreamConnectors.PressDrop dp_H(R = 10, wnom = 160)  annotation (
    Placement(visible = true, transformation(origin = {-136, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.StreamConnectors.PressDrop dp_C(R = 10, wnom = 160)  annotation (
    Placement(visible = true, transformation(origin = {-136, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.StreamConnectors.LinValve vlv_H(Av = 1e-3)  annotation (
    Placement(visible = true, transformation(origin = {-106, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.StreamConnectors.LinValve vlv_C(Av = 1e-3)  annotation (
    Placement(visible = true, transformation(origin = {-106, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.StreamConnectors.Tank tank(A = 0.3 * 0.3, hstart = 1e5, pstart = 150000)  annotation (
    Placement(visible = true, transformation(origin = {-58, -68}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  STTlibrary.Components.StreamConnectors.LinValve vlv_M(Av = 8e-3)  annotation (
    Placement(visible = true, transformation(origin = {-16, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.StreamConnectors.PressDrop dp_M(R = 10, wnom = 160)  annotation (
    Placement(visible = true, transformation(origin = {24, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.StreamConnectors.PressureBC p_sink annotation (
    Placement(visible = true, transformation(origin = {64, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(tank.fl_b, vlv_M.fl_a) annotation(
    Line(points = {{-44, -80}, {-26, -80}, {-26, -80}, {-26, -80}}));
  connect(vlv_C.fl_b, tank.fl_a) annotation(
    Line(points = {{-96, -80}, {-72, -80}, {-72, -80}, {-72, -80}}));
  connect(vlv_H.fl_b, tank.fl_a) annotation(
    Line(points = {{-96, -40}, {-80, -40}, {-80, -80}, {-72, -80}, {-72, -80}}));
  connect(dp_M.fl_b, p_sink.flange) annotation(
    Line(points = {{34, -80}, {54, -80}, {54, -80}, {54, -80}}));
  connect(vlv_M.fl_b, dp_M.fl_a) annotation(
    Line(points = {{-6, -80.2}, {4, -80.2}, {4, -80.4}, {14, -80.4}}));
  connect(p_C.flange, dp_C.fl_a) annotation(
    Line(points = {{-156, -80.2}, {-151, -80.2}, {-151, -80.2}, {-146, -80.2}, {-146, -80.2}, {-146, -80.2}, {-146, -80.2}, {-146, -80.2}}));
  connect(dp_C.fl_b, vlv_C.fl_a) annotation(
    Line(points = {{-126, -80}, {-121, -80}, {-121, -80}, {-116, -80}, {-116, -80}, {-116, -80}, {-116, -80}, {-116, -80}}));
  connect(dp_H.fl_b, vlv_H.fl_a) annotation(
    Line(points = {{-126, -40}, {-121, -40}, {-121, -40}, {-116, -40}, {-116, -40}, {-116, -40}, {-116, -40}, {-116, -40}}));
  connect(p_H.flange, dp_H.fl_a) annotation(
    Line(points = {{-156, -40.2}, {-151, -40.2}, {-151, -40.2}, {-146, -40.2}, {-146, -40.2}, {-146, -40.2}, {-146, -40.2}, {-146, -40.2}}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end MixerBase;