ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
  :default => '%d/%m/%Y',
  :fechaYMD => '%Y/%m/%d')
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(:default => '%d/%m/%Y %H:%M')