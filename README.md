Spud Events
===========

Spud Events is an event and calendaring engine for the Spud Engine

Installation/Usage
------------------

1. Add the following to your Gemfile

        gem 'spud_events'

2. Run ```bundle install```
3. Copy the database migrations in to your rails project

        rake railties:install:migrations

4. Run the database migrations ```rake db:migrate```
5. The defualt URL for the calendar page is ```/calendar```

Configruations
--------------

* Set the layout for the calendar pages (Defualt is layouts/spud/calendar)

        Spud::Events.configure do |config|
          config.calendar_layout = 'application'
        end

* Override the default calendar views by placing the corresponding views in the ```calendars``` and ```calendar_events``` view folders.
* Include the default calendar CSS by adding the following to your ```application.css``` file

        /*
        ...
        *= require spud/events
        */

Testing
-----------------

Spud uses RSpec for testing. Get the tests running with a few short commands:

1. Create and migrate the databases:

        rake db:create
        rake db:migrate

2. Load the schema in to the test database:

        rake app:db:test:prepare

3. Run the tests with RSpec

        rspec spec

After the tests have completed the current code coverage stats is available by opening ```/coverage/index.html``` in a browser.

