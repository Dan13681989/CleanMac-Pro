class CleanmacPro < Formula
  desc "Professional macOS management and optimization suite"
  homepage "https://github.com/Dan13681989/CleanMac-Pro"
  url "https://github.com/Dan13681989/CleanMac-Pro/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "auto-generated"
  license "MIT"
  
  depends_on :macos
  
  def install
    bin.install "cleanmac-dashboard"
    bin.install "enterprise-features/cleanmac-enterprise-control.sh" => "cleanmac-enterprise"
    bin.install "install-commands.sh" => "cleanmac-install"
    
    # Make executable
    chmod 0755, bin/"cleanmac-dashboard"
    chmod 0755, bin/"cleanmac-enterprise"
    chmod 0755, bin/"cleanmac-install"
  end
  
  test do
    system "#{bin}/cleanmac-dashboard"
  end
  
  def caveats
    <<~EOS
      🎉 CleanMac Pro Enterprise installed!
      
      Quick Start:
        cleanmac-enterprise    # Launch control panel
        cleanmac-dashboard     # View system status
        
      Documentation: https://github.com/Dan13681989/CleanMac-Pro
    EOS
  end
end
