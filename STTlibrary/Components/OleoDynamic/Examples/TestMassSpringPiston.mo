within STTlibrary.Components.OleoDynamic.Examples;
model TestMassSpringPiston
  extends Modelica.Icons.Example;
  STTlibrary.Components.OleoDynamic.MassSpringPiston massSpringPiston(D = 300, FrictionNull = false, c_spring = 1e4, dch = 0.1, dpnom = 10000, dsh = 0.02, fc = 100, fs = 110, m = 2, oilCompressibility = true, p_start = 1e5, pnom = 1e+06, ps = 0.2, s_oilFl = 0, springPreload = 200000, wnom = 1)  annotation (
    Placement(visible = true, transformation(origin = {4, 1.11022e-15}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  STTlibrary.Components.OleoDynamic.ImposedPressure Psource(use_in_p0 = true)  annotation (
    Placement(visible = true, transformation(origin = {-40, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Trapezoid Psp(amplitude = 1e6, falling = 5, nperiod = 1, offset = 1e5, period = 20, rising = 5, startTime = 2, width = 5)  annotation (
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass load(m = 20)  annotation (
    Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Psp.y, Psource.in_p0) annotation (
    Line(points = {{-58, -10}, {-44, -10}, {-44, -30}, {-44, -30}}, color = {0, 0, 127}));
  connect(Psource.fl_P, massSpringPiston.fl_P) annotation (
    Line(points = {{-30, -40}, {-22, -40}, {-22, -14}, {-22, -14}}, color = {255, 170, 0}));
  connect(massSpringPiston.fl_Mb, load.flange_a) annotation (
    Line(points = {{-4, 0}, {42, 0}, {42, 0}, {40, 0}, {40, 0}}, color = {0, 127, 0}));
annotation (
    experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-6, Interval = 0.02));
end TestMassSpringPiston;
