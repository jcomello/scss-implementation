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
      when text = @ss.scan(SELECTOR)   then [:SELECTOR, text.strip]
      when text = @ss.scan(BEGINRULE)  then [:BEGINRULE, text.strip]
      when text = @ss.scan(PROPERTY)   then [:PROPERTY, text.strip]
      when text = @ss.scan(ENDRULE)    then [:ENDRULE, text.strip]

      else
        x = @ss.getch
        [x.strip,x.strip]
      end
    end
  end
end
