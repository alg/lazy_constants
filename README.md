Lazy Constants
==============

There are times when you want to define a constant, but don't want to 
assign its value before later (after some environment initialization
has finished or any other event). The answer would be Lazy Constants
that evaluate their value when first accessed.


Installation
============

As a plugin:

	script/plugin install http://github.com/alg/lazy_constants.git


Definition
==========

In ActiveRecord models you just need to define the constants and
you are ready for action:

	class Model < ActiveRecord::Base
	  lazy_const("CONSTANT_1") { Model.first }
	  lazy_const("CONSTANT_2") { 99 }
	end

In any other class where you want to use the feature, include the
LazyConstants module:

	class MyClass
	  include LazyConstants
	  ...
	end



Usage
=====

All as usual:

	Model::CONSTANT_1


Copyright (c) 2010 Aleksey Gureiev, released under the MIT license
