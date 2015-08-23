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
    : selector begin_rule end_rule
    | selector begin_rule properties end_rule
    | selector begin_rule rule end_rule
    | selector begin_rule properties rule end_rule
    | selector begin_rule rule properties end_rule
    | selector begin_rule properties rule properties end_rule
    ;

    selector : SELECTOR { @handler.selector(val[0]) }
    begin_rule : BEGINRULE
    end_rule : ENDRULE

  properties
    : property
    | properties property
    ;
    property : PROPERTY { @handler.scalar(result) }
end


---- inner

  require_relative 'handler'

  attr_reader :handler

  def initialize tokenizer, handler = Handler.new
    @tokenizer = tokenizer
    @handler   = handler
    super()
  end

  def next_token
    token = @tokenizer.next_token

    while token == ["", ""] do
      token = @tokenizer.next_token
    end

    token
  end

  def parse
    do_parse
    handler
  end
