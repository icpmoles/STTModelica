within STTlibrary.Components.Mechanics.BaseClasses;
partial model SpringStopBase
  parameter SI.TranslationalSpringConstant c(final min=0) = 1e6 "Stop Spring constant";
  parameter SI.TranslationalDampingConstant d(final min=0) = 1e6 "Stop Damper constant";

  // variables
  SI.Length s_rel "relative-to-support position";
  SI.Velocity v_rel(start = 0) "relative-to-support velocity";
  SI.Force f_spring "spring force";
  SI.Force f_damper "damper force";
  SI.Force f_stop = f_spring + f_damper "total end-position force";

equation
  der(s_rel) = v_rel;
  f_spring = if s_rel>0 then c*s_rel else 0;
  f_damper = if s_rel>0 then d*v_rel else 0;

end SpringStopBase;
