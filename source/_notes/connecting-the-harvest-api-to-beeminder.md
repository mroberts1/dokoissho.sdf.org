---
title: Connecting the Harvest API to Beeminder
date:  2020-02-11
---

This is a little script I wrote to send my logged
[Harvest](https://getharvest.com/) hours to a [Beeminder](https://beeminder.com)
goal. It's possible to do this via IFTTT or Zapier, but I had a couple of
additional requirements:

1. Should only submit data at the end of the day
2. Only wanted a single data-point in my Beeminder graph
3. Wanted each entry to be rounded up to the nearest 15 minutes

Let's take them in order.


### 1 - Only submit data at the end of the day

I use cron to run the script every night at 10:55pm. I thought about running it at
midnight, but the deadline stops me from working too late.

```
55 22 * * * cd <script directory> && ./log_time > /<script directory>/bee.log
```


### 2 - Only want a single data point in my graph

Nothing too complex here, the script fetches all individual entries for the day
and adds them together.

```ruby
client = Harvest.client(
  subdomain: ENV['HARVEST_SUBDOMAIN'],
  username:  ENV['HARVEST_USERNAME'],
  password:  ENV['HARVEST_PASSWORD']
)

todays_entries = client.time.all
total_time     = 0

todays_entries.each do |entry|
  total_time += entry.hours
end
```

I'd like to replace the `each` loop with something more Ruby-ish, but for now it works.


### 3 - Round all entries up to the nearest 15 minutes

```ruby
# Round up a floating point time value to the nearest quarter hour.
def round_to_quarter_hour(time)
  (time * 4).ceil / 4.0
end

# Update the sum loop
todays_entries.each do |entry|
  total_time += round_to_quarter_hour(entry.hours)
end
```


### The finished script

All configuration details are stored in a `.env` file in the script directory.

```ruby
# frozen_string_literal: true

require 'beeminder'
require 'dotenv/load'
require 'harvested'

# Round up a floating point time value to the nearest quarter hour.
def round_to_quarter_hour(time)
  (time * 4).ceil / 4.0
end

puts 'Fetching data...'

client = Harvest.client(
  subdomain: ENV['HARVEST_SUBDOMAIN'],
  username:  ENV['HARVEST_USERNAME'],
  password:  ENV['HARVEST_PASSWORD']
)

# Get all entries for today.
todays_entries = client.time.all
total_time     = 0

# Round up each entry to nearest 0.25.
todays_entries.each do |entry|
  total_time += round_to_quarter_hour(entry.hours)
end

# Submit the value to beeminder.
beeminder = Beeminder::User.new(
  ENV['BEEMINDER_TOKEN'],
  auth_type: :personal
)

puts 'Sending data...'

beeminder.send(
  ENV['BEEMINDER_GOAL'],
  total_time,
  "AUTO: #{total_time} hours billed for day"
)

puts 'Done'
```
