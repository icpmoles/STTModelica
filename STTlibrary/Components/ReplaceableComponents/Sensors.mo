within STTlibrary.Components.ReplaceableComponents;

model Sensors
  extends STTlibrary.Components.ReplaceableComponents.Interfaces.SensorsInt;
  STTlibrary.Components.StreamConnectors.h_sensor h_sensor annotation(
    Placement(visible = true, transformation(origin = {-30, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder level_sensor_dyn(T = 0.03)  annotation(
    Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder h_sensor_dyn(T = 2)  annotation(
    Placement(visible = true, transformation(origin = {30, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain MtoLevel(k = 1e-3 / (0.3 * 0.3))  annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(tankFlb, h_sensor.flange) annotation(
    Line(points = {{-90, -80}, {-40, -80}}));
  connect(level_sensor_dyn.y, levelMeas) annotation(
    Line(points = {{41, 0}, {106, 0}}, color = {0, 0, 127}));
  connect(h_sensor.h_meas, h_sensor_dyn.u) annotation(
    Line(points = {{-19, -80}, {18, -80}}, color = {0, 0, 127}));
  connect(h_sensor_dyn.y, hMeas) annotation(
    Line(points = {{41, -80}, {106, -80}}, color = {0, 0, 127}));
  connect(Min, MtoLevel.u) annotation(
    Line(points = {{-100, 0}, {-42, 0}}, color = {0, 0, 127}));
  connect(MtoLevel.y, level_sensor_dyn.u) annotation(
    Line(points = {{-18, 0}, {18, 0}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})));
end Sensors;