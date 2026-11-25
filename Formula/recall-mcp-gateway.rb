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
  version "1.0.0-beta.6"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.6/recall-mcp-gateway-darwin-arm64.tar.gz"
      sha256 "486d47227aca39925a542b1288f5fff0bae8e931e426ec2bd1578f8bf7c722fa"
    end
    on_intel do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.6/recall-mcp-gateway-darwin-amd64.tar.gz"
      sha256 "f710befd649da46fdf4c4f867b781a7a780a3ed425c8caa5e9dd84f9ba8630b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.6/recall-mcp-gateway-linux-arm64.tar.gz"
      sha256 "d75213d8b21faaa5f8950c83282659493435950afc2e598e0d4810cb4b7812f6"
    end
    on_intel do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.6/recall-mcp-gateway-linux-amd64.tar.gz"
      sha256 "4f68b75ee513b829726a3ef2a70660d1b7be261c450d08d3e25d5928b5f3468c"
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
