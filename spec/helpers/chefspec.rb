#
# Extensions to ChefSpec modules and classes to make our tests more readable.
#
module ChefSpec
  module Matchers
    define_resource_matchers([:create, :delete], [:python_virtualenv], :name)
  end
  class ChefRunner
    def python_virtualenv(name)
      find_resource 'python_virtualenv', name
    end
  end
end
