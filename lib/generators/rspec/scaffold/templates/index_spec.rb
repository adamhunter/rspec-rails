require 'spec_helper'

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
describe "<%= table_name %>/index.html.<%= options[:template_engine] %>" do
  include <%= controller_class_name %>Helper

  before(:each) do
    assign(:<%= table_name %>, [
<% [1,2].each_with_index do |id, model_index| -%>
      stub_model(<%= class_name %><%= output_attributes.empty? ? (model_index == 1 ? ')' : '),') : ',' %>
<% output_attributes.each_with_index do |attribute, attribute_index| -%>
        :<%= attribute.name %> => <%= attribute.default.inspect %><%= attribute_index == output_attributes.length - 1 ? '' : ','%>
<% end -%>
<% if !output_attributes.empty? -%>
      <%= model_index == 1 ? ')' : '),' %>
<% end -%>
<% end -%>
    ])
  end

  it "renders a list of <%= table_name %>" do
    render
<% for attribute in output_attributes -%>
    response.should have_selector("tr>td", :content => <%= attribute.default.inspect %>.to_s, :count => 2)
<% end -%>
  end
end
