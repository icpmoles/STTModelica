within STTlibrary.Components.OleoDynamic;
model MassSpringPiston
  parameter Boolean oilCompressibility = true "= true, if oil compressibility is used";
  parameter SI.Length dch "chamber diameter";
  parameter SI.Length dsh "shaft diameter";
  parameter SI.PerUnit dvr = 1e-2 "dead volume ratio";
  parameter SI.Length ps "piston stroke";
  parameter SI.Length s_oilFl "s_position of oil flange";
  parameter SI.Temperature Toil = 313.15 "Oil Temperature";
  parameter SI.BulkModulus Koil = 2.7e9 "bulk modulus";
  parameter SI.MassFlowRate wnom "nominal flowrate";
  parameter SI.Pressure dpnom "nominal delta pressure across flange";
  parameter SI.Density rhoOil_start = 1063 "start oil density";
  parameter SI.Pressure p_start "start oil pressure";
  parameter Boolean FrictionNull = true "= true, if friction force is forced to 0";
  parameter SI.Force fs = 0 "maximum friction force in presliding";
  parameter SI.Force fc = 0 "friction force at motion inversion";
  parameter SI.TranslationalDampingConstant D = 0 "linear coefficient of friction";
  parameter SI.Velocity vtrsh = 1e-6 "treshold for zero-speed evaluation";
  parameter SI.Mass m "piston mass";
  parameter SI.TranslationalSpringConstant c_spring(final min = 0) "spring constant";
  parameter SI.Pressure springPreload "spring preload pressure";
  parameter SI.Pressure pnom "nominal pressure";
  parameter SI.Length s_start = s_oilFl "initial piston position";
  parameter SI.TranslationalSpringConstant c = fnomMax*1000/ps "Stop spring constant";
  parameter SI.TranslationalDampingConstant d = c/100 "Stop damper constant";
  final parameter SI.Force fnomMax = S*max(pnom, springPreload) "maximum hydraulic nominal force";
  final parameter SI.Area S = 0.25*3.1415*(dch^2 - dsh^2) "piston surface";
  final parameter SI.Length s_rel0 = ps + springPreload*S/c_spring "Unstretched spring length";

  // interfaces
  STTlibrary.Interfaces.ODF_P fl_P annotation (
    Placement(visible = true, transformation(origin = {-122, -40}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {-80, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_a fl_Ma annotation (
    Placement(visible = true, transformation(origin = {-160, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b fl_Mb annotation (
    Placement(visible = true, transformation(origin = {160, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  STTlibrary.Components.OleoDynamic.OilPistonChamber oilPistonChamber(Koil = Koil, Toil = Toil,dch = dch, dpnom = dpnom, dsh = dsh, dvr = dvr, oilCompressibility = oilCompressibility, ps = ps, rhoOil_start = rhoOil_start, p_start = p_start, s_oilFl = s_oilFl, wnom = wnom) annotation (
    Placement(visible = true, transformation(origin = {-108, -2.22045e-16}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass pistonMass(m = m, s(fixed = true, start = s_start), v(fixed = true)) annotation (
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.Mechanics.FrictionForceLinear sealingFriction(D = D, FrictionNull = FrictionNull, fc = fc, fs = fs, vtrsh = vtrsh) annotation (
    Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  STTlibrary.Components.Mechanics.SpringStop_sMin_sMax springStop_sMin_sMax(L = ps, c = c, d = d, fl_a(s(start = s_start)), useSupport = true) annotation (
    Placement(visible = true, transformation(origin = {33, -15}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Spring spring_T(c = c_spring, s_rel(start = s_oilFl + ps - s_start), s_rel0 = s_rel0) annotation (
    Placement(visible = true, transformation(origin = {110, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Fixed sMin_support(s0 = s_oilFl) annotation (
    Placement(visible = true, transformation(origin = {20, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Fixed spring_support(s0 = s_oilFl + ps) annotation (
    Placement(visible = true, transformation(origin = {140, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));

equation
  connect(fl_Ma, oilPistonChamber.fl_Ma) annotation (
    Line(points = {{-160, 0}, {-116, 0}, {-116, 0}, {-114, 0}}, color = {0, 127, 0}));
  connect(oilPistonChamber.fl_Mb, pistonMass.flange_a) annotation (
    Line(points = {{-110, 0}, {-70, 0}, {-70, 0}, {-70, 0}}, color = {0, 127, 0}));
  connect(pistonMass.flange_b, sealingFriction.fl_a) annotation (
    Line(points = {{-50, 0}, {-22, 0}, {-22, 0}, {-22, 0}}, color = {0, 127, 0}));
  connect(sealingFriction.fl_b, springStop_sMin_sMax.fl_a) annotation (
    Line(points = {{-18, 0}, {30, 0}, {30, 0}, {30, 0}}, color = {0, 127, 0}));
  connect(springStop_sMin_sMax.fl_b, fl_Mb) annotation (
    Line(points = {{36, 0}, {158, 0}, {158, 0}, {160, 0}}, color = {0, 127, 0}));
  connect(fl_P, oilPistonChamber.fl_P) annotation (
    Line(points = {{-122, -40}, {-122, -40}, {-122, -12}, {-122, -12}}, color = {252, 175, 62}));
  connect(sMin_support.flange, springStop_sMin_sMax.support_sMin) annotation (
    Line(points = {{20, -40}, {20, -40}, {20, -18}, {22, -18}}, color = {0, 127, 0}));
  connect(spring_T.flange_b, spring_support.flange) annotation (
    Line(points = {{120, -20}, {140, -20}, {140, -20}, {140, -20}}, color = {0, 127, 0}));
  connect(spring_T.flange_a, springStop_sMin_sMax.fl_b) annotation (
    Line(points = {{100, -20}, {80, -20}, {80, 0}, {36, 0}, {36, 0}}, color = {0, 127, 0}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {0, -5}, extent = {{-100, 45}, {100, -35}}), Rectangle(origin = {-40, 0}, fillPattern = FillPattern.Solid, extent = {{-4, 40}, {4, -40}}), Rectangle(origin = {-72, 0}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-28, 40}, {28, -40}}), Line(origin = {31.5532, -0.447214}, points = {{-71.5532, -39.5528}, {-31.5532, 40.4472}, {8.44681, -39.5528}, {46.4468, 40.4472}, {66.4468, 0.447214}}), Text(origin = {0, -66}, extent = {{-30, 12}, {30, -12}}, textString = "%name")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end MassSpringPiston;
