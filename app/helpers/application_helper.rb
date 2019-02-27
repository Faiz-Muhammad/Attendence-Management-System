module ApplicationHelper

  def hours_in_a_day(att)
    if (att.check_in != nil && att.check_out != nil)
      hour = (att.check_out.hour - att.check_in.hour).to_f
      min = (att.check_out.min - att.check_in.min).to_f
      hour + (min/100)
    else
      0
    end
  end
end
