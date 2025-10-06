require "rails_helper"

RSpec.describe IndicacoesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/indicacoes").to route_to("indicacoes#index")
    end

    it "routes to #new" do
      expect(get: "/indicacoes/new").to route_to("indicacoes#new")
    end

    it "routes to #show" do
      expect(get: "/indicacoes/1").to route_to("indicacoes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/indicacoes/1/edit").to route_to("indicacoes#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/indicacoes").to route_to("indicacoes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/indicacoes/1").to route_to("indicacoes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/indicacoes/1").to route_to("indicacoes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/indicacoes/1").to route_to("indicacoes#destroy", id: "1")
    end
  end
end
