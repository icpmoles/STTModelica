within STTlibrary.Components.Events;
block SRFF
  //variables
  Boolean stateOn(fixed = true, start = false) "SRFF status ON";

  // interface
  Modelica.Blocks.Interfaces.BooleanInput S(start = false, fixed = true) annotation (
    Placement(visible = true, transformation(origin = {-98, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput R(start = false, fixed = true) annotation (
    Placement(visible = true, transformation(origin = {-102, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput Q1 annotation (
    Placement(visible = true, transformation(origin = {102, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput Q2 annotation (
    Placement(visible = true, transformation(origin = {102, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

algorithm
    //state machine
    when not stateOn and pre(S) and not pre(R) then
      stateOn := true;

    elsewhen stateOn and pre(R) then
      stateOn := false;

    end when;

    // output calculation
    Q1 := stateOn;
    Q2 := not Q1;

  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {1, 0}, extent = {{-101, 100}, {99, -100}}), Text(origin = {4, 0},extent = {{-70, 38}, {70, -38}}, textString = "SRFF"), Text(origin = {4, -121}, extent = {{-36, 11}, {36, -11}}, textString = "%name")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end SRFF;
