#!/bin/bash

set -e

which cpanm > /dev/null || (sudo cpan App::cpanminus && \
    echo "Please reload your shell config and rerun this script" && \
    exit)

which brew > /dev/null || (
    echo "We need to install something called homebrew, so that we \
          can install something called libgd. Don't ask." && \
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)" && \
    brew doctor)

brew info libgd | grep -q "Not installed" && brew install libgd --with-freetype

cpanm Config::General
cpanm Font::TTF::Font
cpanm GD || cpanm GD --force # try again, some tests fail on OSX
cpanm Math::VecStat
cpanm Math::Bezier
cpanm Readonly
cpanm Text::Format
cpanm Set::IntSpan
