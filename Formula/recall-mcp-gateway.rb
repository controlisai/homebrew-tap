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
  version "1.0.0-beta.7"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.7/recall-mcp-gateway-darwin-arm64.tar.gz"
      sha256 "02626b10896a65d8dbb3810e9d393e95e4d66a946522ac50e0b1a1970237cb39"
    end
    on_intel do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.7/recall-mcp-gateway-darwin-amd64.tar.gz"
      sha256 "d292acd736f0e1e976ad01de62f8e76e31f6fca3e49cb8ad39fd8d8595856386"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.7/recall-mcp-gateway-linux-arm64.tar.gz"
      sha256 "37a83863376a8be3c519fcba22de8052e02a77280ca4b314ea170576d8ffd0c5"
    end
    on_intel do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.7/recall-mcp-gateway-linux-amd64.tar.gz"
      sha256 "5f2a05dfd0e223f37a562cfe14bbf78a24a9d69edad867348ed25eee7ffed389"
    end
  end

  def install
    # Binary in tarball is platform-suffixed (e.g., recall-mcp-gateway-darwin-arm64)
    binary = Dir["recall-mcp-gateway-*"].first || "recall-mcp-gateway"
    bin.install binary => "recall-mcp-gateway"
  end

  post_install_steps do
    warn "Recall MCP Gateway installed!"
    warn "Quick start: recall-mcp-gateway --from-claude-config"
    warn "Dashboard:   http://localhost:8090/dashboard"
    warn "Docs:        https://controlis.ai/#/docs/deployment"
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
