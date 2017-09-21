require 'test/unit'
require 'rubygems'
require 'vcr'
require_relative 'matrix/load'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

class MatrixTest < Test::Unit::TestCase
  def test_should_pass_sentinels
    VCR.use_cassette("sentinels") do
      sentinels = Matrix::Intruders::Sentinels.new
      sentinels.hack
      assert sentinels.answers.count == 4
      assert sentinels.answers.all? { |a| a.body =~ /Welcome to the real world/ } == true
    end
  end

  def test_should_pass_loopholes
    VCR.use_cassette("loopholes") do
      loopholes = Matrix::Intruders::Loopholes.new
      loopholes.hack
      assert loopholes.answers.count == 4
      assert loopholes.answers.all? { |a| a.body =~ /Welcome to the real world/ } == true
    end
  end

  def test_should_pass_sniffers
    VCR.use_cassette("sniffers") do
      sniffers = Matrix::Intruders::Sniffers.new
      sniffers.hack
      assert sniffers.answers.count == 5
      assert sniffers.answers.all? { |a| a.body =~ /Welcome to the real world/ } == true
    end
  end
end
