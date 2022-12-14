FROM node:8.12

# See: https://github.com/jeffgreenca/docker-mermaidcli/blob/master/Dockerfile

RUN     mkdir -p /app/project

# See https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md
# See https://crbug.com/795759
RUN apt-get update && apt-get install -yq libgconf-2-4

# Install latest chrome dev package and fonts to support major charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)
# Note: this installs the necessary libs to make the bundled version of Chromium that Puppeteer
# installs, work.
RUN     apt-get update \
    &&  apt-get install --no-install-recommends -y \
            wget \
    &&  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    &&  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    &&  apt-get update \
    &&  apt-get install --no-install-recommends -y \
            google-chrome-unstable \
            fonts-ipafont-gothic \
            fonts-wqy-zenhei \
            fonts-thai-tlwg \
            fonts-kacst ttf-freefont \
    &&  rm -rf /var/lib/apt/lists/* \
    &&  apt-get purge --auto-remove -y \
            curl \
    &&  rm -rf /src/*.deb

RUN yarn --verbose add mermaid.cli
ADD ./puppeteer-config.json /
