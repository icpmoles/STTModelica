within STTlibrary.Components.Mechanics.Examples;
model StickSlipMotion
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.RealExpression positionSP(y = time * 0.1) annotation (
    Placement(visible = true, transformation(origin = {44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Translational.Components.Spring spring(c = 2) annotation (
    Placement(visible = true, transformation(origin = {-18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Translational.Components.Mass mass(a(fixed = true, start = 0), m = 1, s(start = 0), v(fixed = true, start = 0)) annotation (
    Placement(visible = true, transformation(origin = {-72, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Translational.Sources.Position position(exact = true) annotation (
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  STTlibrary.Components.Mechanics.FrictionForceLinear frictionForceL(D = 0.1, FrictionNull = false, fc = 1, fs = 1.3) annotation (
    Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 180)));
equation
  connect(mass.flange_a, frictionForceL.fl_b) annotation (
    Line(points = {{-62, 0}, {-46, 0}, {-46, 0}, {-46, 0}}, color = {0, 127, 0}));
  connect(frictionForceL.fl_a, spring.flange_b) annotation (
    Line(points = {{-42.4, 0}, {-28.4, 0}, {-28.4, 0}, {-28.4, 0}}, color = {0, 127, 0}));
  connect(spring.flange_a, position.flange) annotation (
    Line(points = {{-8, 0}, {-4, 0}, {-4, 0}, {0, 0}, {0, 0}, {0, 0}}, color = {0, 127, 0}));
  connect(position.s_ref, positionSP.y) annotation (
    Line(points = {{22, 0}, {33, 0}}, color = {0, 0, 127}));
  annotation (
    experiment(StartTime = 0, StopTime = 40, Tolerance = 1e-8, Interval = 0.04));
end StickSlipMotion;
