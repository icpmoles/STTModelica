within STTlibrary.Components.Events.Examples;
model EventIteration2
/*---------------------------------------------
  two events in different iteration
---------------------------------------------*/

  extends Modelica.Icons.Example;
  Integer a(start=0, fixed=true);

algorithm
  when a > 0 then
    a := a +1;
  end when;

  when time > 1 then
    a := a +1;
  end when;

annotation (
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-6, Interval = 0.004));
end EventIteration2;
