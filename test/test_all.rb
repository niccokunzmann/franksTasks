#!/usr/bin/env ruby
#
# this module includews all test cases
#

require "test/unit"
require "rubygems"
gem "selenium-client", ">=1.2.18"
require "selenium/client"

class SeleniumTest < Test::Unit::TestCase
    attr_reader :browser

  def setup
    @browser = Selenium::Client::Driver.new \
        :host => "localhost", 
        :port => 4444, 
        :browser => "*firefox", 
        :url => "http://localhost:4567/", 
        :timeout_in_second => 60
    browser.start_new_browser_session
  end

  def teardown
    browser.close_current_browser_session
  end
end

class MainPageTest < SeleniumTest
  def test_page_search
        browser.open "/"
        assert_equal "Frank's Tasks", browser.title
  end
end

