module ApplicationHelper

  def link_if_not_zero number, link
    if number == 0
      number
    else
      link_to number, link
    end
  end
end
