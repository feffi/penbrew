require "formula"

class Yasuo < Formula
  homepage "https://github.com/0xsauby/yasuo"
  url "https://github.com/0xsauby/yasuo", :using => :git, :revision => '8fd52f2'
  version "2.3-20170416"

  depends_on "ruby@2.3"
  depends_on "nmap"
  depends_on "libxml2"
  depends_on "libxslt"
  depends_on "sqlite"

  resource "bundler" do
    url "https://rubygems.org/downloads/bundler-1.14.3.gem"
    sha256 "9d61c7d983b99eb0b16d64658b182e045bcdd74ef3b139e849777f780782dbfe"
  end

  def install
    (buildpath/"vendor/bundle").mkpath
    resources.each do |r|
      r.verify_download_integrity(r.fetch)
      system("#{HOMEBREW_PREFIX}/opt/ruby@2.3/bin/gem", "install", r.cached_download, "--no-document",
             "--install-dir", "vendor/bundle")
    end

    (buildpath/"Gemfile").write <<-EOS.undent
      source 'https://rubygems.org'

      gem 'ruby-nmap'
      gem 'net-http-persistent'
      gem 'mechanize'
      gem 'text-table'
      gem 'sqlite3'
    EOS

    ENV["GEM_HOME"] = "#{buildpath}/vendor/bundle"
    system "#{HOMEBREW_PREFIX}/opt/ruby@2.3/bin/ruby", "#{buildpath}/vendor/bundle/bin/bundle", "install", "--no-cache", "--path", "vendor/bundle"

    (bin/"yasuo.rb").write <<-EOS.undent
      #!/usr/bin/env bash
      export GEM_HOME="#{libexec}/vendor/bundle"
      export BUNDLE_GEMFILE=#{libexec}/Gemfile
      #{libexec}/vendor/bundle/bin/bundle exec #{HOMEBREW_PREFIX}/opt/ruby@2.3/bin/ruby #{libexec}/yasuo.rb "$@"
    EOS
    libexec.install Dir['*']
    libexec.install ".bundle"
  end
end
