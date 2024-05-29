within STTlibrary.Components.Motor.Examples;
model TestMotor
  extends Modelica.Icons.Example;
  STTlibrary.Components.Motor.ControlledMotor motor annotation (
    Placement(visible = true, transformation(origin = {-3.55271e-15, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression speedSP(y = 4)  annotation (
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(speedSP.y, motor.wref) annotation (
    Line(points = {{-38, 0}, {-20, 0}, {-20, 0}, {-20, 0}}, color = {0, 0, 127}));

annotation (
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
end TestMotor;
