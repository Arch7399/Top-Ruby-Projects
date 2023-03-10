require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(number)
  number = number.gsub(/[()-]/, "")
  if number.length < 10
    return "Bad number"
  elsif number.length == 10
    return number
  elsif number.length == 11 && number[0] == "1"
    return number[1..-1]
  else
    return "Bad number"
  end
end


def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end


def time_parser(time, array1, array2)
  
  time_object = Time.strptime(time, '%m/%d/%y %H:%M')
  array1 << [time_object.hour]
  array2 << [Date::DAYNAMES[time_object.wday]]
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  './root/event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('./root/form_letter.erb')
erb_template = ERB.new template_letter
busy_hour = []
busy_day = []

contents.each do |row|

  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone_number(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)
  time_parser(row[:regdate], busy_hour, busy_day)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end

puts "Most busy hour: #{busy_hour.group_by{|i| i}.values.max_by(&:size).first}"
puts "Most busy day: #{busy_day.group_by{|i| i}.values.max_by(&:size).first}"

