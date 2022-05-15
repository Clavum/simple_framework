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
parameters, then set those parameters in the stream listener. I make this done mostly automatically
in a new bloc method called synchronizeWithRepo, which should be called onCreate:
@override
void onCreate() {
  synchronizeWithRepo(OtherEntity(), (OtherEntity otherEntity) {
    return entity.merge(otherEntity: otherEntity);
  });
}

I added the MockClassProvider, which isn't a Provider (as in state management), but is simply a
singleton which makes mocking a class easy. Instead of having to pass in mock instances into any
class, you can instead use the ClassProvider, along with a factory constructor, to automatically
mock a class from tests. I will do this for the Repository so that you can use Repository() in any
file and it will be mocked without having to worry about passing a MockRepository.

I started making custom "test()" and "group" methods for making the framework tests simpler. I'm
starting off with a test which makes testing synchronizeWithRepo easy, but that is only the start.
I will make test groups which easily handle setting up and disposing things I need.

Instead of Repository Synchronization, I provide an EntityRef to the Screen which can be called to
get an Entity and listen to it. Now Screens can very easily be based on multiple Entities. Bye bye
repo synchronization, you were great while you lasted. (This update was inspired by RiverPod)
@override
  Widget build(context, bloc, ref) {
    // The build method will be updated when ExampleEntity is sent, which causes this method to be
    // called again, so the exampleEntity variable is updated.
    var exampleEntity = ref.getEntity(ExampleEntity());

I updated my entity generator to be much better, with syntax inspired by Freezed.

I've changed the Screen so that instead of directly being given ref, it expects you to provide a
ViewModelBuilder. This builder is provided the ref which it can use to grab the Entities it wants
and create a ViewModel, which is then provided to the Screen.
This is better than what I had for a couple reasons. Firstly, it is able to prevent the Screen build
method being called if the ViewModel isn't any different. Before, the screen would rebuild for ANY
field in the Entity being updated, even it doesn't use it.
Secondly, this is more architecturally sound because the Screens only deal with ViewModels, which
make it clear that it is a purely immutable model (no merge method available!).

I added a generator for ViewModels.

I made it so that Blocs no longer require an Entity type parameter, because now there isn't a
strict relationship between a Screen and an Entity. I added global Entity getters to the Entity
generator, so now a Bloc can quickly get any Entity without excess syntax.

Added a StatelessScreen for times when you need a Bloc, but not a View Model.

Added EntityScope. Any amount of EntityScopes can be set up in a Screen. They are used to call a
method to load an Entity's data, refresh the Screen after a delay, or to clear an Entity when the
Screen is navigated away from.

TODO:
Tests!
What do I want to do with errors in the Entity?
Don't like how in Screen when you're trying to type an action, entity and defaultEntity show up.
What can I do for screens that don't need an Entity?
Consider using Hive instead of Repository? What makes it more performant than a singleton with a map? https://github.com/hivedb/hive
Entity generator - verify syntax - fix no parameters failing
Need to remove Entity type argument from Bloc. It isn't associated with a single Entity anymore.
Need to update README with latest updates, like ViewModel/Builder, after I settle on something.
Really need to refactor generators to be better. View model and Entity generators share a lot of
code.
Need a new generator for Entities that aren't intended to be in the Repository. They can have
required parameters, and they won't have the global getter.
Fix not being able to have methods in an Entity. Generated entity has errors because it doesn't
implement the method.
Screen has grown to be very complex... break it down a bit with more classes?