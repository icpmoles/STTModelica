within STTlibrary.Components.DrillingMachine;
model ActuatedDrillingMachine
  STTlibrary.Components.DrillingMachine.DrillingMachine drillingMachine annotation (
    Placement(visible = true, transformation(origin = {-3.55271e-15, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  STTlibrary.Components.Motor.ControlledMotor motor annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  STTlibrary.Components.OleoDynamic.MassSpringPiston oilPiston(D = 120, FrictionNull = false, c = 5e6, c_spring = 7e2, d = 5e6, dch = 0.025, dpnom = 10000, dsh = 0.01, fc = 0, fs = 0, m = 2, oilCompressibility = true, p_start = 200000, pnom = 10e5, ps = 0.5, s_oilFl = 0, springPreload = 0, wnom = 0.01) annotation (
    Placement(visible = true, transformation(origin = {-8, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput wref annotation (
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 82}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  STTlibrary.Interfaces.ODF_P oilFl annotation (
    Placement(visible = true, transformation(origin = {-40, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(motor.flange_b, drillingMachine.motorFlange) annotation (
    Line(points = {{0, -11}, {0, -22}}));
  connect(oilPiston.fl_Mb, drillingMachine.headFlange) annotation (
    Line(points = {{-8, 33}, {-8, -22}}, color = {0, 127, 0}));
  connect(oilPiston.fl_P, oilFl) annotation (
    Line(points = {{-12, 40}, {-40, 40}, {-40, 40}, {-40, 40}}, color = {255, 170, 0}));
  connect(wref, motor.wref) annotation (
    Line(points = {{0, 100}, {0, 10}}, color = {0, 0, 127}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {0, 11}, fillColor = {238, 238, 236}, fillPattern = FillPattern.Solid, extent = {{-50, 69}, {50, -61}}), Rectangle(origin = {0, -57}, fillColor = {186, 189, 182}, fillPattern = FillPattern.Solid, extent = {{-70, 7}, {70, -7}}), Rectangle(origin = {0, 50}, fillColor = {238, 238, 236}, fillPattern = FillPattern.VerticalCylinder, extent = {{-20, 30}, {20, -30}}), Rectangle(origin = {0, 18}, fillPattern = FillPattern.Solid, extent = {{-6, 2}, {6, -2}}), Rectangle(origin = {0, 4}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-2, 12}, {2, -12}}), Text(origin = {0, -80}, lineColor = {0, 0, 255}, extent = {{-100, 12}, {100, -12}}, textString = "%name")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})));
end ActuatedDrillingMachine;
