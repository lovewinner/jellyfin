# lovewinner-jellyfin
FROM ubuntu:18.04
RUN apt update \
&& apt install -y ffmpeg gnupg wget apt-transport-https \
&& wget -O - https://repo.jellyfin.org/jellyfin_team.gpg.key | apt-key add - \
&& echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release ) $( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release ) main" | tee /etc/apt/sources.list.d/jellyfin.list \
&& apt update \
&& apt -d install jellyfin

RUN mkdir -p /jellyfin /media /cache \
&& chmod 777 /jellyfin /media /cache
VOLUME /jellyfin /media

RUN apt install -y jellyfin \
&& apt remove wget -y \
&& apt autoremove -y \
&& apt autoclean -y 
#&& mkdir -p /cache /config /media \
#&& chmod 777 /cache /config /media 
COPY jellyfin_start.sh /usr/bin/
RUN chmod +x /usr/bin/jellyfin_start.sh
EXPOSE 8096
#VOLUME /cache /config /media

CMD [ "./usr/bin/jellyfin_start.sh" ] 
