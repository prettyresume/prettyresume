prettyresume
============

Real time resume creation web app from JSON

Github OAuth:

  myprettyresume is a GAE folder. the runtime is python. main.py redirects to myprettyresume/index.html. all the OAuth functions are in myprettyresume/oauth.js. in OAuth.initialize('KtHQPnf0Xywefg8q_uZHuMAmQgg'), the value in quotes is the public key for an app that I created on oauth.io. it's a constant value (like a client-id for an app on a provider like github/facebook etc). i've created an app on github. I used the client-key and client-secret from that app to register for the app in oauth.io.

  The javascript of interest are in the following files:
  myprettyresume/index.html [with login button] and myprettyresume/mainpage.html [the landing mainpage on authentication]
  
  
  
