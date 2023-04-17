$ docker build -t ror-jwt .
$ docker run -i -t --rm -v ${PWD}:/usr/src/app ror-jwt bash
# cd /usr/src/app
# gem install rails -v 7.0.4
# rails new . --api -T -d postgresql --skip-bundle
# exit
$ docker run -p 3000:3000 ror-jwt

sudo chown excavator:excavator -R rails-jwt-rspec/

$ docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ror7api bundle install

===============================
$ docker compose up --build
$ docker compose exec ror-jwt bin/rails g model User username
$ docker compose exec ror-jwt bundle exec rspec
==============================
Whenever a user tries to access a protected route or resource, say /books, the user agent (e.g., browser) should send the JWT. This is typically in the Authorization header using the Bearer schema. Authorization: Bearer <token>.
==============================
https://www.microverse.org/blog/test-driven-development-of-restful-json-api-with-rails
https://www.microverse.org/blog/build-a-restful-api-authentication-with-jwt
https://www.microverse.org/blog/testing-and-securing-rails-api-endpoints-with-jwt-and-postman
