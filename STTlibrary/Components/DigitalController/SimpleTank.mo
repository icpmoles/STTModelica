within STTlibrary.Components.DigitalController;
model SimpleTank
  parameter SI.Area A = 1 "tank section";
  parameter SI.Density d = 1000 "water density";
  parameter SI.Length h_start = 5 "start water level inside tank";
  parameter Real Av = 10 "valve Av";

  //variables
  SI.Length h "water level inside tank";
  SI.Mass M(start = d*A*h_start, fixed = true) "water mass inside tank";
  SI.MassFlowRate wo "output flowrate";

  //interface
  Modelica.Blocks.Interfaces.RealInput wi annotation (
    Placement(visible = true, transformation(origin = {-110, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-108, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput level annotation (
    Placement(visible = true, transformation(origin = {-110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput theta annotation (
    Placement(visible = true, transformation(origin = {120, -56}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, -84}, extent = {{-8, -8}, {8, 8}}, rotation = -90)));

equation
  der(M) = wi - wo;
  wo = theta*Av*sqrt(9.81*d*h);
  M = d*A*h;
  level = h;

  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(fillColor = {0, 170, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-100, 100}, {100, -100}}), Polygon(origin = {120, -91}, fillColor = {0, 170, 255}, fillPattern = FillPattern.HorizontalCylinder, points = {{-20, 9}, {20, -9}, {20, 9}, {-20, -9}, {-20, 9}}), Text(origin = {0, -119}, extent = {{-100, 9}, {100, -9}}, textString = "%name")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end SimpleTank;