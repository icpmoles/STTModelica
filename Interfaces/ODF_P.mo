within STTlibrary.Interfaces;
connector ODF_P
  SI.Pressure p "pressure";
  flow SI.MassFlowRate w "mass flowrate";
  annotation (
  Icon(coordinateSystem(grid = {1, 1}, initialScale = 0.1), graphics = {Ellipse(lineColor = {255, 170, 0}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}, endAngle = 360)}));
end ODF_P;
