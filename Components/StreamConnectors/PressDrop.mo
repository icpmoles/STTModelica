within STTlibrary.Components.StreamConnectors;
model PressDrop
  package Medium = StandardWater;
  Medium.ThermodynamicState liquidState;
  parameter Real R(unit = "1/m4") "hydraulic resistance";
  parameter SI.MassFlowRate wnom "nominal flowrate";

  function regsquare "regularized square"
    input Real u;
    input Real wnom;
    output Real y;

  algorithm
    y := u*sqrt(u*u+wnom*0.01*(wnom*0.01));
  end regsquare;

  STTlibrary.Interfaces.HYDF fl_a annotation (
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Interfaces.HYDF fl_b annotation (
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  liquidState = Medium.setState_ph(fl_a.p, actualStream(fl_a.h_outflow));
  fl_a.w + fl_b.w = 0;
  Medium.density(liquidState)*(fl_a.p-fl_b.p) = R*smooth(1, regsquare(fl_a.w, wnom));

  fl_a.h_outflow = inStream(fl_b.h_outflow);
  fl_b.h_outflow = inStream(fl_a.h_outflow);

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 40}, {100, -40}}), Text(origin = {0, -54}, extent = {{-100, 8}, {100, -8}}, textString = "%name")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end PressDrop;