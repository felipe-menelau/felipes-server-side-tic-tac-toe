# README

## Running the project
Attention, currently the `main` branch does not contain any code. Run
```
git checkout server-side-tic-tac-toe
```
To be on the branch that has the implementation.

## Dependencies
This project depends on:
- Ruby 3.3.2
- Ruby-on-Rails 7
- Postgresql
- Redis
Make sure you have the correct ruby version installed and run
```
bundle install
```

You can use `docker-composer` locally to run redis and postgres. With `docker-composer` in your PATH run
```
docker-composer up
```


You can then run the database setup scripts for rails
```
rake db:setup
rake db:migrate
```

Now you can start the server with
```
rails server
```
And you're ready to play!


## Tests
This project uses rspec for testing. To run the test suite:
```
rspec
```

## Demo
You can fin a hosted demo of this application on this [link here](https://felipes-server-side-tic-tac-toe.fly.dev/).


For more information on the implementation decisions made on this project please refer to [this page](IMPLEMENTATION_RECORD.MD)