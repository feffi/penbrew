require 'formula'

class HashcatLegacy < Formula
  homepage 'https://github.com/hashcat/hashcat-legacy'
  url "https://github.com/hashcat/hashcat-legacy", :using => :git, :revision => '0906a8a'
  version "2.0"

  def install
    if OS.linux?
      if Hardware::CPU.is_64_bit?
        system "make", "posix64"
        pkgshare.install Dir['*']
        bin.install_symlink "#{pkgshare}/hashcat-cli64.bin" => 'hashcat-legacy'
      else
        system "make", "posix32"
        pkgshare.install Dir['*']
        bin.install_symlink "#{pkgshare}/hashcat-cli32.bin" => 'hashcat-legacy'
      end
    else
      system "make", "osx"
      pkgshare.install Dir['*']
      bin.install_symlink "#{pkgshare}/hashcat-cli64.app" => 'hashcat-legacy'
    end
  end
end
