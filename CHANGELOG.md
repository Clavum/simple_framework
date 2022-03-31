Started off with simplifying repository to use singleton with get and set methods for entities.

Then changed to calling bloc methods directly from screen (no more actions), and getting rid of view
model.

Removed bloc boilerplate by making 1:1 relationship between a bloc and a entity pipe.

Wanted to simplify having to get entity every method, and send it to the Screen. Started of with
a method provided from the bloc that gives entity then sends when done. But then moved to getter and
send method for Entity.

TODO: Remove presenter and widget. Screen should just build for every Entity.