within STTlibrary.Components.DigitalController.Examples;
model ControlledTank
  extends Modelica.Icons.Example;
  STTlibrary.Components.DigitalController.SimpleTank tank1 annotation (
    Placement(visible = true, transformation(origin = {-24, 24}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  STTlibrary.Components.DigitalController.SimpleTank tank2 annotation (
    Placement(visible = true, transformation(origin = {-24, -64}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  STTlibrary.Components.DigitalController.DigitalPI digitalPI(PVmax = 100, Ti = 20, Ts = 2, kp = -4)  annotation (
    Placement(visible = true, transformation(origin = {-22, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PI(T = 20, initType = Modelica.Blocks.Types.Init.InitialOutput, k = -4)  annotation (
    Placement(visible = true, transformation(origin = {-22, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.DigitalController.Norm norm(umax = 100, umin = 0)  annotation (
    Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation (
    Placement(visible = true, transformation(origin = {-86, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant SP(k = 5)  annotation (
    Placement(visible = true, transformation(origin = {-170, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step wi(height = 1000, startTime = 10)  annotation (
    Placement(visible = true, transformation(origin = {-170, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(tank2.wi, wi.y) annotation (
    Line(points = {{-42, -50}, {-130, -50}, {-130, 30}, {-159, 30}}, color = {0, 0, 127}));
  connect(wi.y, tank1.wi) annotation (
    Line(points = {{-159, 30}, {-130, 30}, {-130, 38}, {-42, 38}}, color = {0, 0, 127}));
  connect(feedback.u1, SP.y) annotation (
    Line(points = {{-94, -30}, {-120, -30}, {-120, 66}, {-158, 66}, {-158, 66}}, color = {0, 0, 127}));
  connect(digitalPI.SP, SP.y) annotation (
    Line(points = {{-32, 66}, {-160, 66}, {-160, 66}, {-158, 66}}, color = {0, 0, 127}));
  connect(tank2.level, feedback.u2) annotation (
    Line(points = {{-42, -62}, {-86, -62}, {-86, -38}, {-86, -38}}, color = {0, 0, 127}));
  connect(feedback.y, norm.u) annotation (
    Line(points = {{-76, -30}, {-62, -30}, {-62, -30}, {-62, -30}}, color = {0, 0, 127}));
  connect(tank1.level, digitalPI.PV) annotation (
    Line(points = {{-42, 26}, {-60, 26}, {-60, 54}, {-32, 54}, {-32, 54}, {-32, 54}}, color = {0, 0, 127}));
  connect(norm.y, PI.u) annotation (
    Line(points = {{-39, -30}, {-34, -30}}, color = {0, 0, 127}));
  connect(PI.y, tank2.theta) annotation (
    Line(points = {{-10, -30}, {-4, -30}, {-4, -78}, {-4, -78}}, color = {0, 0, 127}));
  connect(digitalPI.CO, tank1.theta) annotation (
    Line(points = {{-12, 66}, {-4, 66}, {-4, 10}, {-4, 10}}, color = {0, 0, 127}));

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  experiment(StartTime = 0, StopTime = 300, Tolerance = 1e-6, Interval = 0.15));
end ControlledTank;