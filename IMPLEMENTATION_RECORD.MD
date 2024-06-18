# Implementation Record

## Motivation
For starters the assignment was just to implement a game of tic tac toe using rails, which by itself is a pretty broad thing. Since this is a web application I thought the it's features should focus on things enabled by the web, thus playing multiplayer with somebody else came to my mind as a feature that highlights the web nature of the game instead of a simple javascript fully local implementation.

I decided to leverage some of Rails 7 new features like it's Turbo Broadcast integration to have a redis powered fully server side game of tic tac toe remain in sync across web sessions using websockets.

## Implementation
Since we're playing across the internet, the state of the game will not only live in the client but in the server, on a database, as well. I went with Postgres due to familiarity. There are no large concerns regarding performance here, but nevertheles postgres is a proven production-ready database.

The game logic lives in an opinionated ActiveRecord model, which is not the ideal abstraction for game rules, but considering how much easier it makes testing and the simplicity of the overall project I took this shortcut. So the `Match` model contains the game logic and knows how to store stuff in postgres.

For the looks of the page I went with material design lite (as suggested) but ended up adding custom CSS. The visuals are quite crude, while I'am qutie proeficient in implementing existing designs, coming up with a novel one from scractch is quite the challenge for me. I ended up going for humor since that makes it easier to stomach the aesthetic problems.

All the controllers follow pretty standard rails fare, I tried to stay idiomatic, using the ruby-isms where possible for clarity and extensibility.

## Stats
Since I've been testing the application a lot with a friend and by myself I felt it would be interesting to see some stats on how we'd been performing. It's also a nice feature since it leverages the one advantage this game has, which is being online, to aggregate interesting data points about itself.