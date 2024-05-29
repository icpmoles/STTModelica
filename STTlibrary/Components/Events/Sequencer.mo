within STTlibrary.Components.Events;
block Sequencer
  type SequenceState = enumeration(
      reset "sequencer is waiting to start",
      setCmd "sequencer is setting the next command (i.e., is increasing the current step)",
      waitFbk "sequencer is waiting for step feedback",
      eos "sequence is ended, waiting for reset command");

  parameter Integer numOfSteps = 2 "number of sequence steps";
  SequenceState curState(start = SequenceState.reset, fixed = true) "sequence current state";

  // variables
  Integer curStep(start = 0, fixed = true) "sequence current step";

  // interface
  Modelica.Blocks.Interfaces.BooleanInput start(start = false, fixed = true) annotation (
    Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput stepsFeedback[numOfSteps](each start = false, each fixed = true) annotation (
    Placement(visible = true, transformation(origin = {-98, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput reset(start = false, fixed = true) annotation (
    Placement(visible = true, transformation(origin = {-98, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput stepCommands[numOfSteps](each start = false, each fixed = true) annotation (
    Placement(visible = true, transformation(origin = {100, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput EOS annotation (
    Placement(visible = true, transformation(origin = {98, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

algorithm
  //transition to reset status
  when not (pre(curState) == SequenceState.reset) and pre(reset) then
    curState := SequenceState.reset;
    curStep := 0;
    stepCommands := fill(false, numOfSteps);

  //reset to setCmd
  elsewhen pre(curState) == SequenceState.reset
           and pre(start) then
    curState := SequenceState.setCmd;

  //setCmd to waitFbk
  elsewhen pre(curState) == SequenceState.setCmd then
    curStep := curStep + 1;
    for i in 1:numOfSteps loop
      stepCommands[i] := (curStep == i) and not pre(stepsFeedback[curStep]);
    end for;
    curState := SequenceState.waitFbk;

   //waitFbk to setCmd/eos
   elsewhen pre(curState) == SequenceState.waitFbk
            and pre(stepsFeedback[curStep]) then
     curState := if curStep < numOfSteps
                 then SequenceState.setCmd
                 else SequenceState.eos;

   //eos
   elsewhen pre(curState) == SequenceState.eos then
     stepCommands := fill(false, numOfSteps);

  end when;

  //outupt calculation
  EOS := curState == SequenceState.eos;

initial algorithm
  assert(numOfSteps > 0, "sequence must have at least one step");

annotation (
    Icon(coordinateSystem(initialScale = 0.1, grid = {0.1, 0.1}), graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-4, 81}, extent = {{-60, 11}, {60, -11}}, textString = "SEQUENCER"), Line(origin = {0, 60}, points = {{-100, 0}, {100, 0}}), Text(origin = {-62, 40}, extent = {{-20, 6}, {20, -6}}, textString = "start"), Text(origin = {-53, -9}, extent = {{-27, 11}, {27, -11}}, textString = "stepsFbk"), Text(origin = {-62, -59}, extent = {{-22, 7}, {22, -7}}, textString = "reset"), Text(origin = {66, 31}, extent = {{-42, 27}, {16, -7}}, textString = "stepCmd"), Text(origin = {63, -61}, extent = {{-15, 9}, {15, -9}}, textString = "EOS"), Text(origin = {1, -115}, extent = {{-25, 9}, {25, -9}}, textString = "%name")}));
end Sequencer;
