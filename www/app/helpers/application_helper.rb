module ApplicationHelper

  def link_to_if_not_zero number, link
    raise "Number does not respond to to_i :-(" unless number.respond_to? :to_i
    if number == 0
      number
    else
      link_to number, link
    end
  end

  def my_json_diff(a,b)

      a_hash = Crack::JSON.parse(a)
      b_hash = Crack::JSON.parse(b)
      c = a_hash.diff(b_hash)
      #
      diff_js = JSON.pretty_generate(c)
      #
      Pygments.highlight(diff_js, :formatter => 'text', :lexer => 'javascript')
  end
end
