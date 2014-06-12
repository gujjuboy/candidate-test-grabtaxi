candidate-test-grabtaxi
=========

candidate-test-grabtaxi is provides sets API:

  - Handle the booking when Passenger booking taxi.
  - Assigns the nearest driver to a booking.

Version
----

1.0

Tech
-----------

candidate-test-grabtaxi uses a number of open source projects to work properly:

* [Ruby On Rails] - Open source web framwork.
* [geokit-rails] - Official Geokit plugin for Rails/ActiveRecord. Provides location-based goodness for your Rails app. Requires the Geokit gem.
* [sidekiq] - Simple, efficient background processing for Ruby.
* [rest-client] - Simple HTTP and REST client for Ruby, inspired by microframework syntax for specifying actions

Installation
--------------

+ Checkout


```sh
git clone https://github.com/hotuy/candidate-test-grabtaxi.git candidate-test-grabtaxi
cd candidate-test-grabtaxi

```

1. Run 2 app: firstapp and secondapp by 2 terminal in repository.

2. Setup `firstapp`: Handle the booking when Passenger booking taxi.

 2.1. Config database MySQL
 
 2.2. Config second_app_url (URL to second to call assign API): `firstapp/config/config.yml`

    ```sh
    defaults: &defaults
        second_app_url: http://[ip-address/domain]:3001

    ```
    
 2.3. Start app:
        
    ```sh
    cd candidate-test-grabtaxi/firstapp/
    rake db:migrate
    rake db:seed
    rails server -p 3000 //Change port if do you want
    
    ```

3. Start `secondapp`: Assigns the nearest driver to a booking.
    
    3.1. Config database MySQL
 
    3.2. Start app:
    
    ```sh
    cd candidate-test-grabtaxi/secondapp/
    rake db:migrate
    rake db:seed
    rails server -p 3001 //Change port if do you want
    
    ```
4. Open new terminal to start sidekiq server:
    ```sh
        bundle exec sidekiq
    
    ```

Usage
--------------
Api example:

1.1 Call API create a passenger record with my phone number:


```sh
curl "http://[ip-address/domain]:3000/passenger/create?phone=986467146"

```
    
    
2.2 Retrieve my system generated password based on my phone number (If app is production, we need send password to phone number by SMS)

```sh
{"status":"true","data":{"phone":986467146,"password":"TVFQ","created_at":"2014-06-12T10:32:55.195Z","updated_at":"2014-06-12T10:32:55.195Z"}}

```
    
2.3 Using phone and password at above step to create a booking as a passenger.
    
```sh
curl "http://[ip-address/domain]:3000/booking/create?phone=986467146&password=TVFQ"

```
    
2.4 Retrieve the details of the booking with the driver's infomation.
    
```sh
{"status":"true","data":{"id":10,"name":"Emanue9","phone":966703532,"lat":10.760067,"long":106.66273,"created_at":"2014-06-12T08:05:51.000Z","updated_at":"2014-06-12T08:05:51.000Z"}}

```

Note
--------------
Currently I use the GET method to easy test, you should convert to the POST method if you use the app.

Developed on Linux Centos environment!

Rails version 4.1.1

Ruby version ruby 2.1.2p95

[Ruby On Rails]:http://rubyonrails.org/
[geokit-rails]:https://github.com/geokit/geokit-rails
[sidekiq]:http://sidekiq.org/
[rest-client]:https://github.com/rest-client/rest-client
