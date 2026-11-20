cask "browser-deck" do
  version "1.1.0"
  sha256 "a74b6eeb44f773d1019f898b0c5c22f9df6c46f5fffe96eeba7feb646d46a100"

  url "https://github.com/kanharithsok/browser-deck/releases/download/v#{version}/BrowserDeck-#{version}-arm64.zip"
  name "BrowserDeck"
  desc "Multiple real browser sessions in one flexible workspace"
  homepage "https://github.com/kanharithsok/browser-deck"

  livecheck do
    url "https://github.com/kanharithsok/browser-deck/releases/latest"
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "BrowserDeck.app"

  # The app is ad-hoc signed and not notarized, so remove the download
  # quarantine flag that would otherwise make Gatekeeper block first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/BrowserDeck.app"]
  end

  uninstall quit: "com.kanharithsok.browser-deck"

  zap trash: [
    "~/Library/Application Support/BrowserDeck",
    "~/Library/Caches/com.kanharithsok.browser-deck",
    "~/Library/Preferences/com.kanharithsok.browser-deck.plist",
    "~/Library/Saved Application State/com.kanharithsok.browser-deck.savedState",
  ]

  caveats <<~EOS
    BrowserDeck is an unsigned/ad-hoc local build and is not notarized.
    This cask removes the download quarantine flag so Gatekeeper does not block first launch.
  EOS
end
