require_relative 'rcss/parser'
require_relative 'rcss/tokenizer'
require 'stringio'

module RCSS
  VERSION = '1.0.0'

  def self.load(rcss)
    input   = rcss
    tok     = RCSS::Tokenizer.new input
    parser  = RCSS::Parser.new tok
    handler = parser.parse
    handler.result
  end
end
