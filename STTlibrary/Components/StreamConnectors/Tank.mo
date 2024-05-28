within STTlibrary.Components.StreamConnectors;
model Tank
  package Medium = StandardWater "medium model";
  Medium.ThermodynamicState liquidState(p(start=pstart),
                                        h(start=hstart)) "td state of medium";

  parameter SI.Area A "tank bottom section";
  parameter SI.Pressure pstart "pressure initial value";
  parameter SI.SpecificEnthalpy hstart "enthalpy initial value";
  constant SI.Acceleration g = 9.81 "gravity constant";
  constant SI.Pressure patm = 1.01325e5 "atmospheric pressure";

  SI.Volume V "tank volume";
  SI.Mass M "liquid mass";
  SI.Energy E "liquid total energy";
  SI.SpecificEnthalpy h, ha, hb "liquid specific enthalpy";
  SI.Pressure p "bottom pressure";
  SI.Density d "liquid density";
  STTlibrary.Interfaces.HYDF fl_a annotation (
    Placement(visible = true, transformation(origin = {-100, -90}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {-100, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Interfaces.HYDF fl_b annotation (
    Placement(visible = true, transformation(origin = {100, -92}, extent = {{-20, -10}, {20, 10}}, rotation = 0), iconTransformation(origin = {100, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput M_meas annotation (
    Placement(visible = true, transformation(origin = {106, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  // set liquid state
  liquidState = Medium.setState_ph(p, h);
  d = Medium.density(liquidState);

  // mass and energy balances
  M = V*d;
  E = M*Medium.specificInternalEnergy(liquidState);
  der(M) = fl_a.w + fl_b.w;
  der(E) = fl_a.w*ha + fl_b.w*hb;
  p = patm + M*g/A;

  //BC
  fl_a.p = p;
  fl_a.h_outflow = h;
  ha = actualStream(fl_a.h_outflow);

  fl_b.p = p;
  fl_b.h_outflow = h;
  hb = actualStream(fl_b.h_outflow);

  //measure
  M_meas = M;

initial equation
  pstart = patm + M*g/A;
  E = hstart*M;

annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(lineColor = {0, 170, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -115}, extent = {{-100, 9}, {100, -9}}, textString = "%name")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end Tank;