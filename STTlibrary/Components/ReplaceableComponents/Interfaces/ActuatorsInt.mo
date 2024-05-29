within STTlibrary.Components.ReplaceableComponents.Interfaces;

partial model ActuatorsInt
  Modelica.Blocks.Interfaces.RealInput levelCO annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput hCO annotation(
    Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vlvH_cmd annotation(
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vlvC_cmd annotation(
    Placement(visible = true, transformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vlvM_cmd annotation(
    Placement(visible = true, transformation(origin = {102, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -121}, extent = {{-100, 19}, {100, -19}}, textString = "%name"), Rectangle(origin = {0, 30}, fillColor = {52, 101, 164}, fillPattern = FillPattern.Sphere, extent = {{-60, 30}, {60, -30}}), Rectangle(origin = {0, -20}, fillColor = {211, 215, 207}, fillPattern = FillPattern.VerticalCylinder, extent = {{-6, 20}, {6, -20}})}));
end ActuatorsInt;