cask 'musescore' do
  version '3.0.5.21343'
  sha256 'be052c6f7fe782cc7a24cb319be9b9b6c5f8661aac328f36908ce97d50ecafac'

  # musescore.com was verified as official when first introduced to the cask
  url "https://download.musescore.com/releases/MuseScore-#{version.major_minor_patch}/MuseScore-#{version.major_minor_patch}.dmg"
  appcast "https://sparkle.musescore.org/stable/#{version.major}/macos/appcast.xml"
  name 'MuseScore'
  homepage 'https://musescore.org/'

  depends_on macos: '>= :sierra'

  app "MuseScore #{version.major}.app"
  # shim script (https://github.com/caskroom/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/mscore.wrapper.sh"
  binary shimscript, target: 'mscore'

  preflight do
    IO.write shimscript, <<~EOS
      #!/bin/sh
      exec '#{appdir}/MuseScore #{version.major}.app/Contents/MacOS/mscore' "$@"
    EOS
  end
end
