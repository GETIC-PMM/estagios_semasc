require "rails_helper"

RSpec.describe SolicitacoesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/solicitacoes").to route_to("solicitacoes#index")
    end

    it "routes to #new" do
      expect(get: "/solicitacoes/new").to route_to("solicitacoes#new")
    end

    it "routes to #show" do
      expect(get: "/solicitacoes/1").to route_to("solicitacoes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/solicitacoes/1/edit").to route_to("solicitacoes#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/solicitacoes").to route_to("solicitacoes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/solicitacoes/1").to route_to("solicitacoes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/solicitacoes/1").to route_to("solicitacoes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/solicitacoes/1").to route_to("solicitacoes#destroy", id: "1")
    end
  end
end
