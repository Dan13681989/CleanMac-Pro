class CleanmacPro < Formula
  desc "Professional macOS optimization and cleaning suite"
  homepage "https://github.com/Dan13681989/CleanMac-Pro"
  url "https://github.com/Dan13681989/CleanMac-Pro/archive/refs/tags/v2.0.tar.gz"
  sha256 "[AUTO-GENERATED]"
  license "MIT"

  def install
    bin.install "cleanmac-pro.sh" => "cleanmac"
  end

  test do
    system "#{bin}/cleanmac", "--version"
  end
end
