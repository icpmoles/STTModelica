within STTlibrary.Components;

package Elevator
  extends Modelica.Icons.Package;
  import Modelica.Constants.g_n;

  package Simulation
    extends Modelica.Icons.ExamplesPackage;

    model Simple
    
      parameter Real radius = 4;
      parameter Real cambio = 0.1;
      elevatorHoistway elevatorAssembly(CabinMass = 2200, hSlack = 1, deltaH = 20, CounterWeightMass = 1500, hStart = 10, pulleyRadius = radius) annotation(
        Placement(transformation(origin = {44, -16}, extent = {{-46, -46}, {46, 46}})));
      Motor.ControlledMotor controlledMotor(p = 2, Kt = 10000, R = 0.00005, L = 0.1e-6) annotation(
        Placement(transformation(origin = {-110, 14}, extent = {{-10, -10}, {10, 10}})));
    
      genF genF1(riseT = 2.7, raggio = radius/cambio)  annotation(
        Placement(transformation(origin = {-176, 14}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = cambio)  annotation(
        Placement(transformation(origin = {-40, 12}, extent = {{-10, -10}, {10, 10}})));
    equation
    connect(controlledMotor.wref, genF1.y) annotation(
        Line(points = {{-120, 14}, {-165, 14}}, color = {0, 0, 127}));
    connect(controlledMotor.flange_b, idealGear.flange_a) annotation(
        Line(points = {{-98, 14}, {-50, 14}, {-50, 12}}));
    connect(idealGear.flange_b, elevatorAssembly.pulleyShaft) annotation(
        Line(points = {{-30, 12}, {40, 12}}));
      annotation(
        Diagram);
    end Simple;

    model Feedback
      parameter SI.Length startinPos = 5;
      parameter SI.Length finalPos = 6;
      parameter SI.Velocity nomVel = 1 "m/s nominal speed of the elevator";
      parameter Integer motorPoles = 1;
      parameter SI.Length pulleyRadius = 5 "radius size of the pulley";
      parameter Real cambio = 0.1;
      // (finalPos - startinPos)/nomVel "supposing instaneous acceleration how much time it will need to reach the target";
      elevatorHoistway elevator(CabinMass = 2200, hSlack = 1, deltaH = 40, CounterWeightMass = 2200, hStart = startinPos, pulleyRadius = pulleyRadius) annotation(
        Placement(transformation(origin = {44, -16}, extent = {{-46, -46}, {46, 46}})));
      Motor.ControlledMotor controlledMotor(p = motorPoles, Kt = 10000, R = 0.00005, L = 0.1e-6) annotation(
        Placement(transformation(origin = {-88, 8}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = cambio)  annotation(
        Placement(transformation(origin = {-38, 8}, extent = {{-10, -10}, {10, 10}})));
      ss2 ss21(raggio = pulleyRadius, cambio = cambio, initialPos = startinPos, setP = finalPos)  annotation(
        Placement(transformation(origin = {-158, 14}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Mechanics.Rotational.Components.Brake brake(fn_max = 2000)  annotation(
        Placement(transformation(origin = {4, 10}, extent = {{-10, -10}, {10, 10}})));
    equation
      connect(controlledMotor.flange_b, idealGear.flange_a) annotation(
        Line(points = {{-77, 8}, {-48, 8}}));
  connect(controlledMotor.wref, ss21.speed) annotation(
        Line(points = {{-98, 8}, {-145, 8}, {-145, 9}}, color = {0, 0, 127}));
  connect(ss21.pos, elevator.cabinPosition) annotation(
        Line(points = {{-169, 14}, {-192, 14}, {-192, -86}, {130, -86}, {130, -50}, {66, -50}}, color = {0, 0, 127}));
  connect(idealGear.flange_b, brake.flange_a) annotation(
        Line(points = {{-28, 8}, {-6, 8}, {-6, 10}}));
  connect(brake.flange_b, elevator.pulleyShaft) annotation(
        Line(points = {{14, 10}, {40, 10}, {40, 12}}));
  connect(brake.f_normalized, ss21.brakeSignal) annotation(
        Line(points = {{4, 22}, {-144, 22}, {-144, 18}}, color = {0, 0, 127}));
      annotation(
        Diagram,
  experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02));
    end Feedback;
  end Simulation;

  model elevatorHoistway
    parameter SI.Mass CabinMass = 120;
    parameter SI.Mass CounterWeightMass = 100;
    parameter SI.Time SamplingTime = 250e-6 "from LIMAX1M datasheet";
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
    pulleyAndRope tractionPack(travelDifferential = deltaH, travelSlack = hSlack, cabinStart = hStart, pulleyRadius = pulleyRadius, pulleyInertia = 24) annotation(
      Placement(transformation(origin = {-4, 64}, extent = {{-24, -24}, {24, 24}})));
    Modelica.Blocks.Discrete.ZeroOrderHold positonSensor(samplePeriod = SamplingTime, ySample(fixed = true)) annotation(
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
    parameter SI.Length pulleyRadius = 3.550;
    parameter SI.Velocity maximumSpeed = 1.1;
    parameter SI.MomentOfInertia pulleyInertia = 2;
    parameter SI.LinearDensity ropeDensity = 3*1.140 "linear weigth of rope or belt in kg/m , eg 3x BRUbelt 218kN";
    parameter SI.Force ropeStrength = 3*218e3 "breaking load of belt in Newton , eg 3x BRUbelt 218kN";
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
    ll + lr = shaftHeight + travelSlack ;
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
    assert(abs(flange_a.s) <= travelDifferential, "The cabin went too high", AssertionLevel.warning);
    assert(0 <= cabinPos, "The cabin went too low", AssertionLevel.warning);
    assert(abs(flange_b.f) < ropeStrength, "The belt just failed", AssertionLevel.warning);
    annotation(
      Diagram,
      Icon(graphics = {Ellipse(origin = {-2, 25}, extent = {{-74, 73}, {74, -73}}), Ellipse(origin = {-1, 25}, fillColor = {204, 204, 204}, fillPattern = FillPattern.Sphere, extent = {{-71, 71}, {71, -71}}), Rectangle(origin = {-74, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{-2, -19}, {2, 19}}), Rectangle(origin = {70, 3}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{2, -21}, {-2, 21}}), Rectangle(origin = {70, -61}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{-2, -19}, {2, 19}}), Rectangle(origin = {-72, -63}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, extent = {{-2, -19}, {2, 19}}), Line(origin = {-72.9358, -47.7356}, points = {{-17.9929, -3.69289}, {-13.9929, 4.30711}, {-7.99289, -3.69289}, {0.00710678, 4.30711}, {8.00711, -3.69289}, {14.0071, 4.30711}, {22.0071, -1.69289}}), Line(origin = {70.2785, -44.8785}, points = {{-17.9929, -3.69289}, {-13.9929, 4.30711}, {-7.99289, -3.69289}, {0.00710678, 4.30711}, {8.00711, -3.69289}, {14.0071, 4.30711}, {22.0071, -1.69289}}), Line(origin = {-74.0072, -24.5213}, points = {{-17.9929, -3.69289}, {-13.9929, 4.30711}, {-7.99289, -3.69289}, {0.00710678, 4.30711}, {8.00711, -3.69289}, {14.0071, 4.30711}, {22.0071, -1.69289}}), Line(origin = {70.6356, -21.6642}, points = {{-17.9929, -3.69289}, {-13.9929, 4.30711}, {-7.99289, -3.69289}, {0.00710678, 4.30711}, {8.00711, -3.69289}, {14.0071, 4.30711}, {22.0071, -1.69289}}), Text(origin = {-3, -80}, textColor = {0, 0, 255}, extent = {{-49, 14}, {49, -14}}, textString = "%name")}));
  end pulleyAndRope;

  block ss2
  type elevatorState = enumeration(
          starting "elevator receive setpoint",
          acceleration "elevator reaching nominal speed",
          cruise "nominal speed",
          deceleration "elevator reaching 0 speed",
          stop "zero speed");
    Modelica.Blocks.Interfaces.RealOutput speed annotation(
        Placement(transformation(origin = {133, -59}, extent = {{-43, -43}, {43, 43}}), iconTransformation(origin = {132, -54}, extent = {{-30, -30}, {30, 30}})));
    Modelica.Blocks.Interfaces.RealOutput brakeSignal annotation(
        Placement(transformation(origin = {145, 37}, extent = {{-53, -53}, {53, 53}}), iconTransformation(origin = {135, 49}, extent = {{-33, -33}, {33, 33}})));
    Modelica.Blocks.Interfaces.RealInput pos annotation(
        Placement(transformation(origin = {-117, -3}, extent = {{-55, -55}, {55, 55}}), iconTransformation(origin = {-114, 4}, extent = {{-20, -20}, {20, 20}})));
    discrete Real s;
    parameter Real initialPos;
    parameter Real raggio;
    parameter Real cambio;
    parameter Real riseT = 2;
    parameter Real startDec = 9 - riseT;
    parameter Real fullDistance = setP - initialPos  "distance it,s supposed to tranverse, positive up "; // = 0;
    parameter Real setP = 19;
    final parameter Real normDistance = 0.6034501612189380 "integral(speed) for 1s of acceleration time";
     Real decelerationDistance = normDistance * riseT;
    final parameter Integer direction (start= sign(setP-initialPos),fixed=true  )  "postive=up, ccw";
  //  discrete Real a "acceleration or cruise";
   discrete Real b "braking";
    //parameter Real initialPos (fixed = false) "position of start, automaticaly calculated";
    // discrete Boolean half;
    elevatorState currentState(start = elevatorState.starting, fixed = true) "sequence current state";
  protected
    Modelica.Blocks.Interfaces.RealInput internalMotOut;
    Modelica.Blocks.Interfaces.RealInput internalBraOut;
  
  algorithm
  
  when sample(0,1/1000) then
   
  // in accel interval  and "below" the middle point of the travel
    if   time>0 and  ((time < riseT and abs(pos-initialPos) < abs(fullDistance/2)) or currentState == elevatorState.starting) then
    currentState := elevatorState.acceleration;
    end if;
    
    if currentState == elevatorState.acceleration and (time >= riseT )  then
    currentState := elevatorState.cruise;
    end if;
    
    if (currentState == elevatorState.cruise and abs(pos-setP) <= decelerationDistance) or (currentState == elevatorState.acceleration and abs(pos-initialPos) >= abs(fullDistance/2))  then
    currentState := elevatorState.deceleration;
    end if;
    
   
   if  currentState  == elevatorState.starting then
   b:=1;
   elseif currentState  == elevatorState.acceleration then
   b:=0;
   s := min(exp( (-1 +  time/riseT)^2/( (-1 +  time/riseT)^2 -1  ) ),1);
   elseif currentState  == elevatorState.cruise then
    b:=0;
   s := 1;
   elseif currentState  == elevatorState.deceleration then
   elseif currentState  == elevatorState.stop then
   end if;
   
  end when;
   
  equation
  
    internalMotOut = direction * s / (raggio/cambio);
    brakeSignal = b;
    connect(speed, internalMotOut);
    connect(brakeSignal, internalBraOut);
    
  
  initial equation
  // fullDistance =  setP - initialPos;
  annotation(
      Icon(graphics = {Rectangle(origin = {-1, -1}, extent = {{-101, 99}, {101, -99}})}));
  end ss2;

block softStart

parameter SI.Length targetPos = 15 "target floor heigth";
parameter SI.Length decDistance = 1 "how soon should it start the decelleration routine";
parameter SI.Time deltaAcc = 1 "how long the acceleration curve takes";
parameter SI.Time deltaDec = 0.5 "how long the deceleration curve takes";
parameter SI.Velocity vn = 1 "nominal speed m/s, our target";
parameter SI.Length resolution = 1e-3 "1mm of resolution for the encoder";
parameter Real sampleTime = 100e-3 "4kHz seems reasonable for sensor controller transmission";
parameter SI.Length holdingDistance = 0.005 "distance of acceptable target precision";
parameter SI.Length radius "pulley radius";
parameter Integer poles "motor poles";
final parameter Real normDistance = 0.6034501612189380 "integral(speed) for 1s of acceleration time";
  // I/O
    Modelica.Blocks.Interfaces.RealInput positionReading annotation(
    Placement(transformation(origin = {-101, -53}, extent = {{-27, -27}, {27, 27}}), iconTransformation(origin = {-88, 8}, extent = {{-20, -20}, {20, 20}})));
Modelica.Blocks.Interfaces.RealOutput brakingOutput annotation(
    Placement(transformation(origin = {116, 60}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {102, 56}, extent = {{-10, -10}, {10, 10}})));
Modelica.Blocks.Interfaces.RealOutput motorControl annotation(
    Placement(transformation(origin = {120, -50}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {108, -56}, extent = {{-10, -10}, {10, 10}})));

// algo vars
    discrete Real startingPos = -1 "heigth of start, -1 is initialized";

//discrete Real deltaTime = 0 "interrupt interval";
    //discrete Real preTime = 0 "time at previos sampling";
    //discrete Real deltaS = 0 "change of heigth between sampling";
    discrete Real speed = 0 "estimated speed";
  //discrete Real remainingTravel = 0 "positive up";
    discrete Boolean startBraking = false "";
discrete Boolean startSlowing = false "";
  //discrete Real motorControlNorm = 0 "normalized motor control output var";
    //discrete Real s;
    discrete Boolean decStarted = false;
discrete Real startDec "time instant of start of decelleration";


protected
  Modelica.Blocks.Interfaces.RealInput internalM;
  Modelica.Blocks.Interfaces.RealInput internalB;
algorithm
/*
// when change(positionReading) then
when sample(0,sampleTime) then

// acquire variables
deltaTime := time - preTime;
preTime := time;
deltaS := positionReading - pre(positionReading);
remainingTravel := targetPos - positionReading;

// calculate speed
if abs(deltaS) < resolution or (deltaTime<1e-10) then 
speed := 0; //just assume that we are stopped or at start
else 
speed := deltaS/deltaTime;
end if;

// if close enough start braking
if abs(remainingTravel)<holdingDistance*5 then
startBraking := true;
end if;


//braking logic:
if time<0.2 or startBraking then // slightly brake at the start (to avoid cabin from moving while motor starts) and near the target
brakingOutput := 0.8;
  if abs(remainingTravel)<holdingDistance then // near the target e can brake fully
  brakingOutput := 1.0;
  end if;
else
brakingOutput := 0.0;
end if;



//soft start
if time<deltaAcc then
motorControlNorm := exp( (-1 +  time/deltaAcc)^2/( (-1 +  time/deltaAcc)^2 -1  ) );
else 
motorControlNorm := 1;
end if;




internalM := vn * motorControlNorm / radius ;
end when;
*/


when sample(0,sampleTime) then
  if startingPos == -1 then
  startingPos := positionReading;
  end if;

  if time == 0.0  then
    speed := 0;
  elseif  time < deltaAcc then
    speed := min(exp( (-1 +  time/deltaAcc)^2/( (-1 +  time/deltaAcc)^2 -1  ) ),1);
  elseif  abs(positionReading-targetPos)<deltaAcc*normDistance or  abs(positionReading-targetPos)<abs(startingPos-targetPos)/2   then
// if we start the deceleration routine we center the shape function in this time instant
    if decStarted == false then
      startDec := time;
      decStarted := true;
    end if;
  
    speed := min(exp( (-1 +  (time - startDec + deltaAcc )/deltaAcc)^2/( (-1 +  (time - startDec + deltaAcc )/deltaAcc)^2 -1  ) ),1);
    startSlowing := true;
  elseif startSlowing then
    speed := 0;
  else  
    speed := 1;
    startSlowing := false;
  end if;

end when;
equation
internalB = 1;
internalM = speed / radius;
connect(motorControl,internalM);
connect(brakingOutput,internalB);

annotation(
    Diagram,
Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -90}, textColor = {0, 0, 255}, extent = {{-82, 12}, {82, -12}}, textString = "%name"), Line(origin = {22.6154, -11.7692}, points = {{-64, 11}, {52, 11}}), Text(origin = {61, 64}, extent = {{-27, 16}, {27, -16}}, textString = "brake"), Text(origin = {71, -53}, extent = {{-23, 19}, {23, -19}}, textString = "motor"), Text(origin = {-57, 54}, extent = {{-37, 12}, {37, -12}}, textString = "position"), Line(origin = {19.9869, -4.09}, points = {{-41.9117, -18.9117}, {-21.9117, -14.9117}, {-11.9117, -2.91165}, {0.0883484, 11.0883}, {18.0883, 17.0883}, {34.0883, 19.0883}, {42.0883, 19.0883}}, thickness = 1.25, smooth = Smooth.Bezier)}));
end softStart;

  block genF
  Modelica.Blocks.Interfaces.RealOutput y annotation(
      Placement(transformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}})));
  discrete Real s;
  parameter Real raggio;
  parameter Real cambio;
  parameter Real riseT = 2;
  parameter Real startDec = 9 -riseT;
  
  parameter Real setP = 19;
  discrete Real a;
  
  protected
    Modelica.Blocks.Interfaces.RealInput internalM;
  algorithm
  
  when sample(0,1/100) then
    s := time;
    if time == 0.0  then
    s := 0;
    elseif  time < riseT then
    s := min(exp( (-1 +  time/riseT)^2/( (-1 +  time/riseT)^2 -1  ) ),1);
    elseif  time > startDec and time < 9 then
    s := min(exp( (-1 +  (time - startDec + riseT )/riseT)^2/( (-1 +  (time - startDec + riseT )/riseT)^2 -1  ) ),1);
    a := 1;
    elseif a > 0 then
   
    s := 0;
    else  // cruising
    s := 1;
    a := 0;
    end if;
  
  end when;
   
  equation
  
  internalM = s / raggio;
  connect(y, internalM);
    
    
  end genF;
end Elevator;
