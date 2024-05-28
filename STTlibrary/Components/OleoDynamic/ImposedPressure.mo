within STTlibrary.Components.OleoDynamic;
model ImposedPressure
  parameter SI.Pressure p0 = 1e5 "imposed pressure if not use_in_p0";
  parameter Boolean use_in_p0 = false "use connector input for the pressure";

  STTlibrary.Interfaces.ODF_P fl_P annotation (
  Placement(visible = true, transformation(origin = {88, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput in_p0 if use_in_p0 annotation (
  Placement(transformation(origin = {-40, 92}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));

protected
  Modelica.Blocks.Interfaces.RealInput in_p0_internal;

equation
  fl_P.p = in_p0_internal;

  // Conditional connectors
  connect(in_p0, in_p0_internal);
  if not use_in_p0 then
    in_p0_internal = p0 "Pressure set by parameter";
  end if;

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}), graphics = {Ellipse(fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}}, endAngle = 360), Text(origin = {0, -101}, extent = {{-42, 15}, {42, -15}}, textString = "%name")}));
end ImposedPressure;
