within STTlibrary.Components.ReplaceableComponents;

model DigitalControl
  extends STTlibrary.Components.ReplaceableComponents.Interfaces.ControlInt;
  STTlibrary.Components.DigitalController.DigitalPI levelPI(PVmax = 10, Ti = 2, Ts = 0.3, kp = -4)  annotation(
    Placement(visible = true, transformation(origin = {0, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  STTlibrary.Components.DigitalController.DigitalPI hPI(PVmax = 2e5, Ti = 2, Ts = 0.3, kp = 1)  annotation(
    Placement(visible = true, transformation(origin = {0, -52}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(levelSP, levelPI.SP) annotation(
    Line(points = {{-170, 60}, {-20, 60}}, color = {0, 0, 127}));
  connect(levelMeas, levelPI.PV) annotation(
    Line(points = {{-170, 20}, {-100, 20}, {-100, 36}, {-20, 36}}, color = {0, 0, 127}));
  connect(levelPI.CO, levelCO) annotation(
    Line(points = {{20, 60}, {166, 60}}, color = {0, 0, 127}));
  connect(hSP, hPI.SP) annotation(
    Line(points = {{-170, -40}, {-20, -40}}, color = {0, 0, 127}));
  connect(hMeas, hPI.PV) annotation(
    Line(points = {{-170, -80}, {-100, -80}, {-100, -64}, {-20, -64}}, color = {0, 0, 127}));
  connect(hPI.CO, hCO) annotation(
    Line(points = {{20, -40}, {166, -40}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    Icon(graphics = {Text(origin = {1, -64}, extent = {{-69, 14}, {69, -14}}, textString = "Digital")}));
end DigitalControl;