within STTlibrary.Components.Events.Examples;
model SequenceExample2
  extends Modelica.Icons.Example;
  STTlibrary.Components.Events.Sequencer sequencer(numOfSteps = 4) annotation (
    Placement(visible = true, transformation(origin = {-22, 2}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanTable start(table = {1, 1.5}) annotation (
    Placement(visible = true, transformation(origin = {-84, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.Events.SRFF srff1 annotation (
    Placement(visible = true, transformation(origin = {76, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.Events.SRFF srff2 annotation (
    Placement(visible = true, transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.Events.SRFF srff3 annotation (
    Placement(visible = true, transformation(origin = {76, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  STTlibrary.Components.Events.SRFF srff4 annotation (
    Placement(visible = true, transformation(origin = {76, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant falseConst(k = false) annotation (
    Placement(visible = true, transformation(origin = {16, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.MathBoolean.OnDelay onDelay5(delayTime = 1) annotation (
    Placement(visible = true, transformation(origin = {24, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sequencer.stepCommands, sequencer.stepsFeedback) annotation (
    Line(points = {{0, 12}, {44, 12}, {44, -40}, {-58, -40}, {-58, 0}, {-44, 0}, {-44, 0}}, color = {255, 0, 255}, thickness = 0.5));
  connect(falseConst.y, srff1.R) annotation (
    Line(points = {{28, 70}, {54, 70}, {54, 24}, {66, 24}, {66, 24}}, color = {255, 0, 255}));
  connect(onDelay5.y, sequencer.reset) annotation (
    Line(points = {{36, -12}, {40, -12}, {40, -34}, {-50, -34}, {-50, -12}, {-44, -12}, {-44, -12}}, color = {255, 0, 255}));
  connect(sequencer.EOS, onDelay5.u) annotation (
    Line(points = {{1.49012e-07, -11.2}, {10, -11.2}}, color = {255, 0, 255}));
  connect(srff3.R, srff4.R) annotation (
    Line(points = {{66.2, -36}, {54.2, -36}, {54.2, -66}, {66.2, -66}, {66.2, -66}, {65.2, -66}, {65.2, -66}, {66.2, -66}}, color = {255, 0, 255}));
  connect(srff4.S, sequencer.stepCommands[4]) annotation (
    Line(points = {{66.2, -54}, {48.2, -54}, {48.2, 11}, {0.200003, 11}}, color = {255, 0, 255}));
  connect(srff2.R, srff3.R) annotation (
    Line(points = {{66.2, -6}, {54.2, -6}, {54.2, -36}, {66.2, -36}, {66.2, -36}, {66.2, -36}, {66.2, -36}}, color = {255, 0, 255}));
  connect(srff3.S, sequencer.stepCommands[3]) annotation (
    Line(points = {{66.2, -24}, {48.2, -24}, {48.2, 11}, {24.2, 11}, {24.2, 11}, {0.200003, 11}}, color = {255, 0, 255}));
  connect(srff1.R, srff2.R) annotation (
    Line(points = {{66.2, 24}, {60.2, 24}, {60.2, 24}, {54.2, 24}, {54.2, -6}, {66.2, -6}, {66.2, -6}, {66.2, -6}, {66.2, -6}}, color = {255, 0, 255}));
  connect(srff2.S, sequencer.stepCommands[2]) annotation (
    Line(points = {{66.2, 6}, {48.2, 6}, {48.2, 11}, {0.200003, 11}}, color = {255, 0, 255}));
  connect(srff1.S, sequencer.stepCommands[1]) annotation (
    Line(points = {{66.2, 36}, {48.2, 36}, {48.2, 11}, {0.200003, 11}}, color = {255, 0, 255}));
  connect(sequencer.start, start.y) annotation (
    Line(points = {{-43.56, 10.8}, {-59.56, 10.8}, {-59.56, 10.8}, {-75.56, 10.8}, {-75.56, 10.8}, {-73.56, 10.8}, {-73.56, 10.8}, {-71.56, 10.8}}, color = {255, 0, 255}));
  annotation (
    Icon(coordinateSystem(grid = {0.1, 0.1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 8, Tolerance = 1e-06, Interval = 0.016));
end SequenceExample2;
