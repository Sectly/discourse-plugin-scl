# frozen_string_literal: true

module ::MyPluginModule
  class Engine < ::Rails::Engine
    engine_name PLUGIN_NAME
    isolate_namespace MyPluginModule
    config.autoload_paths << File.join(config.root, "lib")
    scheduled_job_dir = "#{config.root}/app/jobs/scheduled"
    config.to_prepare do
      Rails.autoloaders.main.eager_load_dir(scheduled_job_dir) if Dir.exist?(scheduled_job_dir)
    end
  end

  class Onebox::Engine::MyPluginModule
    include Onebox::Engine
    # Try to match the URL to the plugin's domain and ensure it contains 'job'
    matches_regexp /(?=.*strakscargo\.ltd)(?=.*job)/i

    # Embed the URL in an iframe
    def to_html
      "<iframe name='embed_readwrite' src='#{@url}?discourse=true&embed=true' style='border-width:0' frameborder='0' scrolling='no' width='100%' height=600></iframe><br><a href='#{@url}?discourse=true' target='_blank'>Open in a new tab</a>"
    end
  end
end
