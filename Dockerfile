# lovewinner-jellyfin
FROM ubuntu:18.04
RUN apt update \
&& apt install -y libc-bin ffmpeg gnupg wget apt-transport-https \
&& wget -O - https://repo.jellyfin.org/jellyfin_team.gpg.key | apt-key add - \
&& echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release ) $( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release ) main" | tee /etc/apt/sources.list.d/jellyfin.list \
&& apt update \
&& wget https://repo.jellyfin.org/releases/server/ubuntu/versions/10.4.3/jellyfin_10.4.3-1_amd64.deb
RUN apt install jellyfin-ffmpeg -y
RUN dpkg -i jellyfin_10.4.3-1_amd64.deb


#&& wget -O - https://repo.jellyfin.org/jellyfin_team.gpg.key | apt-key add - \
#&& echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/$( awk -F'=' '/^ID=/{ print $NF }' /etc/os-release ) $( awk -F'=' '/^VERSION_CODENAME=/{ print $NF }' /etc/os-release ) main" | tee /etc/apt/sources.list.d/jellyfin.list \

#&& apt -d -y install jellyfin=10.4.3

RUN mkdir -p /jellyfin /media /cache \
&& chmod 777 /jellyfin /media /cache
VOLUME /jellyfin /media

#RUN apt install -y jellyfin=10.4.3 \
RUN apt remove wget -y \
&& apt autoremove -y \
&& apt autoclean -y

COPY jellyfin_start.sh /usr/bin/
RUN chmod +x /usr/bin/jellyfin_start.sh
EXPOSE 8096

CMD [ "./usr/bin/jellyfin_start.sh" ]

























