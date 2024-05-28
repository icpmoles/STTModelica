within STTlibrary.Components.Mechanics;
model FrictionForceLinear
  parameter Boolean FrictionNull = false "= true, if friction force is forced to 0";
  parameter SI.Force fs = 3 "maximum friction force in presliding";
  parameter SI.Force fc = 2 "friction force at motion inversion";
  parameter SI.TranslationalDampingConstant D = 0 "linear coefficient of friction";
  parameter SI.Velocity vtrsh = 1e-6 "treshold for zero-speed evaluation";

  // variables
  SI.Length s "position";
  SI.Velocity v "velocity";
  SI.Force friction_f "friction force";

  // interfaces
  Modelica.Mechanics.Translational.Interfaces.Flange_a fl_a annotation (
  Placement(visible = true, transformation(origin = {6, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b fl_b annotation (
  Placement(visible = true, transformation(origin = {14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  v = der(s);
  // BC
  fl_a.s = fl_b.s;
  s = fl_a.s;
  fl_a.f + fl_b.f - friction_f = 0;

  if FrictionNull then
    friction_f = 0;
  elseif fc>0 and fs>fc and vtrsh>0 then
    friction_f = if abs(v)<vtrsh then v*fs/vtrsh else sign(v)*(fc + D*(abs(v) - vtrsh));
  elseif fc>0 and vtrsh>0 then
    friction_f = smooth(0, if abs(v)<vtrsh then v*fc/vtrsh else sign(v)*(fc + D*(abs(v) - vtrsh)));
  else
    friction_f = D*v;
  end if;

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}), graphics = {Rectangle(origin = {0, 30}, lineColor = {255, 255, 255}, fillPattern = FillPattern.CrossDiag, extent = {{-60, 10}, {60, -10}}), Rectangle(origin = {0, -30}, lineColor = {255, 255, 255}, fillPattern = FillPattern.CrossDiag, extent = {{-60, 10}, {60, -10}}), Text(origin = {-2, -62}, extent = {{-36, 12}, {36, -12}}, textString = "%name")}));
end FrictionForceLinear;
