cask "stock-peek" do
  version "1.1.0"
  sha256 "93b49e561d63bc5915dc72f7b75cf32f38d918347c5108b50619b002d769c78a"

  url "https://github.com/kanharithsok/stock-peek/releases/download/v#{version}/StockPeek-#{version}.zip"
  name "Stock Peek"
  desc "Lightweight stock quotes in the macOS menu bar"
  homepage "https://github.com/kanharithsok/stock-peek"

  livecheck do
    url "https://github.com/kanharithsok/stock-peek/releases/latest"
    strategy :github_latest
  end

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Stock Peek.app"

  # The app is ad-hoc signed and not notarized, so remove the download
  # quarantine flag that would otherwise make Gatekeeper block it.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Stock Peek.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.ks.stockpeek.plist",
    "~/Library/Saved Application State/com.ks.stockpeek.savedState",
    "~/Library/Preferences/com.ks.macstockwidget.plist",
    "~/Library/Saved Application State/com.ks.macstockwidget.savedState",
  ]
end
