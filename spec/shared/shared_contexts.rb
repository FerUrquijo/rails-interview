RSpec.shared_context "API format check" do |http_method, action, params = {}|
  context 'when format is HTML' do
    it 'raises a routing error' do
      expect {
        send(http_method, action, params: params)
      }.to raise_error(ActionController::RoutingError, 'Not supported format')
    end
  end
end