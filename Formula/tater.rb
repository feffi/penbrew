require "formula"

class Tater < Formula
  homepage "https://github.com/Kevin-Robertson/Tater"
  head "https://github.com/Kevin-Robertson/Tater", :using => :git, :branch => "master"
  url "https://github.com/Kevin-Robertson/Tater", :using => :git, :revision => "1753e62"
  version "0.20160422"

  def install
    pkgshare.install Dir["*"]
  end

  def caveats; <<-EOS.undent
    The Tater script can be found in #{HOMEBREW_PREFIX}/share/tater
    EOS
  end
end
