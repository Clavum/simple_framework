Started off with simplifying repository to use singleton with get and set methods for entities.

Then changed to calling bloc methods directly from screen (no more actions), and getting rid of view
model.

Removed bloc boilerplate by making 1:1 relationship between a bloc and a entity pipe.

Wanted to simplify having to get entity every method, and send it to the Screen. Started of with
a method provided from the bloc that gives entity then sends when done. But then moved to getter and
send method for Entity.

Removed Presenter and moved it's functionality to the Screen. When the Screen is first built it
builds with the defaultEntity of the Bloc. It listens to the entityPipe and simply builds the screen
again with that Entity.

Since the Bloc is the only thing that uses a Pipe, I got rid of pipes.dart and simply made the bloc
use a stream.

Because a Bloc is only associated with one Screen, I removed the BlocProvider, and now a Screen
creates it's own Bloc that only exists if it does.

Created the entity generator, which creates a while Entity file from a small class.

I realize that having to have a 1:1 relationship between an Entity and Screen won't work out in the
long run. For example, each Screen of an accounts feature should not have to store the account
information. To fix this, I made it so that the Bloc no longer handles streams, and instead they
are handled by the repository. The Repository holds a stream for each Entity type, so that multiple
Screens can subscribe for that Entity when it is sent. The Accounts entity can be shared and used
by multiple Screens. I still need to figure out a way to build a Screen using more than one Entity.

I made it so the entity send() method automatically updates the repo too.

I've been trying to figure out a way to allow a Screen to use more than one Entity. I was trying to
figure out a way to automatically be able to create a single entity that depends on other entities,
but that wasn't going to work. I then looked into doing it manually, by subscribing to entity
updates with streamOf when the bloc is built and then using that Entity's info to update some fields
in the Screen's actual Entity. But then it hit me; I can simply make an Entity that has Entities as
parameters, then set those parameters in the stream listener:
Repository().streamOf<OtherEntity>().listen((otherEntity) {
  entity.merge(otherEntity: otherEntity).send(); // Updates screen's actual entity
});

TODO:
Need a way to build screen off of multiple entities. In a bloc method, you can set the Screen's
parameters based on fetched entities, but what if the fetched entities update?
Quick way of having build context in bloc?
Test out navigation and shared navigator.
Are there some framework parameters I should make private?

TODO for entity generator:
I'm not sure I like it :(
I think the best way forward is some tool external to the IDE which generates code.
How will performance work when we have 100+ generate annotations across the app?
How to do parameters without defaults?
Need to do tests!
With current way with field variables, "view model" methods won't work.
Custom classes always show up as dynamic :(