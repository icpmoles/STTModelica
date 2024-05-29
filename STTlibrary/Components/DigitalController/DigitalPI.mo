within STTlibrary.Components.DigitalController;
block DigitalPI
  parameter Boolean useTrack = false "use connector inputs for track" annotation (
    Dialog(group = "External Inputs"),
    choices(checkBox = true));
  parameter SI.PerUnit kp "proportional gain";
  parameter SI.Time Ti "integral time";
  parameter SI.Time Ts "sampling time";
  parameter Real PVmax = 1 "maximum PV value";
  parameter Real PVmin = 0 "minimum PV value";
  parameter Real COmax = 1 "maximum CO value";
  parameter Real COmin = 0 "minimum CO value";
  parameter Real I_start = 0 "integrator initial status in the same spine of CO" annotation (
      Dialog(tab = "initialization"));
  parameter Boolean TS_start = false "Track command initial status" annotation (
      Dialog(tab = "initialization"));
  final parameter Real spanPV = PVmax - PVmin "span of PV";
  final parameter Real spanCO = COmax - COmin "span of CO";

  //variables
  Real SPn, PVn "normalized variables";
  Real TVn "normalized Track value";
  Real errn "normalized error";

  //discrete variables
  discrete Real errnd(start = 0, fixed = true) "normalized sampled error";
  discrete Real Pnd(start = 0, fixed = true) "normalized proportional control";
  discrete Real Ind(start = (I_start - COmin)/spanCO, fixed = true) "normalized Integral control";
  discrete Real CObsnd(start = 0, fixed = true) "normalized CO before saturation";
  discrete Real COasnd(start = 0, fixed = true) "normalized saturated CO";

  //interface
  Modelica.Blocks.Interfaces.RealInput SP annotation (
    Placement(visible = true, transformation(origin = {-98, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput PV annotation (
    Placement(visible = true, transformation(origin = {-102, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput CO annotation (
    Placement(visible = true, transformation(origin = {104, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput TV if useTrack annotation (
    Placement(visible = true, transformation(origin = {2, 68}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-20, 98}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanInput TS if useTrack annotation (
    Placement(visible = true, transformation(origin = {-40, 66}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-50, 98}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

protected
  Modelica.Blocks.Interfaces.RealInput TV_internal;
  Modelica.Blocks.Interfaces.BooleanInput TS_internal(start = TS_start, fixed = true);

algorithm
  when sample(0, Ts) then
    // A/D conversion
    errnd := errn;

    if pre(TS_internal) then
      //Track is active
      CObsnd := TVn;
      Pnd := kp*errnd;
      Ind := TVn;

    else
      //PI
      Pnd := kp*errnd;
      Ind := pre(Ind) + kp*errnd*Ts/Ti;
      CObsnd := Pnd + Ind;
    end if;

    //output saturation with andi-windup
    COasnd := min(1, max(0, CObsnd));
    if COasnd < CObsnd or COasnd > CObsnd then
      Ind := pre(Ind);
    end if;
  end when;

equation
  errn = SPn - PVn;
  CO = COasnd*spanCO + COmin;

  //normalization
  SPn = (SP - PVmin)/spanPV;
  PVn = (PV - PVmin)/spanPV;
  TVn = (TV_internal - COmin)/spanCO;
  
  //conditional connectors
  connect(TV, TV_internal);
  connect(TS, TS_internal);
  if not useTrack then
    TS_internal = false;
    TV_internal = 0;
  end if;

initial equation
  assert(PVmax > PVmin, "PVmax must be greater than PVmin");
  assert(COmax > COmin, "COmax must be greater than COmin");

  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = { 2, -2}, extent = {{-62, 26}, {62, -26}}, textString = "Digital PI"), Text(origin = {0, -117}, extent = {{-100, 9}, {100, -9}}, textString = "%name")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end DigitalPI;