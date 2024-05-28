within STTlibrary.Components.DrillingMachine;
model DrillingMachine
  inner Modelica.Mechanics.MultiBody.World world(animateGravity = false, animateWorld = false, gravityType = Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity)  annotation (
    Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox basePlate(height = 1.2,length = 0.06, lengthDirection = {0, 0, 1}, r = {0.6, 0.85, 0.06}, r_shape = {0.6, 0.5, 0}, width = 1)  annotation (
    Placement(visible = true, transformation(origin = { -70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox headGuide(height = 0.6,length = 1.5, lengthDirection = {0, 0, 1}, r = {0, -0.15, 1.5}, width = 0.3) annotation (
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic zAxis(n = {0, 0, -1}, useAxisFlange = true)  annotation (
    Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute(cylinderDiameter = 0.03, cylinderLength = 0.02,n = {0, 0, 1}, useAxisFlange = true) annotation (
    Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder spindle(diameter = 0.04, innerDiameter = 0, length = 0.2, lengthDirection = {0,  0, -1}, r = {0,  0, -0.2}) annotation (
    Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder head(diameter = 0.6, innerDiameter = 0, length = 0.4, lengthDirection = {0, 0, -1}, r = {0,  -0.3, -0.4}, r_shape = {0, -0.3, 0}) annotation (
    Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a motorFlange annotation (
    Placement(visible = true, transformation(origin = {50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_a headFlange annotation (
    Placement(visible = true, transformation(origin = {-2, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-40, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Damper spindleBearing(d = 0.1)  annotation (
    Placement(visible = true, transformation(origin = {44, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Components.Damper guideFriction(d = 100)  annotation (
    Placement(visible = true, transformation(origin = {-14, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox drill(length = 0.1, lengthDirection = {0, 0, -1}, r = {0, 0, 0}, width = 0.016)  annotation (
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(basePlate.frame_b, headGuide.frame_a) annotation (
    Line(points = {{-60, 0}, {-50, 0}}, color = {95, 95, 95}));
  connect(headGuide.frame_b, zAxis.frame_a) annotation (
    Line(points = {{-30, 0}, {-20, 0}}, color = {95, 95, 95}));
  connect(revolute.frame_b, spindle.frame_a) annotation (
    Line(points = {{60, 0}, {70, 0}}, color = {95, 95, 95}));
  connect(zAxis.frame_b, head.frame_a) annotation (
    Line(points = {{0, 0}, {10, 0}, {10, 0}, {10, 0}}, color = {95, 95, 95}));
  connect(head.frame_b, revolute.frame_a) annotation (
    Line(points = {{30, 0}, {40, 0}, {40, 0}, {40, 0}}));
  connect(revolute.axis, motorFlange) annotation (
    Line(points = {{50, 10}, {50, 60}}));
  connect(headFlange, zAxis.axis) annotation (
    Line(points = {{-2, 60}, {-2, 6}}, color = {0, 127, 0}));
  connect(revolute.support, spindleBearing.flange_a) annotation (
    Line(points = {{44, 10}, {44, 10}, {44, 14}, {44, 14}}));
  connect(spindleBearing.flange_b, revolute.axis) annotation (
    Line(points = {{44, 34}, {46, 34}, {46, 34}, {50, 34}, {50, 10}, {50, 10}}));
  connect(guideFriction.flange_a, zAxis.support) annotation (
    Line(points = {{-14, 14}, {-14, 14}, {-14, 6}, {-14, 6}}, color = {0, 127, 0}));
  connect(guideFriction.flange_b, zAxis.axis) annotation (
    Line(points = {{-14, 34}, {-2, 34}, {-2, 6}, {-2, 6}, {-2, 6}}, color = {0, 127, 0}));
  connect(world.frame_b, basePlate.frame_a) annotation (
    Line(points = {{-100, 0}, {-80, 0}, {-80, 0}, {-80, 0}}, color = {95, 95, 95}));
  connect(spindle.frame_b, drill.frame_a) annotation (
    Line(points = {{90, 0}, {100, 0}, {100, 0}, {100, 0}}, color = {95, 95, 95}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1}, initialScale = 0.1), graphics = {Rectangle(origin = {0, 11}, fillColor = {238, 238, 236}, fillPattern = FillPattern.Solid, extent = {{-50, 69}, {50, -61}}), Rectangle(origin = {0, -57}, fillColor = {186, 189, 182}, fillPattern = FillPattern.Solid, extent = {{-70, 7}, {70, -7}}), Rectangle(origin = {0, 50}, fillColor = {238, 238, 236}, fillPattern = FillPattern.VerticalCylinder, extent = {{-20, 30}, {20, -30}}), Rectangle(origin = {0, 18}, fillPattern = FillPattern.Solid, extent = {{-6, 2}, {6, -2}}), Rectangle(origin = {0, 4}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-2, 12}, {2, -12}}), Text(origin = {0, -80}, lineColor = {0, 0, 255}, extent = {{-100, 12}, {100, -12}}, textString = "%name")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})));
end DrillingMachine;
