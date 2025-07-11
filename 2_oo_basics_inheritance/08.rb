# The lookup path when invoking cat1.color:
# Cat
# Animal
# Object
# Kernel
# BasicObject

# Ruby went through the entirety of the method lookup path because #color was
# not found in any of the classes in the inheritance hierarchy.