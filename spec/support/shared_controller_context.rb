shared_context "for devise" do
  before { controller.stub(:authenticate_base_user!).and_return true }
  before { controller.stub(:current_base_user).and_return user  }
  before { controller.stub(:sign_in).and_return nil }

  let(:user) { create :user }

  let(:resource) { create resource_name }
  let(:id) { resource.id }
  let(:attributes) { attributes_for resource_name }

  let(:response_body) { JSON.parse(response.body) }
  let(:error_messages) { -> { if response.status == 500 then <<-EOM
#{response_body['error_code'].camelize}: #{response_body['error']} (#{response.status})
  from #{response_body['backtrace'][0]}"
  from #{response_body['backtrace'][1]}"
  from #{response_body['backtrace'][2]}"
EOM
    else "unexpected response status, got #{response.status}" end
  }}

  let(:attach_args) { {} }
  let(:reset_args) { nil }
end