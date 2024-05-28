within STTlibrary.Applications;
model ControlledMixer
  extends STTlibrary.Components.StreamConnectors.Examples.MixerBase(p_H(hnom = 2e5));
  extends Modelica.Icons.Example;
  Modelica.Blocks.Math.Feedback split annotation (
    Placement(visible = true, transformation(origin = {-132, -12}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression thetaC(y = 1)  annotation (
    Placement(visible = true, transformation(origin = {-164, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp hSP(duration = 2, height = 0.5e5, offset = 1e5, startTime = 30)  annotation (
    Placement(visible = true, transformation(origin = {-170, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.StreamConnectors.h_sensor hM annotation (
    Placement(visible = true, transformation(origin = {-34, -42}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  Modelica.Blocks.Sources.Ramp MSP(duration = 2, height = -150, offset = 360, startTime = 30) annotation (
    Placement(visible = true, transformation(origin = {-170, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback err_h annotation (
    Placement(visible = true, transformation(origin = {-134, 30}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback err_M annotation (
    Placement(visible = true, transformation(origin = {-132, 70}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PIM(T = 2, initType = Modelica.Blocks.Types.Init.InitialOutput, k = -1e-2, x_start = 0.5, y_start = 0.5)  annotation (
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PIh(T = 2, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 1e-5, x_start = 0, y_start = 0)  annotation (
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiterM(uMax=1, uMin=0) annotation (Placement(visible=true, transformation(
        origin={-50,70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Nonlinear.Limiter limiterH(uMax=1, uMin=0) annotation (Placement(visible=true, transformation(
        origin={-50,30},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(limiterM.y, vlv_M.theta) annotation (
    Line(points = {{-38, 70}, {4, 70}, {4, -64}, {-16, -64}, {-16, -78}, {-16, -78}}, color = {0, 0, 127}));
  connect(limiterH.y, vlv_H.theta) annotation (
    Line(points = {{-38, 30}, {-20, 30}, {-20, -6}, {-106, -6}, {-106, -38}, {-106, -38}}, color = {0, 0, 127}));
  connect(limiterH.y, split.u2) annotation (
    Line(points = {{-38, 30}, {-20, 30}, {-20, 8}, {-132, 8}, {-132, -4}, {-132, -4}}, color = {0, 0, 127}));
  connect(hM.h_meas, err_h.u2) annotation (
    Line(points = {{-34, -36}, {-33, -36}, {-33, -28}, {-4, -28}, {-4, 52}, {-134, 52}, {-134, 38}}, color = {0, 0, 127}));
  connect(tank.M_meas, err_M.u2) annotation (
    Line(points = {{-44, -60}, {0, -60}, {0, 92}, {-132, 92}, {-132, 78}, {-132, 78}}, color = {0, 0, 127}));
  connect(PIh.y, limiterH.u) annotation (
    Line(points = {{-78, 30}, {-64, 30}, {-64, 30}, {-62, 30}}, color = {0, 0, 127}));
  connect(PIM.y, limiterM.u) annotation (
    Line(points = {{-78, 70}, {-62, 70}, {-62, 70}, {-62, 70}, {-62, 70}}, color = {0, 0, 127}));
  connect(err_M.y, PIM.u) annotation (
    Line(points = {{-122, 70}, {-102, 70}, {-102, 70}, {-102, 70}}, color = {0, 0, 127}));
  connect(err_h.y, PIh.u) annotation (
    Line(points = {{-124, 30}, {-102, 30}, {-102, 30}, {-102, 30}}, color = {0, 0, 127}));
  connect(MSP.y, err_M.u1) annotation (
    Line(points = {{-158, 70}, {-140, 70}, {-140, 70}, {-140, 70}}, color = {0, 0, 127}));
  connect(hSP.y, err_h.u1) annotation (
    Line(points = {{-158, 30}, {-142, 30}, {-142, 30}, {-142, 30}}, color = {0, 0, 127}));
  connect(hM.flange, tank.fl_b) annotation (
    Line(points = {{-34, -48}, {-34, -48}, {-34, -80}, {-44, -80}, {-44, -80}}));
  connect(thetaC.y, split.u1) annotation (
    Line(points = {{-153, -12}, {-140, -12}}, color = {0, 0, 127}));
  connect(split.y, vlv_C.theta) annotation (
    Line(points = {{-123, -12}, {-123, -66}, {-106, -66}, {-106, -78}}, color = {0, 0, 127}));
annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-6, Interval = 0.12));
end ControlledMixer;
