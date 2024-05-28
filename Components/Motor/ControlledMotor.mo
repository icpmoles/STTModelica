within STTlibrary.Components.Motor;
model ControlledMotor
  parameter SI.RotationalDampingConstant Dm = 0.03 "Rotor damping constant";
  parameter SI.Inertia Jm = 0.11 "Rotor moment of inertia";
  parameter SI.ElectricalTorqueConstant Kt = 0.764 "shape function constant";
  parameter SI.Resistance R = 0.05 "Phase resistance";
  parameter SI.Inductance L = 0.98e-3 "Phase Inductance";
  parameter Integer p = 4 "stator elecrical poles";

  Modelica.Electrical.Analog.Sources.SignalVoltage Va annotation (
    Placement(visible = true, transformation(origin = {28.8467, 19.7518}, extent = {{12, -12}, {-12, 12}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vc annotation (
    Placement(visible = true, transformation(origin = {-29.9708, -20.1752}, extent = {{12, -12}, {-12, 12}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage Vb annotation (
    Placement(visible = true, transformation(origin = {0.5839, 0.3066}, extent = {{12, -12}, {-12, 12}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
    Placement(visible = true, transformation(origin = {-49.7518, -46.3358}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  STTlibrary.Components.Motor.Vreference Vref(Dm = Dm, Kt = Kt, R = R, L = L, p = p) annotation (
    Placement(visible = true, transformation(origin = {-52.2482, 47.4453}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  STTlibrary.Components.Motor.BrushlessMotor BMotor(R = R, L = L, Dm = Dm, Jm = Jm, p = p, Kt = Kt) annotation (
    Placement(visible = true, transformation(origin = {70.6131, 0.3358}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation (
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput wref annotation (
    Placement(visible = true, transformation(origin = {-100, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(Vref.OC, Vc.v) annotation (
    Line(points = {{-40, 41}, {-30, 41}, {-30, -6}}, color = {0, 0, 127}));
  connect(Vref.OB, Vb.v) annotation (
    Line(points = {{-40, 47}, {0, 47}, {0, 14}}, color = {0, 0, 127}));
  connect(Vref.OA, Va.v) annotation (
    Line(points = {{-40, 55}, {28, 55}, {28, 34}}, color = {0, 0, 127}));
  connect(wref, Vref.wref) annotation (
    Line(points = {{-100, 48}, {-82, 48}, {-82, 47}, {-64, 47}}, color = {0, 0, 127}));
  connect(Vc.p, BMotor.PC) annotation (
    Line(points = {{-18, -20}, {50, -20}, {50, -6}, {58, -6}}, color = {0, 0, 255}));
  connect(Vb.p, BMotor.PB) annotation (
    Line(points = {{12, 0}, {58, 0}, {58, 0}, {58, 0}}, color = {0, 0, 255}));
  connect(Va.p, BMotor.PA) annotation (
    Line(points = {{40, 20}, {50, 20}, {50, 8}, {58, 8}, {58, 8}}, color = {0, 0, 255}));
  connect(Vc.n, ground1.p) annotation (
    Line(points = {{-42, -20}, {-50, -20}, {-50, -34}, {-50, -34}}, color = {0, 0, 255}));
  connect(Vb.n, ground1.p) annotation (
    Line(points = {{-12, 0}, {-50, 0}, {-50, -34}, {-50, -34}}, color = {0, 0, 255}));
  connect(Va.n, ground1.p) annotation (
    Line(points = {{16, 20}, {-50, 20}, {-50, -34}, {-50, -34}}, color = {0, 0, 255}));
  connect(BMotor.shaft, flange_b) annotation (
    Line(points = {{82, 0}, {98, 0}, {98, 0}, {100, 0}}));
  annotation (
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-06, Interval = 0.004),
    Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 60}, {100, -60}}), Rectangle(origin = {0, -70}, fillPattern = FillPattern.Solid, extent = {{-80, 10}, {80, -10}}), Text(origin = {0, -100}, lineColor = {0, 0, 255}, extent = {{-100, 12}, {100, -12}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
end ControlledMotor;
