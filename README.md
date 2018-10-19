# RequestSchedulerClient

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/request_scheduler_client`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'request_scheduler_client', github: 'CExpress/request-scheduler-client'
```

And then execute:

    $ bundle

## Usage

You need to configure the gem for using it:

```ruby
RequestSchedulerClient.setup do |config|
  config.host = 'http://salmon.request-scheduler.c66.me' # The endpoint where the Request Scheduler service is running. (This is the production)
  config.api_key = 'oCVxjMZzG7JjHnWKcCWJhpQx' # The Application token to access the scheduler service (you need to create an Application to access it in the scheduler service backend)
  config.api_version = 1 # The API version of the scheduler service (it is currently 1)
end
```

After configuring you are free to start to capture and to send requests to the Request Scheduler service:

```ruby
response = RequestSchedulerClient::Client.new('2020-01-01 20:00:00 -0300').perform do
  calculate = 3 + 3

  HTTParty.get('http://google.com')
end
```

The request made by HTTParty won't be performed, rather it'll be captured and a call to the Request Scheduler service will be made to schedule it to `2020-01-01 20:00:00`. The response is the `ScheduledRequest` returned

## Note

It's important to notice that the `Client.perform` captures only one request, it means that if you have more than one request being made inside the block, it'll capture only the first.
