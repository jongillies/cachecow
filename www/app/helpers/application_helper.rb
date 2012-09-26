module ApplicationHelper


  def link_to_if_not_zero number, link
    raise "Number does not respond to to_i :-(" unless number.respond_to? :to_i
    if number == 0
      number
    else
      link_to number, link
    end
  end

end
