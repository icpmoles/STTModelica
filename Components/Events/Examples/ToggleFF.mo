within STTlibrary.Components.Events.Examples;
model ToggleFF
  extends Modelica.Icons.Example;
  STTlibrary.Components.Events.SRFF srff1 annotation (
    Placement(visible = true, transformation(origin = {-10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.MathBoolean.OnDelay onDelay1(delayTime = 1)  annotation (
    Placement(visible = true, transformation(origin = {34, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.MathBoolean.OnDelay onDelay2(delayTime = 1)  annotation (
    Placement(visible = true, transformation(origin = {34, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(onDelay1.y, srff1.R) annotation (
    Line(points = {{46, 8}, {72, 8}, {72, -54}, {-40, -54}, {-40, -16}, {-20, -16}}, color = {255, 0, 255}));
  connect(onDelay2.y, srff1.S) annotation (
    Line(points = {{46, -26}, {60, -26}, {60, 40}, {-40, 40}, {-40, -4}, {-20, -4}}, color = {255, 0, 255}));
  connect(srff1.Q2, onDelay2.u) annotation (
    Line(points = {{0, -16}, {8, -16}, {8, -26}, {20, -26}, {20, -26}}, color = {255, 0, 255}));
  connect(srff1.Q1, onDelay1.u) annotation (
    Line(points = {{0, -4}, {8, -4}, {8, 8}, {20, 8}, {20, 8}}, color = {255, 0, 255}));

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02));
end ToggleFF;
