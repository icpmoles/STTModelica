within STTlibrary.Components.ReplaceableComponents;

model Plant
  extends STTlibrary.Components.ReplaceableComponents.Interfaces.PlantInt;
  extends STTlibrary.Components.StreamConnectors.Examples.MixerBase(p_H.hnom = 2e5);
equation
  connect(vlvM_cmd, vlv_M.theta) annotation(
    Line(points = {{-180, 70}, {-16, 70}, {-16, -78}}, color = {0, 0, 127}));
  connect(vlvH_cmd, vlv_H.theta) annotation(
    Line(points = {{-180, 40}, {-106, 40}, {-106, -38}}, color = {0, 0, 127}));
  connect(vlvC_cmd, vlv_C.theta) annotation(
    Line(points = {{-180, 10}, {-120, 10}, {-120, -58}, {-106, -58}, {-106, -78}}, color = {0, 0, 127}));
  connect(tank.fl_b, tankFlb) annotation(
    Line(points = {{-44, -80}, {-32, -80}, {-32, -60}, {100, -60}}));
  connect(tank.M_meas, Mout) annotation(
    Line(points = {{-44, -60}, {-40, -60}, {-40, 0}, {106, 0}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})));
end Plant;