within STTlibrary.Components.DrillingMachine.Examples;
model TestDrillingMachine
  extends Modelica.Icons.Example;
  STTlibrary.Components.DrillingMachine.DrillingMachine DrillingMachine(spindleBearing(phi_rel(start=0, fixed=true)), guideFriction(v_rel(start=0, fixed=true))) annotation (
    Placement(visible = true, transformation(origin = {-3.55271e-15, -10}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed speedSP(w_fixed = 12)  annotation (
    Placement(visible = true, transformation(origin = {-50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sources.Position positionSP annotation (
    Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression positionVal(y = if time > 1 then (time - 1) / 8 else 0)  annotation (
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(speedSP.flange, DrillingMachine.motorFlange) annotation (
    Line(points = {{-40, 60}, {0, 60}, {0, 18}, {0, 18}}));
  connect(positionSP.flange, DrillingMachine.headFlange) annotation (
    Line(points = {{-40, 30}, {-12, 30}, {-12, 18}, {-12, 18}}, color = {0, 127, 0}));
  connect(positionVal.y, positionSP.s_ref) annotation (
    Line(points = {{-78, 30}, {-62, 30}, {-62, 30}, {-62, 30}}, color = {0, 0, 127}));

annotation (
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-6, Interval = 0.002));
end TestDrillingMachine;
