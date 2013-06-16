workit
======

Serving static html pages with Ruby and Rack.

This is a work in progress and an exercise in understanding Rack and web requests.

To use:
Create an html file in the `/pages` directory and it will be available at the route matching the filename. Root path looks for a file called `index.html`. 404 will be returned if matching file does not exist.
