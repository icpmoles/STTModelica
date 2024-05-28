within STTlibrary.Components.ReplaceableComponents;

model Actuators
  extends STTlibrary.Components.ReplaceableComponents.Interfaces.ActuatorsInt;
  Modelica.Blocks.Continuous.FirstOrder vlvH(T = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder vlvC(T = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {42, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression thetaC(y = 1)  annotation(
    Placement(visible = true, transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback split annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder vlvM(T = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(vlvH.y, vlvH_cmd) annotation(
    Line(points = {{52, 60}, {100, 60}}, color = {0, 0, 127}));
  connect(thetaC.y, split.u1) annotation(
    Line(points = {{-18, 0}, {-8, 0}}, color = {0, 0, 127}));
  connect(split.y, vlvC.u) annotation(
    Line(points = {{10, 0}, {30, 0}}, color = {0, 0, 127}));
  connect(vlvC.y, vlvC_cmd) annotation(
    Line(points = {{54, 0}, {102, 0}}, color = {0, 0, 127}));
  connect(vlvM.y, vlvM_cmd) annotation(
    Line(points = {{52, -60}, {102, -60}}, color = {0, 0, 127}));
  connect(levelCO, vlvM.u) annotation(
    Line(points = {{-120, -60}, {28, -60}}, color = {0, 0, 127}));
  connect(hCO, vlvH.u) annotation(
    Line(points = {{-120, 60}, {28, 60}}, color = {0, 0, 127}));
  connect(hCO, split.u2) annotation(
    Line(points = {{-120, 60}, {0, 60}, {0, 8}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})));
end Actuators;