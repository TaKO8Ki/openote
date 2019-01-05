module ApplicationHelper

  def main_url
    "http://localhost:3000"
  end

  def utf8_enforcer_tag
    "".html_safe
  end

  def count_omission(count)
    if count < 1000
      result = count
    elsif count > 1000
      count_result = count / (10 ** 2)
      reuslt = "#{count_result}K"
    end
  end





end
