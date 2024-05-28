within STTlibrary.Components.ReplaceableComponents.Interfaces;

partial model PlantInt
  Modelica.Blocks.Interfaces.RealInput vlvH_cmd annotation(
    Placement(visible = true, transformation(origin = {-180, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vlvC_cmd annotation(
    Placement(visible = true, transformation(origin = {-180, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vlvM_cmd annotation(
    Placement(visible = true, transformation(origin = {-180, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Mout annotation(
    Placement(visible = true, transformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Interfaces.HYDF tankFlb annotation(
    Placement(visible = true, transformation(origin = {100, -60}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {100, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Rectangle(origin = {0, -40}, fillColor = {114, 159, 207}, fillPattern = FillPattern.VerticalCylinder, extent = {{-40, 40}, {40, -40}}), Polygon(origin = {0, 50}, fillColor = {114, 159, 207}, fillPattern = FillPattern.HorizontalCylinder, points = {{-60, 30}, {-60, -30}, {60, 30}, {60, -30}, {-60, 30}}), Text(origin = {0, -120}, extent = {{-100, 20}, {100, -20}}, textString = "%name")}));
end PlantInt;