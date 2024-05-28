within STTlibrary.Components.StreamConnectors;
model LinValve
  parameter Real Av(unit = "m.s") "valve Av coefficient";
  STTlibrary.Interfaces.HYDF fl_a annotation (
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Interfaces.HYDF fl_b annotation (
    Placement(visible = true, transformation(origin = {100, -2}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput theta annotation (
    Placement(visible = true, transformation(origin = {4, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 20}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
equation
  // mass balance
  fl_a.w + fl_b.w = 0;

  // flow char
  fl_a.w = theta*Av*(fl_a.p - fl_b.p);

  // energy balance
  fl_a.h_outflow = inStream(fl_b.h_outflow);
  fl_b.h_outflow = inStream(fl_a.h_outflow);

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Polygon(lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, points = {{-100, 40}, {100, -40}, {100, 40}, {-100, -40}, {-100, 40}}), Text(origin = {0, -54}, extent = {{-98, 8}, {98, -8}}, textString = "%name")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end LinValve;