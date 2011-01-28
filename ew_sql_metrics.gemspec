# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ew_sql_metrics/version"

Gem::Specification.new do |s|
  s.name = "ew_sql_metrics"
  s.summary = "Publish and subscribe your Rails 3 sql operations"
  s.description = "Utilize ActiveSupport Notification API to instrument all sql operations executed by your rails application."
  s.homepage    = "http://github.com/Consoci8/ew_sql_metrics"
  s.authors     = ["Muhammad Fadhli Rahim"]
  s.email       = "fadhlirahim@gmail.com"
  
  s.files = Dir["lib/**/*"] + Dir["app/**/*"] + Dir["config/routes.rb"] + ["Gemfile","GPLv3.txt", "LICENSE.txt", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  s.version = EwSqlMetrics::VERSION.dup
  
  s.require_paths = ["lib"]
  s.add_dependency("will_paginate", "~> 3.0.pre2")
  s.add_dependency("mongoid", "2.0.0.rc.5")
  s.add_dependency("mongo", "1.1.5")
  s.add_dependency("bson_ext", "~>1.1.5")

end