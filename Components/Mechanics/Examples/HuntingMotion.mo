within STTlibrary.Components.Mechanics.Examples;
model HuntingMotion
  extends Modelica.Icons.Example;
  Modelica.Mechanics.Translational.Components.Mass mass(m = 0.5, s(start = 0, fixed = true), v(fixed = true, start = 0))  annotation (
    Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.Mechanics.FrictionForceLinear friction(D = 0.1, FrictionNull = false, fc = 1, fs = 1.3)  annotation (
    Placement(visible = true, transformation(origin = {10, 1.55431e-15}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.PositionSensor sMeas annotation (
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI(T = 0.5, initType = Modelica.Blocks.Types.Init.InitialState, k = 2)  annotation (
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor vMeas annotation (
    Placement(visible = true, transformation(origin = {70, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain Kd(k = -6)  annotation (
    Placement(visible = true, transformation(origin = {-88, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sources.Force force annotation (
    Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation (
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation (
    Placement(visible = true, transformation(origin = {-130, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant SP(k = 1)  annotation (
    Placement(visible = true, transformation(origin = {-170, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  connect(SP.y, feedback.u1) annotation (
    Line(points = {{-158, 30}, {-138, 30}, {-138, 30}, {-138, 30}}, color = {0, 0, 127}));
  connect(feedback.y, PI.u) annotation (
    Line(points = {{-120, 30}, {-104, 30}, {-104, 30}, {-102, 30}}, color = {0, 0, 127}));
  connect(PI.y, add.u1) annotation (
    Line(points = {{-78, 30}, {-70, 30}, {-70, 6}, {-62, 6}, {-62, 6}}, color = {0, 0, 127}));
  connect(Kd.y, add.u2) annotation (
    Line(points = {{-76, -6}, {-62, -6}, {-62, -6}, {-62, -6}}, color = {0, 0, 127}));
  connect(add.y, force.f) annotation (
    Line(points = {{-38, 0}, {-34, 0}, {-34, 0}, {-32, 0}}, color = {0, 0, 127}));
  connect(force.flange, friction.fl_a) annotation (
    Line(points = {{-10, 0}, {8, 0}, {8, 0}, {8, 0}}, color = {0, 127, 0}));
  connect(friction.fl_b, mass.flange_a) annotation (
    Line(points = {{12, 0}, {30, 0}, {30, 0}, {30, 0}}, color = {0, 127, 0}));
  connect(mass.flange_b, sMeas.flange) annotation (
    Line(points = {{50, 0}, {60, 0}, {60, 0}, {60, 0}}, color = {0, 127, 0}));
  connect(mass.flange_b, vMeas.flange) annotation (
    Line(points = {{50, 0}, {54, 0}, {54, -18}, {60, -18}, {60, -18}}, color = {0, 127, 0}));
  connect(vMeas.v, Kd.u) annotation (
    Line(points = {{82, -18}, {88, -18}, {88, -40}, {-110, -40}, {-110, -6}, {-100, -6}, {-100, -6}}, color = {0, 0, 127}));
  connect(sMeas.s, feedback.u2) annotation (
    Line(points = {{82, 0}, {94, 0}, {94, -46}, {-130, -46}, {-130, 22}, {-130, 22}}, color = {0, 0, 127}));

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-6, Interval = 0.1));
end HuntingMotion;