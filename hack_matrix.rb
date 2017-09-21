#!/usr/bin/env ruby

require_relative 'matrix/load'

[Matrix::Intruders::Sentinels, Matrix::Intruders::Loopholes, Matrix::Intruders::Sniffers].each do |klass|
  klass.new.hack
end
