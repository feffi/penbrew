require "formula"

class TestsslStatic < Formula
  homepage "https://github.com/drwetter/testssl.sh"
  url "https://github.com/drwetter/testssl.sh", :using => :git, :revision => 'ed88add'
  version "2.9.5-1"

  def install
    (bin/"testssl.sh").write <<-EOS.undent
      #!/usr/bin/env bash
      cd #{libexec} && ./testssl.sh "$@"
    EOS

    libexec.install Dir["*"]
  end
end
