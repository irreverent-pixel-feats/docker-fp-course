FROM irreverent-pixel-feats/dev-haskell:ubuntu_xenial-8.0.2_1.24-20180406170635-44b67e2
MAINTAINER Dom De Re <domdere@irreverentpixelfeats.com>

# Setup neovim...
RUN mkdir -p "~/repos" \
  && cd "~/repos" \
  && git clone "https://github.com/irreverent-pixel-feats/haskell-workspace.git" \
  && mkdir -p "~/.config" \
  && ln -sf "~/repos/haskell-workspace/nvim" "~/.config" \
  && nvim +PlugInstall +qall \
  && cd "~/.config/nvim/site/plugged/vimproc.vim" \
  && make -j

ADD data tmp

RUN mkdir -p ~/var/versions && cp -v /tmp/version /var/versions/fp-course
