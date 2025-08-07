# frozen_string_literal: true

SCLPlugin::Engine.routes.draw do
  get "/examples" => "examples#index"
  # define routes here
end

Discourse::Application.routes.draw { mount ::SCLPlugin::Engine, at: "my-plugin" }
