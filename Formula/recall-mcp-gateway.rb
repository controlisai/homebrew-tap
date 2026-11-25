# Homebrew formula for Recall MCP Gateway
# Tap: controlisai/tap
# Install: brew install controlisai/tap/recall-mcp-gateway
#
# To publish:
# 1. Build release binaries: make release
# 2. Create GitHub release and upload artifacts
# 3. Update SHA256 values below
# 4. Push to homebrew-tap repo

class RecallMcpGateway < Formula
  desc "MCP tool monitoring & governance gateway for AI agents"
  homepage "https://github.com/controlisai/recall-mcp-gateway"
  version "1.0.0-beta.5"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.5/recall-mcp-gateway-darwin-arm64.tar.gz"
      sha256 "77cc59cda31025a500570d1092293328b476bdd940e37fde70136a4437987384"
    end
    on_intel do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.5/recall-mcp-gateway-darwin-amd64.tar.gz"
      sha256 "39a29d0dd9eb5e24f48a181d23c111431b3402279fcd0c58d3effb14942d6a59"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.5/recall-mcp-gateway-linux-arm64.tar.gz"
      sha256 "c7ecd5392fa041826e9658e37e562019348638b655bceec00fee8fc4b666a866"
    end
    on_intel do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.5/recall-mcp-gateway-linux-amd64.tar.gz"
      sha256 "101639f835b70866a82f1926cf020abda2c0de1f7f8cfa10959d8975f19e1229"
    end
  end

  def install
    # Binary in tarball is platform-suffixed (e.g., recall-mcp-gateway-darwin-arm64)
    binary = Dir["recall-mcp-gateway-*"].first || "recall-mcp-gateway"
    bin.install binary => "recall-mcp-gateway"
  end

  def post_install
    ohai "Recall MCP Gateway installed!"
    ohai "Quick start: recall-mcp-gateway --from-claude-config"
    ohai "Dashboard:   http://localhost:8090/dashboard"
    ohai "Docs:        https://controlis.ai/#/docs/deployment"
  end

  test do
    output = shell_output("#{bin}/recall-mcp-gateway --version")
    assert_match "recall-mcp-gateway", output
  end

  service do
    run [opt_bin/"recall-mcp-gateway", "--config", etc/"recall-mcp-gateway/config.yaml"]
    keep_alive true
    log_path var/"log/recall-mcp-gateway.log"
    error_log_path var/"log/recall-mcp-gateway-error.log"
  end
end
