class CleanmacPro < Formula
  desc "Professional macOS optimization and network performance toolkit"
  homepage "https://github.com/Dan13681989/CleanMac-Pro"
  url "https://github.com/Dan13681989/CleanMac-Pro/archive/refs/tags/v2.2.3.tar.gz"
  sha256 "ac12a50881c76a2e0366585f9897e477c3e0ba2fadcb05ac7df78f5b82fe2c09"
  license "MIT"

  depends_on :macos

  def install
    # Install main script
    bin.install "cleanmac"
    
    # Install additional command scripts
    bin.install "cleanmac-dashboard"
    bin.install "cleanmac-analyze"
    bin.install "cleanmac-large-files"
    bin.install "cleanmac-smart-cache"
    bin.install "cleanmac-docker-clean"
    bin.install "cleanmac-security-scan"
    bin.install "cleanmac-enterprise"
    
    # Make them executable
    chmod 0755, bin/"cleanmac"
    chmod 0755, bin/"cleanmac-dashboard"
    chmod 0755, bin/"cleanmac-analyze"
    chmod 0755, bin/"cleanmac-large-files"
    chmod 0755, bin/"cleanmac-smart-cache"
    chmod 0755, bin/"cleanmac-docker-clean"
    chmod 0755, bin/"cleanmac-security-scan"
    chmod 0755, bin/"cleanmac-enterprise"
  end

  test do
    system "#{bin}/cleanmac", "--version"
  end
end
