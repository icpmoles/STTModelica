within STTlibrary.Components.StreamConnectors;
model PressureBC
  parameter SI.Pressure p0 = 1.01325e5 "prescribed pressure";
  parameter SI.SpecificEnthalpy hnom = 1e5 "nominal enthalpy";
  STTlibrary.Interfaces.HYDF flange annotation (
    Placement(visible = true, transformation(origin = {100, -2}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  flange.p = p0;
  flange.h_outflow = hnom;
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Ellipse(origin = {0, 1}, lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Sphere, extent = {{-100, 99}, {100, -99}}), Text(origin = {0, -115}, extent = {{-100, 11}, {100, -11}}, textString = "%name")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end PressureBC;