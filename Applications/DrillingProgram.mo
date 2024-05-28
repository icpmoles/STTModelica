within STTlibrary.Applications;
model DrillingProgram
  Modelica.Blocks.Interfaces.RealOutput wref annotation (
    Placement(visible = true, transformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput oilPref annotation (
    Placement(visible = true, transformation(origin = {100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Trapezoid wReference(amplitude = -12, falling = 0.2, period = 12, rising = 0.2, width = 8) annotation (
    Placement(visible = true, transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Trapezoid oilPreference(amplitude = 8e5, falling = 3, period = 12, rising = 3, startTime = 1, width = 2) annotation (
    Placement(visible = true, transformation(origin = {2, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(wReference.y, wref) annotation (
    Line(points = {{12, 20}, {100, 20}}, color = {0, 0, 127}));
  connect(oilPreference.y, oilPref) annotation (
    Line(points = {{14, -40}, {100, -40}}, color = {0, 0, 127}));
  annotation (
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(extent = {{-80, 80}, {80, -80}}, textString = "Drilling
prg")}));
end DrillingProgram;
