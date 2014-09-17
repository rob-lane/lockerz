require 'json'
require './spec/macros/locker_macros'

RSpec.configure do |cfg|
  cfg.extend LockerMacros
end