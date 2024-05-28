within STTlibrary.Components.Mechanics;
model SpringStop_sMin
  extends BaseClasses.SpringStopBase;
  parameter Boolean useSupport=false "support flange enabled, otherwise implicitly grounded" annotation (
    choices(checkBox=true));

  // variables
  SI.Length s "position";

  // interfaces
  Modelica.Mechanics.Translational.Interfaces.Flange_a fl_a annotation (
  Placement(visible = true, transformation(origin = {6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-76, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b fl_b annotation (
  Placement(visible = true, transformation(origin = {14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-46, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Interfaces.Support support(s=s_support, f=-f_stop) if useSupport "Support/housing of component" annotation (
  Placement(visible = true, transformation(origin = {0, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-18, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

protected
  SI.Length s_support "support position";

equation
  fl_a.f + fl_b.f + f_stop = 0;
  s_rel = s_support - s;

  // BC
  s = fl_a.s;
  fl_a.s = fl_b.s;

  // Conditional connector
  if not useSupport then
    s_support = 0;
  end if;

  annotation (
Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(graphics = {Polygon(origin = {4, 42}, lineColor = {128, 128, 128}, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid, points = {{50, -90}, {20, -80}, {20, -100}, {50,-90}}), Line(origin = {4, 42}, points = {{-60, -90}, {20, -90}}), Rectangle(origin = {-61, 41}, extent = {{-5, 41}, {5, -41}}), Rectangle(origin = {-70, -9}, extent = {{-4, 25}, {4, -25}}), Line(origin = {-47.8153, -15.659}, points = {{-18.1847, -8.34098}, {-12.1847, 9.659}, {-2.18474, -14.341}, {5.81526, 9.65902}, {11.8153, -10.341}}), Text(origin = {-3, -76}, extent = {{-49, 10}, {49, -10}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
end SpringStop_sMin;
