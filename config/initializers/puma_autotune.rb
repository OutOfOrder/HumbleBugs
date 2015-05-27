if defined? PumaAutoTune
  PumaAutoTune.config do |config|
    config.ram           = Integer(ENV['PUMA_AUTOTUNE_RAM'] || 512) # mb: available on system
    config.frequency     = Integer(ENV['PUMA_AUTOTUNE_FREQUENCY'] || 20)   # seconds: the duration to check memory usage
    config.reap_duration = Integer(ENV['PUMA_AUTOTUNE_DURATION'] || 30)   # seconds: how long `reap_cycle` will be run for
  end
  PumaAutoTune.start
end

