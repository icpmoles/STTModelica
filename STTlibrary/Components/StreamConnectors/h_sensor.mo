within STTlibrary.Components.StreamConnectors;
model h_sensor
  STTlibrary.Interfaces.HYDF flange annotation (
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput h_meas annotation (
    Placement(visible = true, transformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  h_meas = inStream(flange.h_outflow);
  flange.w = 0;
  flange.h_outflow = 1e5 "never used";
annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}), graphics = {Ellipse(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, 1}, extent = {{-42, 37}, {42, -37}}, textString = "h"), Text(origin = {0, -115}, extent = {{-100, 9}, {100, -9}}, textString = "%name")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end h_sensor;