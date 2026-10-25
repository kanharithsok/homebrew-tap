cask "stock-peek" do
  version "1.0.0"
  sha256 "82f9e29c31a50cf97b4185aaa6f503ce329c58f5feddad9f255ffe7de613eb26"

  url "https://github.com/kanharithsok/stock-peek/releases/download/v#{version}/MacStockWidget-#{version}.zip"
  name "MacStockWidget"
  desc "Lightweight stock quotes in the macOS menu bar"
  homepage "https://github.com/kanharithsok/stock-peek"

  livecheck do
    url "https://github.com/kanharithsok/stock-peek/releases/latest"
    strategy :github_latest
  end

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "MacStockWidget.app"

  zap trash: [
    "~/Library/Preferences/com.ks.macstockwidget.plist",
    "~/Library/Saved Application State/com.ks.macstockwidget.savedState",
  ]
end
