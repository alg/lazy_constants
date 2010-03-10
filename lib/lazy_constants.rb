# Lazy constants let you define constants that will be assigned their
# values during the first call. This lets you defer the evaluation
# until the proper moment or even override the value later.
#
# Usage:
#
#   class Model
#     include LazyConstants
#     lazy_const("CONSTANT_1") { Model.first }
#     lazy_const("CONSTANT_2") { 99 }
#   end
#
# Calling as usual:
#
#   Model::CONSTANT_1
#   Model::CONSTANT_2
#
module LazyConstants
  module ClassMethods
    LAZY_CONSTANTS = {}

    # Defines a lazy constant that will be assigned its
    # value upon the first access. The result of the given block
    # is used as a value for this constant.
    #
    # Example usage:
    #
    # class Model
    #   lazy_const("ROOT_MODEL") { Model.first }
    # end
    #
    def lazy_const(cname, &block)
      LAZY_CONSTANTS[cname] = block
    end

    private
    
    def const_missing(name)
      block = LAZY_CONSTANTS[name.to_s]
      if block
        const_set(name, block.call)
      else
        original_c_m(name)
      end
    end
  end
  
  def self.included(receiver)
    class << receiver
      alias_method :original_c_m, :const_missing
    end
    
    receiver.extend ClassMethods
  end
end
