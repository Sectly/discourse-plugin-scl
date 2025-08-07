# frozen_string_literal: true

# name: discourse-plugin-scl
# about: A discourse plugin for Straks Cargo Ltd forum: https://forum.strakscargo.ltd/
# meta_topic_id: TODO
# version: 0.0.1
# authors: Discourse
# url: https://github.com/Sectly/discourse-plugin-scl
# required_version: 2.7.0

enabled_site_setting :plugin_name_enabled

module ::SCLPlugin
  PLUGIN_NAME = "discourse-plugin-scl"
end

require_relative "lib/my_plugin_module/engine"

class Onebox::Engine::SCLPlugin
  include Onebox::Engine
  # Try to match the URL to the plugin's domain and ensure it contains 'job'
  matches_regexp /(?=.*strakscargo\.ltd)(?=.*\bjob\b)/i

  # Embed the URL in an iframe
  def to_html
    "<iframe name='embed_readwrite' src='#{@url}?discourse=true&embed=true' style='border-width:0' frameborder='0' scrolling='no' width='100%' height=600></iframe><br><a href='#{@url}?discourse=true' target='_blank'>Open in a new tab</a>"
  end
end

after_initialize do
  # This does nothing, keeping it here encase we need to add something later
end