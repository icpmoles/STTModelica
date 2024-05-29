within STTlibrary.Components;

package Elevator
  extends Modelica.Icons.Package;

  package Simulation
  extends Modelica.Icons.ExamplesPackage;
  end Simulation;

  model ShaftNoCompensation
  Modelica.Mechanics.Translational.Components.Mass Cabin annotation(
      Placement(transformation(origin = {48, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Components.Mass CounterWeight annotation(
      Placement(transformation(origin = {-50, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Translational.Components.SupportFriction frictionCW annotation(
      Placement(transformation(origin = {-50, -32}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Translational.Components.SupportFriction frictionCabin annotation(
      Placement(transformation(origin = {48, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Sources.ConstantForce gravityCW annotation(
      Placement(transformation(origin = {-50, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Sources.ConstantForce gravityCabin annotation(
      Placement(transformation(origin = {48, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b pulleyShaft annotation(
      Placement(transformation(origin = {-100, 70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-8, 62}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput cabinPosition annotation(
      Placement(transformation(origin = {104, 46}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -70}, extent = {{-18, -18}, {18, 18}})));
  pulleyAndRope machineRoom annotation(
      Placement(transformation(origin = {-4, 64}, extent = {{-24, -24}, {24, 24}})));
  Modelica.Blocks.Discrete.ZeroOrderHold positonSensor annotation(
      Placement(transformation(origin = {68, 48}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Rotational.Components.Brake brake annotation(
      Placement(transformation(origin = {-66, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput brakeSignal annotation(
      Placement(transformation(origin = {-90, 104}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {46, 94}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  equation
  connect(frictionCW.flange_a, machineRoom.flange_b) annotation(
      Line(points = {{-50, -22}, {-22, -22}, {-22, 42}}, color = {0, 127, 0}));
  connect(frictionCW.flange_b, CounterWeight.flange_a) annotation(
      Line(points = {{-50, -42}, {-50, -50}}, color = {0, 127, 0}));
  connect(gravityCW.flange, CounterWeight.flange_b) annotation(
      Line(points = {{-50, -76}, {-50, -70}}, color = {0, 127, 0}));
  connect(Cabin.flange_a, gravityCabin.flange) annotation(
      Line(points = {{48, -60}, {48, -68}}, color = {0, 127, 0}));
  connect(Cabin.flange_b, frictionCabin.flange_a) annotation(
      Line(points = {{48, -40}, {48, -34}}, color = {0, 127, 0}));
  connect(machineRoom.flange_a, frictionCabin.flange_b) annotation(
      Line(points = {{14, 42}, {48, 42}, {48, -14}}, color = {0, 127, 0}));
  connect(machineRoom.endRopePosition, positonSensor.u) annotation(
      Line(points = {{16, 48}, {56, 48}}, color = {0, 0, 127}));
  connect(positonSensor.y, cabinPosition) annotation(
      Line(points = {{80, 48}, {89, 48}, {89, 46}, {104, 46}}, color = {0, 0, 127}));
  connect(pulleyShaft, brake.flange_a) annotation(
      Line(points = {{-100, 70}, {-76, 70}}));
  connect(brake.flange_b, machineRoom.pulleyShaft) annotation(
      Line(points = {{-56, 70}, {-4, 70}}));
  connect(brake.f_normalized, brakeSignal) annotation(
      Line(points = {{-66, 82}, {-90, 82}, {-90, 104}}, color = {0, 0, 127}));
  annotation(
      Icon(graphics = {Rectangle(origin = {-34, -64}, extent = {{-4, 24}, {4, -24}}), Rectangle(origin = {11, -65}, extent = {{-17, 25}, {17, -25}}), Ellipse(origin = {-9, 63}, extent = {{-23, 23}, {23, -23}}), Line(origin = {-35.9286, -1.28571}, points = {{0, -40}, {4, 64}}), Line(origin = {13.5714, 0.714286}, points = {{-1, 58}, {-1, -44}}), Rectangle(origin = {11, -65}, extent = {{-15, 23}, {15, -23}})}));
end ShaftNoCompensation;

  model pulleyAndRope
  Modelica.Mechanics.Rotational.Interfaces.Flange_b pulleyShaft annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 22}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(
      Placement(transformation(origin = {72, -90}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, -92}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b annotation(
      Placement(transformation(origin = {-74, -90}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-74, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput endRopePosition annotation(
      Placement(transformation(origin = {108, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {86, -70}, extent = {{-10, -10}, {10, 10}})));
  parameter SI.Length pulleyRadius;
  parameter SI.MomentOfInertia pulleyInertia;
  parameter SI.LinearDensity ropeDensity;
  parameter SI.LinearStrain ropeStrain;
  parameter SI.Length travelDifferential;
  parameter SI.Length travelSlack;
  
  
  SI.Angle theta(start =0 ,stateSelect=StateSelect.prefer);
  equation

  annotation(
      Diagram,
  Icon(graphics = {Ellipse(origin = {-2, 25}, extent = {{-74, 73}, {74, -73}}), Ellipse(origin = {-1, 25}, extent = {{-71, 71}, {71, -71}}), Rectangle(origin = {-74, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{-2, -19}, {2, 19}}), Rectangle(origin = {70, 3}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{2, -21}, {-2, 21}}), Rectangle(origin = {70, -61}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{-2, -19}, {2, 19}}), Rectangle(origin = {-72, -63}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{-2, -19}, {2, 19}}), Line(origin = {-72.9358, -47.7356}, points = {{-17.9929, -3.69289}, {-13.9929, 4.30711}, {-7.99289, -3.69289}, {0.00710678, 4.30711}, {8.00711, -3.69289}, {14.0071, 4.30711}, {22.0071, -1.69289}}), Line(origin = {70.2785, -44.8785}, points = {{-17.9929, -3.69289}, {-13.9929, 4.30711}, {-7.99289, -3.69289}, {0.00710678, 4.30711}, {8.00711, -3.69289}, {14.0071, 4.30711}, {22.0071, -1.69289}}), Line(origin = {-74.0072, -24.5213}, points = {{-17.9929, -3.69289}, {-13.9929, 4.30711}, {-7.99289, -3.69289}, {0.00710678, 4.30711}, {8.00711, -3.69289}, {14.0071, 4.30711}, {22.0071, -1.69289}}), Line(origin = {70.6356, -21.6642}, points = {{-17.9929, -3.69289}, {-13.9929, 4.30711}, {-7.99289, -3.69289}, {0.00710678, 4.30711}, {8.00711, -3.69289}, {14.0071, 4.30711}, {22.0071, -1.69289}})}));
end pulleyAndRope;
end Elevator;
