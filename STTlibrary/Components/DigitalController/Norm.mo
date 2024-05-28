within STTlibrary.Components.DigitalController;
block Norm
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Real umax "max value of u";
  parameter Real umin "min value of u";
  final parameter Real span = umax - umin "span of u";

equation
  y = (u - umin)/span;

initial equation
  assert(umax > umin, "umax must be greater than umin");

  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Text(origin = {-4, 1}, extent = {{-68, 37}, {68, -37}}, textString = "Norm")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end Norm;
