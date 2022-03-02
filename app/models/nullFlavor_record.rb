# for using in models with null_flavors
class NullFlavorRecord < ActiveRecord::Base
  self.abstract_class = true

  def nullFlavor(attr_name)
    value = null_flavors.find { |el| el.parent_attr == attr_name }
    if value
      value.code
    else
      false
    end
  end
end
