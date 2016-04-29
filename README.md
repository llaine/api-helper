# Microservice helper

Simple microservice job handler based on Cuba and Sikediq
for image and email processing.

### How to
```
bundle install
foreman start
```

This will start, redis, sidekiq and rack.

Then go to localhost:9292


### Test

```
 curl -X POST -d "notification[subject]=toto&user[email]=tototo@yopmail.com" http://localhost:9292/mail
```
