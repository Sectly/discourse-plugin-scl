# frozen_string_literal: true

# name: discourse-plugin-scl
# about: A discourse plugin for Straks Cargo Ltd forum: https://forum.strakscargo.ltd/
# meta_topic_id: TODO
# version: 0.0.1
# authors: Sectly
# url: https://github.com/Sectly/discourse-plugin-scl
# required_version: 2.7.0

enabled_site_setting :plugin_name_enabled

module ::MyPluginModule
  PLUGIN_NAME = "discourse-plugin-scl"
end

require_relative "lib/my_plugin_module/engine"

after_initialize do
  # This does nothing, keeping it here encase we need to add something later
  
  # See: https://meta.discourse.org/t/-/30515?silent=true
end