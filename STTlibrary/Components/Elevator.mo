within STTlibrary.Components;

package Elevator
  extends Modelica.Icons.Package;
  import Modelica.Constants.g_n;

  package Simulation
    extends Modelica.Icons.ExamplesPackage;

    model Simple
      elevatorHoistway shaftNoCompensation(CabinMass = 1000, hSlack = 1, deltaH = 20, CounterWeightMass = 1200, hStart = 3) annotation(
        Placement(transformation(origin = {44, -16}, extent = {{-46, -46}, {46, 46}})));
      Motor.ControlledMotor controlledMotor(p = 8, Kt = 100) annotation(
        Placement(transformation(origin = {-60, 12}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.RealExpression speedSetPoint(y = 0.8) annotation(
        Placement(transformation(origin = {-122, 12}, extent = {{-10, -10}, {10, 10}})));
    equation
      connect(controlledMotor.wref, speedSetPoint.y) annotation(
        Line(points = {{-70, 12}, {-110, 12}}, color = {0, 0, 127}));
      connect(controlledMotor.flange_b, shaftNoCompensation.pulleyShaft) annotation(
        Line(points = {{-48, 12}, {40, 12}}));
      annotation(
        Diagram);
    end Simple;

    model Feedback
      parameter SI.Length startinPos = 2;
      parameter SI.Length finalPos = 19;
      parameter SI.Velocity nomVel = 1 "nominal speed of the elevator";
      // (finalPos - startinPos)/nomVel "supposing instaneous acceleration how much time it will need to reach the target";
      elevatorHoistway elevator(CabinMass = 1800, hSlack = 1, deltaH = 20, CounterWeightMass = 1800, hStart = startinPos) annotation(
        Placement(transformation(origin = {44, -16}, extent = {{-46, -46}, {46, 46}})));
      Motor.ControlledMotor controlledMotor(p = 8, Kt = 200, R = 0.001) annotation(
        Placement(transformation(origin = {-58, -22}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.Rotational.Components.Brake brake(fn_max = 200)  annotation(
        Placement(transformation(origin = {-12, 12}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y = 1)  annotation(
        Placement(transformation(origin = {-50, 44}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Ramp ramp1(height = 40000, duration = 1, startTime = 1) annotation(
        Placement(transformation(origin = {-62, 82}, extent = {{-10, -10}, {10, 10}})));
  softStart softStarter annotation(
        Placement(transformation(origin = {-143, 5}, extent = {{-23, -23}, {23, 23}})));
    equation
      connect(brake.flange_b, elevator.pulleyShaft) annotation(
        Line(points = {{-2, 12}, {40, 12}}));
  connect(controlledMotor.flange_b, brake.flange_a) annotation(
        Line(points = {{-47, -22}, {-22, -22}, {-22, 12}}));
  connect(softStarter.motorControl, controlledMotor.wref) annotation(
        Line(points = {{-118, -8}, {-68, -8}, {-68, -22}}, color = {0, 0, 127}));
  connect(brake.f_normalized, softStarter.brakingOutput) annotation(
        Line(points = {{-12, 24}, {-120, 24}, {-120, 18}}, color = {0, 0, 127}));
  connect(softStarter.positionReading, elevator.cabinPosition) annotation(
        Line(points = {{-164, 6}, {-244, 6}, {-244, -90}, {106, -90}, {106, -50}, {66, -50}}, color = {0, 0, 127}));
      annotation(
        Diagram);
    end Feedback;
  end Simulation;

  model elevatorHoistway
    parameter SI.Mass CabinMass = 120;
    parameter SI.Mass CounterWeightMass = 100;
    parameter SI.Time SamplingTime = 1/100;
    parameter SI.Length pulleyRadius = 3;
    parameter SI.Length hSlack = 1;
    parameter SI.Length deltaH = 20;
    parameter SI.Height hStart(max = deltaH, min = 0) = 0;
    Modelica.Mechanics.Translational.Components.Mass Cabin(m = CabinMass) annotation(
      Placement(transformation(origin = {48, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Mechanics.Translational.Components.Mass CounterWeight(m = CounterWeightMass) annotation(
      Placement(transformation(origin = {-50, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Mechanics.Translational.Sources.ConstantForce gravityCW(f_constant = g_n*CounterWeightMass) annotation(
      Placement(transformation(origin = {-50, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Mechanics.Translational.Sources.ConstantForce gravityCabin(f_constant = g_n*CabinMass) annotation(
      Placement(transformation(origin = {48, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b pulleyShaft annotation(
      Placement(transformation(origin = {-100, 70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-8, 62}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.RealOutput cabinPosition annotation(
      Placement(transformation(origin = {104, 46}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {46, -72}, extent = {{-18, -18}, {18, 18}})));
    pulleyAndRope tractionPack(travelDifferential = deltaH, travelSlack = hSlack, cabinStart = hStart) annotation(
      Placement(transformation(origin = {-4, 64}, extent = {{-24, -24}, {24, 24}})));
    Modelica.Blocks.Discrete.ZeroOrderHold positonSensor(samplePeriod = SamplingTime) annotation(
      Placement(transformation(origin = {68, 48}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(gravityCW.flange, CounterWeight.flange_b) annotation(
      Line(points = {{-50, -76}, {-50, -70}}, color = {0, 127, 0}));
    connect(Cabin.flange_a, gravityCabin.flange) annotation(
      Line(points = {{48, -60}, {48, -68}}, color = {0, 127, 0}));
    connect(tractionPack.endRopePosition, positonSensor.u) annotation(
      Line(points = {{16, 48}, {56, 48}}, color = {0, 0, 127}));
    connect(positonSensor.y, cabinPosition) annotation(
      Line(points = {{80, 48}, {89, 48}, {89, 46}, {104, 46}}, color = {0, 0, 127}));
    connect(pulleyShaft, tractionPack.pulleyShaft) annotation(
      Line(points = {{-100, 70}, {-4, 70}}));
    connect(tractionPack.flange_b, CounterWeight.flange_a) annotation(
      Line(points = {{-22, 42}, {-50, 42}, {-50, -50}}, color = {0, 127, 0}));
    connect(tractionPack.flange_a, Cabin.flange_b) annotation(
      Line(points = {{12, 42}, {48, 42}, {48, -40}}, color = {0, 127, 0}));
    annotation(
      Icon(graphics = {Rectangle(origin = {-32, -64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Vertical, extent = {{-4, 24}, {4, -24}}), Rectangle(origin = {11, -65}, fillPattern = FillPattern.Solid, extent = {{-17, 25}, {17, -25}}), Ellipse(origin = {-9, 63}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Sphere, extent = {{-23, 23}, {23, -23}}), Line(origin = {-35.9286, -1.28571}, points = {{4, -38}, {4, 64}}), Line(origin = {15.4945, 4.56044}, points = {{-1, 58}, {-1, -44}}), Rectangle(origin = {11, -65}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, borderPattern = BorderPattern.Engraved, extent = {{-15, 23}, {15, -23}}, radius = 6), Text(origin = {56, 67}, extent = {{-34, 11}, {34, -11}}, textString = "pulley shaft"), Text(origin = {57, -36}, extent = {{-51, 16}, {51, -16}}, textString = "sensor
reading"), Text(origin = {-9, 102}, textColor = {0, 0, 255}, extent = {{-53, 12}, {53, -12}}, textString = "%name")}),
      Diagram);
  end elevatorHoistway;

  model pulleyAndRope
    Modelica.Mechanics.Rotational.Interfaces.Flange_b pulleyShaft annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 22}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a annotation(
      Placement(transformation(origin = {72, -90}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, -92}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b annotation(
      Placement(transformation(origin = {-74, -90}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-74, -90}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Interfaces.RealOutput endRopePosition annotation(
      Placement(transformation(origin = {108, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {86, -70}, extent = {{-10, -10}, {10, 10}})));
    parameter SI.Length pulleyRadius = 2;
    parameter SI.Velocity maximumSpeed = 1.1;
    parameter SI.MomentOfInertia pulleyInertia = 24;
    parameter SI.LinearDensity ropeDensity = 3;
    // parameter SI.LinearStrain ropeStrain;
    parameter SI.Length travelDifferential = 20 "distance between lowest and highest floor";
    parameter SI.Length travelSlack = 2 "distance between pulley and highest floor";
    parameter SI.Height cabinStart = 0 "starting Position of the Cabin";
    // angle pulley(start = 0, stateSelect = StateSelect.prefer)
    SI.Angle theta(stateSelect = StateSelect.prefer);
    SI.AngularVelocity thetad(start = 0);
    SI.AngularAcceleration thetadd(start = 0);
    SI.Velocity speed "speed of cabin and counterweight is assumed equal for both, convention: positive speed for Right shaft (cabin) going up";
    SI.Acceleration acc;
    // rope weight
    SI.Mass ml;
    SI.Mass mr;
    SI.Length lr;
    SI.Length ll;
    SI.Length traveledDistance "distance traveled by the cabin, positive up";
    SI.Height shaftHeight = travelDifferential + travelSlack;
    SI.Height cabinPos;
  initial equation
// cabinPos = cabinStart "Specify initial conditions";
// traveledDistance = 0;
  equation
    pulleyShaft.phi = theta;
    thetad = der(theta);
    thetadd = der(thetad);
    speed = thetad*pulleyRadius;
    acc = der(speed);
    lr + cabinPos = shaftHeight;
    ll + lr = 2*shaftHeight;
    ml = ll*ropeDensity;
    mr = lr*ropeDensity;
    traveledDistance = theta*pulleyRadius;
    cabinPos = cabinStart + traveledDistance;
// torque balance. tau positive ccw
    pulleyShaft.tau - pulleyInertia*thetadd + pulleyRadius*(g_n*(ml - mr) - acc*(ml + mr) + flange_b.f - flange_a.f) = 0;
    flange_a.s = lr;
    flange_b.s = ll;
    endRopePosition = cabinPos;
    assert(cabinPos <= travelDifferential, "The cabin went too high", AssertionLevel.warning);
    assert(0 <= cabinPos, "The cabin went too low", AssertionLevel.warning);
    assert(abs(speed) < maximumSpeed, "The cabin is too fast", AssertionLevel.warning);
    annotation(
      Diagram,
      Icon(graphics = {Ellipse(origin = {-2, 25}, extent = {{-74, 73}, {74, -73}}), Ellipse(origin = {-1, 25}, fillColor = {204, 204, 204}, fillPattern = FillPattern.Sphere, extent = {{-71, 71}, {71, -71}}), Rectangle(origin = {-74, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{-2, -19}, {2, 19}}), Rectangle(origin = {70, 3}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{2, -21}, {-2, 21}}), Rectangle(origin = {70, -61}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{-2, -19}, {2, 19}}), Rectangle(origin = {-72, -63}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{-2, -19}, {2, 19}}), Line(origin = {-72.9358, -47.7356}, points = {{-17.9929, -3.69289}, {-13.9929, 4.30711}, {-7.99289, -3.69289}, {0.00710678, 4.30711}, {8.00711, -3.69289}, {14.0071, 4.30711}, {22.0071, -1.69289}}), Line(origin = {70.2785, -44.8785}, points = {{-17.9929, -3.69289}, {-13.9929, 4.30711}, {-7.99289, -3.69289}, {0.00710678, 4.30711}, {8.00711, -3.69289}, {14.0071, 4.30711}, {22.0071, -1.69289}}), Line(origin = {-74.0072, -24.5213}, points = {{-17.9929, -3.69289}, {-13.9929, 4.30711}, {-7.99289, -3.69289}, {0.00710678, 4.30711}, {8.00711, -3.69289}, {14.0071, 4.30711}, {22.0071, -1.69289}}), Line(origin = {70.6356, -21.6642}, points = {{-17.9929, -3.69289}, {-13.9929, 4.30711}, {-7.99289, -3.69289}, {0.00710678, 4.30711}, {8.00711, -3.69289}, {14.0071, 4.30711}, {22.0071, -1.69289}}), Text(origin = {-3, -80}, textColor = {0, 0, 255}, extent = {{-49, 14}, {49, -14}}, textString = "%name")}));
  end pulleyAndRope;

  block softStart
  Modelica.Blocks.Interfaces.RealInput positionReading annotation(
      Placement(transformation(origin = {-101, -53}, extent = {{-27, -27}, {27, 27}}), iconTransformation(origin = {-88, 8}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput brakingOutput annotation(
      Placement(transformation(origin = {116, 60}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {102, 56}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput motorControl annotation(
      Placement(transformation(origin = {120, -50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {108, -56}, extent = {{-10, -10}, {10, 10}})));
  parameter SI.Length targetPos = 15 "target floor heigth";
  parameter SI.Length decDistance = 1 "how soon should it start the decelleration routine";
  parameter SI.Time deltaAcc = 1 "how long the acceleration curve takes";
  parameter SI.Time deltaDec = 0.5 "how long the deceleration curve takes";
  parameter SI.Velocity vn = 1 "nominal speed, our target";
  
  algorithm
  
  
  equation
  annotation(
      Diagram,
  Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -90}, textColor = {0, 0, 255}, extent = {{-82, 12}, {82, -12}}, textString = "%name"), Line(origin = {22.6154, -11.7692}, points = {{-64, 11}, {52, 11}}), Text(origin = {61, 64}, extent = {{-27, 16}, {27, -16}}, textString = "break"), Text(origin = {71, -53}, extent = {{-23, 19}, {23, -19}}, textString = "motor"), Text(origin = {-57, 54}, extent = {{-37, 12}, {37, -12}}, textString = "position"), Line(origin = {19.9869, -4.09}, points = {{-41.9117, -18.9117}, {-21.9117, -14.9117}, {-11.9117, -2.91165}, {0.0883484, 11.0883}, {18.0883, 17.0883}, {34.0883, 19.0883}, {42.0883, 19.0883}}, thickness = 1.25, smooth = Smooth.Bezier)}));
end softStart;
end Elevator;
