within STTlibrary.Components.Motor;
model Vreference
  // Voltage references
  parameter SI.RotationalDampingConstant Dm "rotor damping constant";
  parameter SI.ElectricalTorqueConstant Kt "Shape function constant";
  parameter SI.Resistance R "phase resistance";
  parameter SI.Inductance L "phase inductance";
  parameter Integer p "stator electrical poles";
  final parameter Real K = 2*Kt/(3*p) "[V*s]";

  SI.Torque taum;
  SI.Current I;
  SI.AngularVelocity w;

  Modelica.Blocks.Interfaces.RealOutput OA annotation (
    Placement(visible = true, transformation(origin = {103.358, 63.0657}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {103.358, 63.0657}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput OB annotation (
    Placement(visible = true, transformation(origin = {103.066, -0.073}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {103.066, -0.073}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput OC annotation (
    Placement(visible = true, transformation(origin = {105.693, -55.8686}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {105.693, -59.8686}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput wref annotation (
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

equation
    w = wref;
    taum = Dm*w;
    I = taum/Kt;
    OA = (R*I + w*p*K)*sin(p*w*time) + L*I*p*w*cos(p*w*time);
    OB = (R*I + w*p*K)*sin(p*w*time - 2*pi/3) + L*I*p*w*cos(p*w*time - 2*pi/3);
    OC = (R*I + w*p*K)*sin(p*w*time - 4*pi/3) + L*I*p*w*cos(p*w*time - 4*pi/3);

  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, -2}, extent = {{-69, 50}, {69, -50}}, textString = "Vref"), Text(origin = {-1, -119}, lineColor = {0, 0, 255}, extent = {{-79, 11}, {79, -11}}, textString = "%name")}));
end Vreference;
