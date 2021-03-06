require "formula"

class Wig < Formula
  homepage "https://github.com/jekyc/wig"
  url "https://github.com/jekyc/wig", :using => :git, :revision => 'd1ce471'
  version "0.6"
  revision 2

  depends_on :python3

  def install
    (bin/"wig.py").write <<-EOS.undent
      #!/usr/bin/env bash
      cd #{libexec} && python3 wig.py "$@"
    EOS

    libexec.install Dir["*"]
  end
end
