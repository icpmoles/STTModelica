within STTlibrary.Components.DigitalController.Examples;
model ControlledTankTrk
  extends Modelica.Icons.Example;
  extends ControlledTank(digitalPI.useTrack = true);
  
  Modelica.Blocks.Sources.BooleanStep TS(startTime = 20, startValue = true)  annotation (
    Placement(visible = true, transformation(origin = {-47, 77}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant TV(k = 0)  annotation (
    Placement(visible = true, transformation(origin = {-24, 92}, extent = {{-8, -8}, {8, 8}}, rotation = -90)));
equation
  connect(TS.y, digitalPI.TS) annotation(
    Line(points = {{-40, 78}, {-26, 78}, {-26, 70}}, color = {255, 0, 255}));
  connect(TV.y, digitalPI.TV) annotation(
    Line(points = {{-24, 84}, {-24, 70}}, color = {0, 0, 127}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  experiment(StartTime = 0, StopTime = 300, Tolerance = 1e-6, Interval = 0.15));
end ControlledTankTrk;