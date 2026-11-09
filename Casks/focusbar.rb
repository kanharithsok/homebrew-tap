cask "focusbar" do
  version "1.0.0"
  sha256 "c161948c7a0fb7e95fa3682f74eb91933f69cdbf95621faa2ee93dfbdc74dd53"

  url "https://github.com/kanharithsok/focus-bar/releases/download/v#{version}/FocusBar-#{version}.zip"
  name "FocusBar"
  desc "Menu-bar focus sessions with best-effort distraction blocking"
  homepage "https://github.com/kanharithsok/focus-bar"

  livecheck do
    url "https://github.com/kanharithsok/focus-bar/releases/latest"
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "FocusBar.app"

  # This build is Apple Development signed, not notarized. Remove the
  # download quarantine flag so Gatekeeper does not block the first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/FocusBar.app"]
  end

  uninstall quit:       "com.kanharithsok.FocusBar",
            login_item: "FocusBar"

  zap trash: [
    "~/Library/Application Support/FocusBar",
    "~/Library/Saved Application State/com.kanharithsok.FocusBar.debug.savedState",
    "~/Library/Saved Application State/com.kanharithsok.FocusBar.savedState",
  ]

  caveats <<~EOS
    Before uninstalling FocusBar, open Settings -> System-wide website blocking -> Remove helper.
    Homebrew does not automatically unregister the SMAppService LaunchDaemon.
    If the app was already deleted, remove its background item in
    System Settings -> General -> Login Items & Extensions.
  EOS
end
