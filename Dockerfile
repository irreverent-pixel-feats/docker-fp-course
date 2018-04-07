FROM irreverentpixelfeats/dev-haskell:ubuntu_xenial-8.0.2_1.24-20180406170635-44b67e2
MAINTAINER Dom De Re <domdere@irreverentpixelfeats.com>

# Setup neovim...
RUN mkdir -p "${HOME}/repos" \
  && cd "${HOME}/repos" \
  && git clone "https://github.com/irreverent-pixel-feats/haskell-workspace.git" \
  && cd "haskell-workspace" \
  && git checkout "31b7575" \
  && mkdir -p "${HOME}/.config" \
  && ln -sf "${HOME}/repos/haskell-workspace/nvim" "${HOME}/.config/nvim"

RUN nvim --headless +PlugInstall +qa

RUN cd "${HOME}/.config/nvim/site/plugged/vimproc.vim" \
  && make -j

RUN mkdir -p "/tmp" \
  && cd "/tmp" \
  && git clone "https://github.com/domdere/fp-course.git" \
  && cd "fp-course" \
  && git checkout "45a8501" \
  && ./mafia build \
  && cd "/tmp" \
  && rm -rf "fp-course"

ADD data tmp

RUN mkdir -p ~/var/versions && cp -v /tmp/version /var/versions/fp-course
