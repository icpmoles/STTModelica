within STTlibrary.Components.Events.Examples;
model SequenceExample3
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
  Modelica.Blocks.MathBoolean.OnDelay onDelay1(delayTime = 1) annotation (
    Placement(visible = true, transformation(origin = {116, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.MathBoolean.OnDelay onDelay3(delayTime = 1) annotation (
    Placement(visible = true, transformation(origin = {116, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.MathBoolean.OnDelay onDelay4(delayTime = 1) annotation (
    Placement(visible = true, transformation(origin = {116, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.MathBoolean.OnDelay onDelay5(delayTime = 1) annotation (
    Placement(visible = true, transformation(origin = {24, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant step2Fbk(k = true) annotation (
    Placement(visible = true, transformation(origin = {116, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(step2Fbk.y, sequencer.stepsFeedback[2]) annotation (
    Line(points = {{128, 2}, {146, 2}, {146, -80}, {-54, -80}, {-54, 0}, {-44, 0}, {-44, 0}}, color = {255, 0, 255}));
  connect(falseConst.y, srff1.R) annotation (
    Line(points = {{28, 70}, {54, 70}, {54, 24}, {66, 24}, {66, 24}}, color = {255, 0, 255}));
  connect(onDelay5.y, sequencer.reset) annotation (
    Line(points = {{36, -12}, {40, -12}, {40, -34}, {-50, -34}, {-50, -12}, {-44, -12}, {-44, -12}}, color = {255, 0, 255}));
  connect(sequencer.EOS, onDelay5.u) annotation (
    Line(points = {{1.49012e-07, -11.2}, {10, -11.2}}, color = {255, 0, 255}));
  connect(onDelay4.y, sequencer.stepsFeedback[4]) annotation (
    Line(points = {{128, -60}, {137, -60}, {137, -60}, {146, -60}, {146, -80}, {-54, -80}, {-54, 0}, {-44, 0}}, color = {255, 0, 255}));
  connect(srff4.Q1, onDelay4.u) annotation (
    Line(points = {{86.2, -54}, {102.2, -54}, {102.2, -60}, {102.2, -60}}, color = {255, 0, 255}));
  connect(onDelay3.y, sequencer.stepsFeedback[3]) annotation (
    Line(points = {{128, -30}, {137, -30}, {137, -30}, {146, -30}, {146, -80}, {-54, -80}, {-54, 0}, {-44, 0}}, color = {255, 0, 255}));
  connect(srff3.Q1, onDelay3.u) annotation (
    Line(points = {{86.2, -24}, {93.2, -24}, {93.2, -24}, {100.2, -24}, {100.2, -30}, {102.2, -30}}, color = {255, 0, 255}));
  connect(onDelay1.y, sequencer.stepsFeedback[1]) annotation (
    Line(points = {{128, 30}, {136, 30}, {136, 30}, {146, 30}, {146, -80}, {-54, -80}, {-54, 0}, {-44, 0}}, color = {255, 0, 255}));
  connect(srff1.Q1, onDelay1.u) annotation (
    Line(points = {{86.2, 36}, {93.2, 36}, {93.2, 36}, {100.2, 36}, {100.2, 30}, {100.2, 30}, {100.2, 30}, {102.2, 30}}, color = {255, 0, 255}));
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
end SequenceExample3;
