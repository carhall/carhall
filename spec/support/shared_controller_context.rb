shared_context "for devise" do
  before { controller.stub(:authenticate_account!).and_return true }
  before { controller.stub(:current_account).and_return user  }
  before { controller.stub(:sign_in).and_return nil }

  let(:user) { create :user }
  let(:other) { create :user }
end

shared_context "resource" do
  let(:append_args) {{}}
  let(:append_attrs_when_build) {{}}

  let(:args) { append_args }
  let(:data) { attributes_for(resource) }
  let(:id) { @id }
end

shared_context "errors display for debugging" do
  let(:response_body) { JSON.parse(response.body) }
  let(:error_messages) { -> { 
    begin <<-EOM
#{response_body['error_code'].camelize}: #{response_body['error']} (#{response.status})
  from #{response_body['backtrace'][0]}"
  from #{response_body['backtrace'][1]}"
  from #{response_body['backtrace'][2]}"
EOM
    rescue 
      "#{response_body}"
    end << "\nWith params: #{args rescue nil}, append attrs: #{append_attrs_when_build}, user: #{user.id}"
  }}
end

shared_context "shared context" do
  include_context "for devise"
  include_context "resource"
  include_context "errors display for debugging"
end