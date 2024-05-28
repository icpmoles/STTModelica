within STTlibrary.Components.ReplaceableComponents;

model AnalogControl
  extends STTlibrary.Components.ReplaceableComponents.Interfaces.ControlInt;
  STTlibrary.Components.DigitalController.Norm normLevel(umax = 10, umin = 0)  annotation(
    Placement(visible = true, transformation(origin = {-50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.DigitalController.Norm normEnthalpy(umax = 2e5, umin = 0)  annotation(
    Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedbackLevel annotation(
    Placement(visible = true, transformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedbackEnthalpy annotation(
    Placement(visible = true, transformation(origin = {-110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI piLevel(T = 2, k = -4)  annotation(
    Placement(visible = true, transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI piEnthalpy(T = 2, k = 1)  annotation(
    Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiterLevel(uMax = 1, uMin = 0)  annotation(
    Placement(visible = true, transformation(origin = {50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiterEnthalpy(uMax = 1, uMin = 0)  annotation(
    Placement(visible = true, transformation(origin = {50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(levelSP, feedbackLevel.u1) annotation(
    Line(points = {{-170, 60}, {-118, 60}}, color = {0, 0, 127}));
  connect(levelMeas, feedbackLevel.u2) annotation(
    Line(points = {{-170, 20}, {-110, 20}, {-110, 52}}, color = {0, 0, 127}));
  connect(feedbackLevel.y, normLevel.u) annotation(
    Line(points = {{-100, 60}, {-62, 60}}, color = {0, 0, 127}));
  connect(normLevel.y, piLevel.u) annotation(
    Line(points = {{-38, 60}, {-12, 60}}, color = {0, 0, 127}));
  connect(piLevel.y, limiterLevel.u) annotation(
    Line(points = {{12, 60}, {38, 60}}, color = {0, 0, 127}));
  connect(limiterLevel.y, levelCO) annotation(
    Line(points = {{62, 60}, {166, 60}}, color = {0, 0, 127}));
  connect(hSP, feedbackEnthalpy.u1) annotation(
    Line(points = {{-170, -40}, {-118, -40}}, color = {0, 0, 127}));
  connect(hMeas, feedbackEnthalpy.u2) annotation(
    Line(points = {{-170, -80}, {-110, -80}, {-110, -48}}, color = {0, 0, 127}));
  connect(feedbackEnthalpy.y, normEnthalpy.u) annotation(
    Line(points = {{-100, -40}, {-62, -40}}, color = {0, 0, 127}));
  connect(normEnthalpy.y, piEnthalpy.u) annotation(
    Line(points = {{-38, -40}, {-12, -40}}, color = {0, 0, 127}));
  connect(piEnthalpy.y, limiterEnthalpy.u) annotation(
    Line(points = {{12, -40}, {38, -40}}, color = {0, 0, 127}));
  connect(limiterEnthalpy.y, hCO) annotation(
    Line(points = {{62, -40}, {166, -40}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    Icon(graphics = {Text(origin = {0, -63}, extent = {{-60, 13}, {60, -13}}, textString = "Analog")}));
end AnalogControl;