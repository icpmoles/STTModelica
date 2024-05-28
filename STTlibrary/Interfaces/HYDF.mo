within STTlibrary.Interfaces;
connector HYDF "connector for water/steam flow"
  SI.Pressure p "pressure";
  flow SI.MassFlowRate w "mass flowrate";
  stream SI.SpecificEnthalpy h_outflow "specific h when w<0";
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {1, 0}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-101, 100}, {99, -100}})}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end HYDF;
