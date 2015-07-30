class RCSS::Parser
token SELECTOR PROPERTY BEGINRULE ENDRULE
rule
  stylesheet
    : rules
    ;
  rules
    : rule
    | rule rules
    ;
  rule
    : SELECTOR BEGINRULE ENDRULE
    | SELECTOR BEGINRULE properties ENDRULE
    | SELECTOR BEGINRULE rule ENDRULE
    | SELECTOR BEGINRULE properties rule ENDRULE
    | SELECTOR BEGINRULE rule properties ENDRULE
    | SELECTOR BEGINRULE properties rule properties ENDRULE
    ;
  properties
    : PROPERTY
    | properties PROPERTY
    ;
end
