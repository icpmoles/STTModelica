within STTlibrary.Applications;
model ControlledDrillingMachine
  extends Modelica.Icons.Example;
  STTlibrary.Components.DrillingMachine.ActuatedDrillingMachine actuatedDrillingMachine annotation (
    Placement(visible = true, transformation(origin = {-3.55271e-15, 3.55271e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  STTlibrary.Applications.DrillingProgram drillingProgram annotation (
    Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.OleoDynamic.ImposedPressure Psource(use_in_p0 = true)  annotation (
    Placement(visible = true, transformation(origin = {-40, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(drillingProgram.wref, actuatedDrillingMachine.wref) annotation (
    Line(points = {{-60, 42}, {0, 42}, {0, 16}, {0, 16}}, color = {0, 0, 127}));
  connect(drillingProgram.oilPref, Psource.in_p0) annotation (
    Line(points = {{-60, 34}, {-44, 34}, {-44, 22}, {-44, 22}, {-44, 22}}, color = {0, 0, 127}));
  connect(Psource.fl_P, actuatedDrillingMachine.oilFl) annotation (
    Line(points = {{-30, 14}, {-12, 14}, {-12, 14}, {-12, 14}}, color = {255, 170, 0}));
  annotation (
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5})),
    experiment(StartTime = 0, StopTime = 24, Tolerance = 1e-6, Interval = 0.00560224));
end ControlledDrillingMachine;
