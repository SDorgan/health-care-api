require 'date'
require 'time'

class DateManager
  DATE_FORMAT = '%d/%m/%Y'.freeze
  ARG_TIMEZONE = '-03:00'.freeze

  def self.date # rubocop:disable Metrics/AbcSize
    if ENV['RACK_ENV'] != 'production' && !ENV['TEST_DATE'].nil?
      t = Time.now
      d = DateTime.strptime(ENV['TEST_DATE'], DATE_FORMAT)
      DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec, t.zone).new_offset(ARG_TIMEZONE)
    else
      DateTime.now.new_offset(ARG_TIMEZONE)
    end
  end
end
