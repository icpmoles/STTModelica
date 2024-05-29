within STTlibrary.Components.Mechanics.Examples;
model MechanicalStop
  extends Modelica.Icons.Example;
  STTlibrary.Components.Mechanics.SpringStop_sMin_sMax springStop_sMin_sMax(useSupport = true) annotation (
    Placement(visible = true, transformation(origin = {3.55271e-15, -6}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sources.Force force annotation (
    Placement(visible = true, transformation(origin = {-40, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 10, height = 50, startTime = 2) annotation (
    Placement(visible = true, transformation(origin = {-90, 16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp2(duration = 20, height = 100, startTime = 20) annotation (
    Placement(visible = true, transformation(origin = {-90, -2}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation (
    Placement(visible = true, transformation(origin = {-67, 9}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation (
    Placement(visible = true, transformation(origin = {-12, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 20, s(fixed = true, start = 0.5), v(fixed = true)) annotation (
    Placement(visible = true, transformation(origin = {36, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(springStop_sMin_sMax.fl_b, mass.flange_a) annotation (
    Line(points = {{4, 10}, {26, 10}, {26, 10}, {26, 10}}, color = {0, 127, 0}));
  connect(fixed.flange, springStop_sMin_sMax.support_sMin) annotation (
    Line(points = {{-12, -36}, {-12, -36}, {-12, -10}, {-12, -10}}, color = {0, 127, 0}));
  connect(add.y, force.f) annotation (
    Line(points = {{-60, 10}, {-52, 10}, {-52, 10}, {-52, 10}}, color = {0, 0, 127}));
  connect(ramp1.y, add.u1) annotation (
    Line(points = {{-84, 16}, {-80, 16}, {-80, 12}, {-76, 12}, {-76, 14}}, color = {0, 0, 127}));
  connect(ramp2.y, add.u2) annotation (
    Line(points = {{-84, -2}, {-80, -2}, {-80, 4}, {-76, 4}, {-76, 4}}, color = {0, 0, 127}));
  connect(force.flange, springStop_sMin_sMax.fl_a) annotation (
    Line(points = {{-30, 10}, {-4, 10}}, color = {0, 127, 0}));
  annotation (
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-6, Interval = 0.1));
end MechanicalStop;
