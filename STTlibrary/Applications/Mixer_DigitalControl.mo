within STTlibrary.Applications;

model Mixer_DigitalControl
  extends STTlibrary.Components.ReplaceableComponents.SystemArchitecture(
    redeclare STTlibrary.Components.ReplaceableComponents.Plant plant,
    redeclare STTlibrary.Components.ReplaceableComponents.Sensors sensors,
    redeclare STTlibrary.Components.ReplaceableComponents.Actuators actuators,
    redeclare STTlibrary.Components.ReplaceableComponents.DigitalControl control, 
    levelSP(duration = 2, height = -1.5, offset = 4, startTime = 30), 
    hSP(duration = 2, height = 0.5e5, offset = 1e5, startTime = 30)
  );
  extends Modelica.Icons.Example;
annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {0.5, 0.5}), graphics = {Text(origin = {110, 70}, extent = {{-70, 10}, {70, -10}}, textString = "Digital Control")}),
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-6, Interval = 0.12));
end Mixer_DigitalControl;