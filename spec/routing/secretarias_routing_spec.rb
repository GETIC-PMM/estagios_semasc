require "rails_helper"

RSpec.describe SecretariasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/secretarias").to route_to("secretarias#index")
    end

    it "routes to #new" do
      expect(get: "/secretarias/new").to route_to("secretarias#new")
    end

    it "routes to #show" do
      expect(get: "/secretarias/1").to route_to("secretarias#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/secretarias/1/edit").to route_to("secretarias#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/secretarias").to route_to("secretarias#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/secretarias/1").to route_to("secretarias#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/secretarias/1").to route_to("secretarias#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/secretarias/1").to route_to("secretarias#destroy", id: "1")
    end
  end
end
