within STTlibrary.Components.ReplaceableComponents;

partial model SystemArchitecture
  replaceable STTlibrary.Components.ReplaceableComponents.Interfaces.PlantInt plant annotation(
    Placement(visible = true, transformation(origin = {-1.77636e-15, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  replaceable STTlibrary.Components.ReplaceableComponents.Interfaces.SensorsInt sensors annotation(
    Placement(visible = true, transformation(origin = {80, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  replaceable STTlibrary.Components.ReplaceableComponents.Interfaces.ActuatorsInt actuators annotation(
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  replaceable STTlibrary.Components.ReplaceableComponents.Interfaces.ControlInt control annotation(
    Placement(visible = true, transformation(origin = {-1.77636e-15, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp levelSP annotation(
    Placement(visible = true, transformation(origin = {-150, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp hSP annotation(
    Placement(visible = true, transformation(origin = {-150, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(hSP.y, control.hSP) annotation(
    Line(points = {{-138, 30}, {-8, 30}, {-8, 20}}, color = {0, 0, 127}));
  connect(levelSP.y, control.levelSP) annotation(
    Line(points = {{-138, 70}, {12, 70}, {12, 20}}, color = {0, 0, 127}));
  connect(control.hCO, actuators.hCO) annotation(
    Line(points = {{-20, 0}, {-150, 0}, {-150, -76}, {-120, -76}}, color = {0, 0, 127}));
  connect(control.levelCO, actuators.levelCO) annotation(
    Line(points = {{-20, -16}, {-132, -16}, {-132, -60}, {-120, -60}}, color = {0, 0, 127}));
  connect(actuators.vlvH_cmd, plant.vlvH_cmd) annotation(
    Line(points = {{-80, -48}, {-20, -48}}, color = {0, 0, 127}));
  connect(actuators.vlvC_cmd, plant.vlvC_cmd) annotation(
    Line(points = {{-80, -60}, {-20, -60}}, color = {0, 0, 127}));
  connect(actuators.vlvM_cmd, plant.vlvM_cmd) annotation(
    Line(points = {{-80, -72}, {-20, -72}}, color = {0, 0, 127}));
  connect(plant.Mout, sensors.Min) annotation(
    Line(points = {{20, -60}, {60, -60}}, color = {0, 0, 127}));
  connect(plant.tankFlb, sensors.tankFlb) annotation(
    Line(points = {{20, -74}, {60, -74}}));
  connect(sensors.levelMeas, control.levelMeas) annotation(
    Line(points = {{100, -60}, {112, -60}, {112, -12}, {20, -12}}, color = {0, 0, 127}));
  connect(sensors.hMeas, control.hMeas) annotation(
    Line(points = {{100, -76}, {128, -76}, {128, 0}, {20, 0}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {14, -1}, lineColor = {136, 138, 133}, fillColor = {136, 138, 133}, fillPattern = FillPattern.Solid, points = {{-50, 61}, {-50, -59}, {50, 1}, {-50, 61}})}));
end SystemArchitecture;