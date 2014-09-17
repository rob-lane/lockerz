require 'active_model'
Dir[__dir__ + '/../app/**/'].each { |d| $LOAD_PATH.unshift(d) }
require 'base'
Dir[__dir__+'/../app/**/*.rb'].each { |f| require File.basename(f) }


