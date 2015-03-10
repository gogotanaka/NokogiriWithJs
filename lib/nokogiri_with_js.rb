require "nokogiri_with_js/version"

require "nokogiri"
require "capybara"
require 'capybara/poltergeist'

module NokogiriWithJs
  def self.scrape(url)
    #poltergistの設定
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, { js_errors: false, timeout: 1000 }) #追加のオプションはググってくださいw
    end
    Capybara.default_selector = :css
    session = Capybara::Session.new(:poltergeist)
    #自由にUser-Agent設定してください。
    session.driver.headers = { 'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X)" }
    session.visit url

    session.execute_script "$('#player_ad').hide();so.addVariable('autostart','true');so.write('mediaspace');"
    session.execute_script

    page = Nokogiri::HTML.parse(session.html)
  end
end
