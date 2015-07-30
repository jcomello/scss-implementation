require 'strscan'

module RCSS
  class Tokenizer
    SELECTOR  = /([.#][a-zA-Z][^{]{1,})/ix
    PROPERTY  = /[^{}](.+?):(.+?);[^{}]/ix
    BEGINRULE = /{/x
    ENDRULE   = /}/x

    def initialize io
      @ss = StringScanner.new io.read
    end

    def next_token
      return if @ss.eos?

      case
      when text = @ss.scan(SELECTOR)   then [:SELECTOR, text]
      when text = @ss.scan(BEGINRULE)  then [:BEGINRULE, text]
      when text = @ss.scan(PROPERTY)   then [:PROPERTY, text]
      when text = @ss.scan(ENDRULE)    then [:ENDRULE, text]

      else
        x = @ss.getch
        [x, x]
      end
    end
  end
end
