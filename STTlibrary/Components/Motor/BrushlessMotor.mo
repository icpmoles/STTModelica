within STTlibrary.Components.Motor;
model BrushlessMotor
  // brushless motor model
  parameter SI.Resistance R "Phase resistance";
  parameter SI.Inductance L "Phase Inductance";
  parameter SI.RotationalDampingConstant Dm "damping constant";
  parameter SI.Inertia Jm "Rotor moment of inertia";
  parameter Integer p "stator elecrical poles";
  parameter SI.ElectricalTorqueConstant Kt "shape function constant";

  STTlibrary.Components.Motor.EMF3 RotorEmf(p = p, Kt = Kt) annotation (
    Placement(visible = true, transformation(origin = {21.8792, 7.29108}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin PA annotation (
    Placement(visible = true, transformation(origin = {-99.3874, 51.9138}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-99.3874, 61.9138}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin PB annotation (
    Placement(visible = true, transformation(origin = {-99.3874, 6.9485}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-99.3874, 0.9485}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin PC annotation (
    Placement(visible = true, transformation(origin = {-98.8939, -34.1382}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-100.894, -60.1382}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia RotorInertia(J = Jm, phi(fixed = true, start = 0), w(fixed = true, start = 0), a(fixed = false, start = 0)) annotation (
    Placement(visible = true, transformation(origin = {67.0341, 8.14651}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed1 annotation (
    Placement(visible = true, transformation(origin = {43.3791, -75.4134}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft annotation (
    Placement(visible = true, transformation(origin = {100.784, 7.68099}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {98.784, -0.31901}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Damper RotorBearing(d = Dm, phi_rel(start = 0, fixed = false), w_rel(fixed = false, start = 0), a_rel(fixed = false, start = 0)) annotation (
    Placement(visible = true, transformation(origin = {44.4481, -33.9826}, extent = {{-12, 12}, {12, -12}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor Rc(R = R) annotation (
    Placement(visible = true, transformation(origin = {-65.3583, -33.0795}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor Lc(L = L, i(start = 0, fixed = false)) annotation (
    Placement(visible = true, transformation(origin = {-27.5026, -33.8057}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor Lb(L = L, i(start = 0, fixed = true)) annotation (
    Placement(visible = true, transformation(origin = {-26.8602, 7.42201}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor Rb(R = R) annotation (
    Placement(visible = true, transformation(origin = {-64.6321, 7.71064}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor La(L = L, i(start = 0, fixed = true)) annotation (
    Placement(visible = true, transformation(origin = {-26.0897, 52.8988}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor Ra(R = R) annotation (
    Placement(visible = true, transformation(origin = {-64.663, 53.2746}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
equation
  connect(Rc.n, Lc.p) annotation (
    Line(points = {{-53.3583, -33.0795}, {-38.5819, -33.0795}, {-38.5819, -33.8057}, {-39.5026, -33.8057}}));
  connect(Rb.n, Lb.p) annotation (
    Line(points = {{-52.6321, 7.71064}, {-39.8853, 7.71064}, {-39.8853, 7.42201}, {-38.8602, 7.42201}}));
  connect(Ra.n, La.p) annotation (
    Line(points = {{-52.663, 53.2746}, {-37.7998, 53.2746}, {-37.7998, 52.8988}, {-38.0897, 52.8988}}));
  connect(RotorInertia.flange_b, shaft) annotation (
    Line(points = {{79.0341, 8.14651}, {98.9219, 8.14651}, {98.9219, 7.68099}, {100.784, 7.68099}}));
  connect(RotorBearing.flange_b, fixed1.flange) annotation (
    Line(points = {{44.4481, -45.9826}, {43.3791, -45.9826}, {43.3791, -75.4134}}));
  connect(Ra.p, PA) annotation (
    Line(points = {{-76.663, 53.2746}, {-100, 53.2746}, {-100, 52}, {-100, 51.9138}, {-99.3874, 51.9138}}, color = {0, 0, 255}));
  connect(Rb.p, PB) annotation (
    Line(points = {{-76.6321, 7.71064}, {-100, 7.71064}, {-100, 6}, {-99.3874, 6}, {-99.3874, 6.9485}}, color = {0, 0, 255}));
  connect(Rc.p, PC) annotation (
    Line(points = {{-77.3583, -33.0795}, {-100, -33.0795}, {-100, -34}, {-100, -34.1382}, {-98.8939, -34.1382}}, color = {0, 0, 255}));
  connect(Lb.n, RotorEmf.PB) annotation (
    Line(points = {{-14.8602, 7.42201}, {8, 7.42201}, {8, 8}, {8, 8.16349}, {8.59688, 8.16349}}, color = {0, 0, 255}));
  connect(RotorEmf.shaft, RotorInertia.flange_a) annotation (
    Line(points = {{34, 8}, {54, 8}, {54, 8}, {56, 8}}));
  connect(RotorEmf.shaft, RotorBearing.flange_a) annotation (
    Line(points = {{34, 8}, {44, 8}, {44, -22}, {44, -22}}));
  connect(Lc.n, RotorEmf.PC) annotation (
    Line(points = {{-16, -34}, {0, -34}, {0, 0}, {10, 0}, {10, 0}}, color = {0, 0, 255}));
  connect(La.n, RotorEmf.PA) annotation (
    Line(points = {{-14, 52}, {0, 52}, {0, 14}, {10, 14}, {10, 14}}, color = {0, 0, 255}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 0}, extent = {{-65, 36}, {65, -36}}, textString = "B.motor"), Text(origin = {-1, -118}, lineColor = {0, 0, 255}, extent = {{-81, 12}, {81, -12}}, textString = "%name")}));
end BrushlessMotor;
