require 'dotenv'
require 'keen'
require "csv"

# given a keen project, count all the number of events in each event collection, output results to console and csv
# specify your project id, read key, and master key in .env
# KEEN_PROJECT_ID=x
# KEEN_READ_KEY=y
# KEEN_MASTER_KEY=Z

Dotenv.load

# allow timeframe to be specified via the command line
# usage: ruby collection_counts.rb previous_7_days
if !ARGV[0].nil?
	timeframe = ARGV[0]
else
  timeframe = 'previous_30_days'
end

# iterates over collections and counts the total number of events in each
total_events = 0
collections = []

Keen.event_collections.each {|collection|
	collection = collection["name"]

	# count
  results = Keen.count(collection,
    :timeframe => timeframe,
  )

  # print the results in the console
  puts collection + " " + results.to_s

  # sum up the to find total events in project
	total_events += results
  collections.push([collection, results])
}

collections.sort! {|x,y| 
  if x[1] > y[1]
    0
  elsif x[1] < y[1]
    -1
  else
    1
  end
}

# Create a CSV file to output the results
# You need to delete the file if one already exists 
CSV.open("event_counts_"+ENV["KEEN_PROJECT_ID"]+"_"+timeframe+".csv", "wb") do |csv|
  csv << ["project id", "collection", "count"]
end

collections.each do |data|
  CSV.open("event_counts_"+ENV["KEEN_PROJECT_ID"]+"_"+timeframe+".csv", "a+") do |csv|
    csv << [ENV["KEEN_PROJECT_ID"], data[0], data[1]]
  end
end

puts "total events,#{total_events}"
