within STTlibrary.Components.Mechanics;
model SpringStop_sMax
  extends BaseClasses.SpringStopBase;
  parameter Boolean useSupport=false "support flange enabled, otherwise implicitly grounded" annotation (
    choices(checkBox=true));

  // variables
  SI.Length s "position";

  // interfaces
  Modelica.Mechanics.Translational.Interfaces.Flange_a fl_a annotation (
  Placement(visible = true, transformation(origin = {6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {12, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b fl_b annotation (
  Placement(visible = true, transformation(origin = {14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {42, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Interfaces.Support support(s=s_support, f=-f_stop) if useSupport "Support/housing of component" annotation (
  Placement(visible = true, transformation(origin = {0, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-16, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

protected
  SI.Length s_support "support position";

equation
  fl_a.f + fl_b.f - f_stop = 0;
  s_rel = s - s_support;

  // BC
  s = fl_a.s;
  fl_a.s = fl_b.s;

  // Conditional connector
  if not useSupport then
    s_support = 0;
  end if;

  annotation (
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(graphics = {Polygon(origin = {4, 42}, lineColor = {128, 128, 128}, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid, points = {{50, -90}, {20, -80}, {20, -100}, {50, -90}}), Line(origin = {4, 42}, points = {{-60, -90}, {20, -90}}), Rectangle(origin = {27, 40}, extent = {{-5, 40}, {5, -40}}), Rectangle(origin = {35, 3}, extent = {{-3, 37}, {3, -37}}), Line(origin = {15.8824, -17.8382}, points = {{-17.8824, -2.16176}, {-9.88235, 13.8382}, {-1.88235, -12.1618}, {6.11765, 13.8382}, {14.1176, -4.16176}}), Text(origin = {-3, -75}, extent = {{-43, 11}, {43, -11}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
end SpringStop_sMax;
