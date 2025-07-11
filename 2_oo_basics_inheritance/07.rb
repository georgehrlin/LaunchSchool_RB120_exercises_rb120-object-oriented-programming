# cat1.class.ancestors will return:
# => [Cat, Animal, Object, Kernel, BasicObject]

# CORRECTION
# The question asks "(o)nly list the classes that were checked by Ruby when
# searching for the #color method". Therefore, I should've listed only Cat and
# Animal because #color is found in Animal, so Ruby skipped searching  Object,
# Kernel, and # BasicObject.