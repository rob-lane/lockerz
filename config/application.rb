require 'active_model'
$LOAD_PATH.unshift(__dir__)
Dir[__dir__ + '/../app/**/'].each { |d| $LOAD_PATH.unshift(d) }
require 'base'
Dir[__dir__+'/../app/**/*.rb'].each { |f| require File.basename(f) }


