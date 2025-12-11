require "./../enums/prop_visibility"
require "./../enums/prop_scope"
require "./scope"

module Crygen::Modules::Property
  alias PropertyType = NamedTuple(
    visibility: String,
    name: String,
    type: String,
    value: String?,
    scope: String,
    comment: String?,
    annotations: Array(Crygen::Types::Annotation) | Nil)

  protected getter properties = [] of PropertyType

  # Adds a property into object (visibility, name, type, value and scope).
  def add_property(
    visibility : Crygen::Enums::PropVisibility,
    name : String,
    type : String,
    *,
    value : String? = nil,
    scope : Crygen::Enums::PropScope = :public,
    comment : String? = nil,
    annotations : Array(Crygen::Types::Annotation)? = nil,
  ) : self
    @properties << {
      scope:       scope.to_s.downcase,
      visibility:  string_visibility(visibility),
      name:        name,
      type:        type,
      value:       value,
      comment:     comment,
      annotations: annotations,
    }
    self
  end

  # Generates the properties.
  protected def generate_properties : String
    String.build do |str|
      @properties.each_with_index do |prop, index|
        if index != 0 && (prop[:comment] || prop[:annotations])
          str << "\n"
        end

        if comment = prop[:comment]
          str << Crygen::Utils::Indentation.generate
          str << CGG::Comment.generate(comment.lines)
        end

        if annotations = prop[:annotations]
          annotations.each do |ann|
            str << Crygen::Utils::Indentation.generate
            str << ann.generate << "\n"
          end
        end

        str << Crygen::Utils::Indentation.generate
        str << prop[:scope] << ' ' unless prop[:scope] == "public"
        str << prop[:visibility] << ' ' << prop[:name]
        str << " : " << prop[:type] if prop[:type]
        str << " = " << prop[:value] if prop[:value]
        str << "\n"
      end
    end
  end

  # Gets the property visibility.
  private def string_visibility(visibility : Crygen::Enums::PropVisibility) : String
    case visibility
    when .nil_getter?         then "getter?"
    when .nil_property?       then "property?"
    when .class_getter?       then "class_getter"
    when .class_property?     then "class_property"
    when .class_setter?       then "class_setter"
    when .nil_class_getter?   then "class_getter?"
    when .nil_class_property? then "class_property?"
    else                           visibility.to_s.downcase
    end
  end
end
