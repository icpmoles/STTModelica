within STTlibrary.Components.StreamConnectors.Examples;
model Mixer
  extends MixerBase(p_H(hnom = 2e5));
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.RealExpression thetaM(y = 0.5)  annotation (
    Placement(visible = true, transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback split annotation (
    Placement(visible = true, transformation(origin = {-130, 32}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression thetaC(y = 1)  annotation (
    Placement(visible = true, transformation(origin = {-170, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp rampH(duration = 5, startTime = 10)  annotation (
    Placement(visible = true, transformation(origin = {-170, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(rampH.y, vlv_H.theta) annotation (
    Line(points={{-159,60},{-106,60},{-106,-38},{-106,-38}},          color = {0, 0, 127}));
  connect(thetaM.y, vlv_M.theta) annotation (
    Line(points={{-19,-50},{-16,-50},{-16,-78}},        color = {0, 0, 127}));
  connect(split.y, vlv_C.theta) annotation (
    Line(points={{-121,32},{-121,-66},{-106,-66},{-106,-78}},          color = {0, 0, 127}));
  connect(rampH.y, split.u2) annotation (
    Line(points={{-159,60},{-130,60},{-130,40},{-130,40}},          color = {0, 0, 127}));
  connect(thetaC.y, split.u1) annotation (
    Line(points={{-159,32},{-138,32},{-138,32},{-138,32}},          color = {0, 0, 127}));

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
  experiment(StartTime = 0, StopTime = 40, Tolerance = 1e-6, Interval = 0.08));
end Mixer;
