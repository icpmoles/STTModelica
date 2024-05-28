within STTlibrary.Components.ReplaceableComponents.Interfaces;

partial model SensorsInt
  Modelica.Blocks.Interfaces.RealInput Min annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  STTlibrary.Interfaces.HYDF tankFlb annotation(
    Placement(visible = true, transformation(origin = {-90, -80}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {-100, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput levelMeas annotation(
    Placement(visible = true, transformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput hMeas annotation(
    Placement(visible = true, transformation(origin = {106, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Rectangle(extent = {{-80, 80}, {80, -80}}, radius = 20), Rectangle(origin = {0, 10}, fillColor = {114, 159, 207}, fillPattern = FillPattern.Solid, extent = {{-60, 30}, {60, -30}}), Text(origin = {0, -120}, extent = {{-100, 20}, {100, -20}}, textString = "%name")}));
end SensorsInt;