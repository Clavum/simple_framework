For information on what the model generator is and how to use it, see the wiki page titled 'Model Generator' in the wiki:
https://dev.azure.com/HNB-Huntington/OMNI/_wiki/wikis/OMNI.wiki/15526/Model-Generator

For those who want to make updates to the generator, or are just curious, here's a brief explanation of what each file is for.

#model.dart & parameter.dart:
These files are models which represent the class which is annotated, as well as the parameters in the model constructor.

#model_generator_annotation.dart
This is the file exposed to developers - it holds the annotation classes such as `@generateEntity`.

#generate_model_builder.dart
This is the entry point to the generator. You can find it listed in the build.yaml file.

#model_generator.dart
Is used by the generateModelBuilder. It's method, generateForAnnotatedElement is called individually for each model to generate.

The method is provided an `element`, which is the object that was annotated. The generator hands this element to the
ModelVisitor (see next topic) to have it "visited" and gets a Model in return. The ModelGenerator converts the fields in the
Model into the generated code in String format. The generateModelBuilder then puts this String into the generated file.

#model_visitor.dart
Is given an `element` which is meant to represent the model class which has been annotated. It "visits" the class, it's
constructor, and the constructor's parameters to populate a Model, which holds the elements visited.

Most verification of the annotated class' syntax is done in this file, such as making sure all the required elements to make
the generation work are present and written correctly.