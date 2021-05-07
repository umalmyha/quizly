defmodule QuizlySrv.Util.TimeUtil do
  def date_from_unix_time(unix_time) do
    datetime = datetime_from_unix_time(unix_time)
    DateTime.to_date(datetime)
  end

  def datetime_from_unix_time(unix_time) do
    DateTime.from_unix!(unix_time)
  end

  def date_from_today(days) do
    Date.add(Date.utc_today(), days)
  end
end
