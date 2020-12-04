require_relative 'src/iglucose_api.rb'

require 'awesome_print'
require 'json'

task :default do
  puts "\n"
  puts "  Available tasks:"
  puts "\n"
  puts "    * iglucose:place_order"
  puts "    * iglucose:order_status[order_number]"
  puts "\n"
end

namespace :iglucose do
  task :place_order do
    puts "~> Reading payload.json..."
    payload = JSON.parse(File.read('./payload.json'))

    puts "\n"
    puts "Payload:"
    ap payload
    puts "\n"

    puts "~> Creating fulfillment order..."
    response = IGlucoseApi.new().create_fulfillment_order(payload)

    puts "\n"
    puts "Response:"
    ap response
    puts "\n"
  end

  task :order_status, [:order_number] do |t, args|
    order_number = args.order_number
    if order_number.nil?
      raise StandardError, "Order number must be specified"
    end

    puts "~> Checking order ##{order_number} status..."
    response = IGlucoseApi.new().get_order_status({order_number: order_number})

    puts "\n"
    puts "Response:"
    ap response
    puts "\n"
  end
end
