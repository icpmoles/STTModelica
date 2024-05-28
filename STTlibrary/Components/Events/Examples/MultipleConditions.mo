within STTlibrary.Components.Events.Examples;
model MultipleConditions
  extends Modelica.Icons.Example;
  Integer out1, out2;

algorithm
  when time > 1 or time > 2 then
    out1 := out1 + 1;
  end when;

  when {time > 1, time > 2} then
    out2 := out2 + 1;
  end when;

 annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.006));
end MultipleConditions;
