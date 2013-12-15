def upgrade_python_pip(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:python_pip, :upgrade, resource_name)
end

def create_python_virtualenv(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:python_virtualenv, :create,
    resource_name)
end
