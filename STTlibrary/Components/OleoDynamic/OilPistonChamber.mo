within STTlibrary.Components.OleoDynamic;
model OilPistonChamber
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
  parameter SI.Pressure p_start "pressure start value";
  final parameter SI.Area Su = 0.25*3.1415*(dch^2 - dsh^2) "piston used surface";
  final parameter SI.Volume Vutot = Su*ps "chamber total volume";
  final parameter SI.Volume Vext = Vutot*dvr "extra volume to ensure that Vo > 0 if compressibility is used";
  final parameter Real Avc = wnom/(rhoOil_start*dpnom) "efflux coefficient";

  // Variables
  SI.Density rhoOil(start = rhoOil_start) "oil density";
  SI.Mass Mo "oil mass";
  SI.Volume Vo(nominal = Vutot) "oil volume";
  SI.Length s "piston absolute position";
  SI.Length s_rel "piston relative-to-oil_flange position";
  SI.Force f "piston force";
  SI.Pressure po(start = p_start, stateSelect = StateSelect.prefer) "chamber oil pressure";
  SI.Pressure dp "pressure across flange P";
  SI.MassFlowRate wf "oil mass flowrate through the flange";

  // Interfaces
  Interfaces.ODF_P fl_P annotation (
  Placement(visible = true, transformation(origin = {-134, -40}, extent = {{-15, -10}, {15, 10}}, rotation = 0), iconTransformation(origin = {-64, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b fl_Mb annotation (
  Placement(visible = true, transformation(origin = {150, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_a fl_Ma annotation (
    Placement(visible = true, transformation(origin = {-155, -1}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  // mechanical equations
  s_rel = s - s_oilFl;
  Vo = Vext + s_rel*Su;
  Mo = rhoOil*Vo;
  f = po*Su;
  fl_Ma.f + f + fl_Mb.f = 0;

  // hydraulic equations
  der(Mo) = wf;
  if oilCompressibility then
    rhoOil - rhoOil_start = rhoOil_start*(po - p_start)/Koil;
  else
    rhoOil = rhoOil_start;
  end if;

  wf = Avc*rhoOil*dp;

  // Boundary conditions
  dp = fl_P.p - po;
  fl_Ma.s = s;
  fl_Mb.s = fl_Ma.s;
  fl_P.w = wf;

  assert(Vo > 0, "Oil volume must be positive; increase dead volume ratio parameter dvr");

initial equation
  if oilCompressibility then
    der(po) = 0;
  end if;

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {1, 0}, extent = {{-81, 40}, {81, -40}}), Rectangle(origin = {-49, 32}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, extent = {{29, -72}, {-31, 8}}), Rectangle(origin = {-20, 0}, fillPattern = FillPattern.Solid, extent = {{-2, 40}, {2, -40}}), Text(origin = {2, -79}, extent = {{-32, 11}, {32, -11}}, textString = "%name")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end OilPistonChamber;
