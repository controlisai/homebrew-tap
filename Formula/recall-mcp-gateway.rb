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
  version "1.0.0-beta.4"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.4/recall-mcp-gateway-darwin-arm64.tar.gz"
      sha256 "e30e6ed7b678be84ab76e10847116cc2a0edf326b9340c07b01e6c109c49413f"
    end
    on_intel do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.4/recall-mcp-gateway-darwin-amd64.tar.gz"
      sha256 "c7d17ef960694280e60d13a38fd7447b0bd2056d7aa3ae4665bf164753d1be39"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.4/recall-mcp-gateway-linux-arm64.tar.gz"
      sha256 "f80495b818245a9d2e7efe80b8834cd24428d15f85c2bddebf0d7fe599c5c7df"
    end
    on_intel do
      url "https://github.com/controlisai/recall-mcp-gateway/releases/download/v1.0.0-beta.4/recall-mcp-gateway-linux-amd64.tar.gz"
      sha256 "a7165f8d39c5e8fd90f314eb23c0ed430c9fb2e0a3d108225e78d0ee1243f9aa"
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
