within STTlibrary.Components.Mechanics;
model SpringStop_sMin_sMax
  parameter Boolean useSupport = false "= true, if support flange enabled, otherwise implicitly grounded";
  parameter SI.Length L = 1 "side-to-side length (sMin to sMax)";
  parameter SI.TranslationalSpringConstant c = 1e6 "Stop Spring constant - sMin side";
  parameter SI.TranslationalDampingConstant d = 1e6 "Stop Spring damper constant - sMin side";

  // Interfaces
  Modelica.Mechanics.Translational.Interfaces.Flange_a fl_a(s(start=L/2)) annotation (
    Placement(visible = true, transformation(origin = {-60, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-14, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b fl_b annotation (
    Placement(visible = true, transformation(origin = {58, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {16, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Interfaces.Support support_sMin if useSupport "Support/housing of component - sMin side" annotation (
    Placement(visible = true, transformation(origin = {-24, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-56, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  // submodels
  Modelica.Mechanics.Translational.Components.Fixed fixed_0(s0 = 0) if not useSupport annotation (
    Placement(visible = true, transformation(origin = {-6, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.Mechanics.SpringStop_sMin springStop_sMin(c = c, d = d, final useSupport = true) annotation (
    Placement(visible = true, transformation(origin = {-19, -3}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  STTlibrary.Components.Mechanics.SpringStop_sMax springStop_sMax(c = c, d = d, final useSupport = true) annotation (
    Placement(visible = true, transformation(origin = {30, -2}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Rod rod(L = L) annotation (
    Placement(visible = true, transformation(origin = {2, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  connect(springStop_sMin.fl_b, springStop_sMax.fl_a) annotation (
    Line(points = {{-30, 16}, {32, 16}, {32, 14}, {32, 14}}, color = {0, 127, 0}));
  connect(rod.flange_b, springStop_sMax.support) annotation (
    Line(points = {{12, -6}, {26, -6}}, color = {0, 127, 0}));
  connect(springStop_sMax.fl_b, fl_b) annotation (
    Line(points = {{40.08, 14.8}, {56.16, 14.8}, {56.16, 14.6}, {58.16, 14.6}}, color = {0, 127, 0}));
  connect(rod.flange_a, springStop_sMin.support) annotation (
    Line(points = {{-8, -6}, {-30, -6}, {-30, -7.5}, {-23.5, -7.5}}, color = {0, 127, 0}));
  connect(springStop_sMin.support, support_sMin) annotation (
    Line(points = {{-24, -8}, {-24, -8}, {-24, -42}, {-24, -42}}, color = {0, 127, 0}));
  connect(fixed_0.flange, springStop_sMin.support) annotation (
    Line(points = {{-6, -38}, {-6, -38}, {-6, -30}, {-24, -30}, {-24, -8}, {-24, -8}}, color = {0, 127, 0}));
  connect(springStop_sMin.fl_a, fl_a) annotation (
    Line(points = {{-38, 16}, {-60, 16}, {-60, 16}, {-60, 16}}, color = {0, 127, 0}));
  annotation (
    Icon(graphics = {Text(origin = {-3, -76}, extent = {{-49, 10}, {49, -10}}, textString = "%name"), Polygon(origin = {16, 42}, lineColor = {128, 128, 128}, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid, points = {{50, -90}, {20, -80}, {20, -100}, {50, -90}}), Line(origin = {16, 42}, points = {{-60, -90}, {20, -90}}), Rectangle(origin = {-2, 22}, extent = {{-72, 24}, {72, -24}}), Rectangle(origin = {2, 40}, extent = {{-6, 40}, {4, -40}}), Rectangle(origin = {-57, 22}, extent = {{-3, 24}, {3, -24}}), Rectangle(origin = {52, 21}, extent = {{-2, 25}, {4, -23}}), Line(origin = {-67.1033, 22.3028}, points = {{-6.89669, -6.30278}, {-2.89669, 7.69722}, {1.10331, -10.3028}, {5.10331, 1.69722}}), Line(origin = {63.7791, 22.5969}, points = {{-6.89669, -6.30278}, {-2.89669, 7.69722}, {1.10331, -10.3028}, {5.10331, 1.69722}})}, coordinateSystem(initialScale = 0.1)));
end SpringStop_sMin_sMax;
