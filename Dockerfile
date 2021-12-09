FROM alpine:edge

RUN apk add wine wine_gecko faenza-icon-theme-wine xvfb x11vnc fluxbox xterm wget gnutls

ENV LD_LIBRARY_PATH="/usr/lib/wine/x86_64-unix:${LD_LIBRARY_PATH}"

RUN LD_LIBRARY_PATH=/usr/lib/wine/x86_64-unix wineboot --init; echo $?

RUN wget -P /tmp https://download.mql5.com/cdn/web/metaquotes.software.corp/mt5/mt5tester.setup.exe https://dl.winehq.org/wine/wine-mono/6.4.0/wine-mono-6.4.0-x86.msi

RUN wine64 msiexec /i /tmp/wine-mono-6.4.0-x86.msi /qb

CMD x11vnc -ncache_cr -create -env FD_PROG=/usr/bin/fluxbox -env X11VNC_FINDDISPLAY_ALWAYS_FAILS=1 -env X11VNC_CREATE_GEOM=${1:-1024x768x16} -gone 'killall Xvfb' -nopw
  

