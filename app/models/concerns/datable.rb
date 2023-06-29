module Datable
  def regularity_days
    days_of_week(regularity)
  end

  private

  def days_of_week(kind)
    case kind
    when "odd"
      days = every_workday_of_week.select { |date| date.wday.odd? }
    when "even"
      days = every_workday_of_week.select { |date| date.wday.even? }
    else
      days = every_workday_of_week
    end

    days.map { |date| DateTime.new(date.year, date.month, date.day, start_at.hour, start_at.min) }
  end

  def every_workday_of_week
    (current_work_day..last_work_day)
  end

  def current_work_day
   start_at.to_date
  end

  def last_work_day
    current_work_day.end_of_week - 2.days
  end
end
