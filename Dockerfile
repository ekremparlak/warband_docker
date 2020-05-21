FROM ubuntu:18.04
ENV MOD bt
ENV SERVER_NAME docker
ENV WELCOME_MESSAGE welcome
ENV MAX_PLAYER 32
ENV BOTS_VOTABLE 0
ENV SET_MAP multi_scene_1
ENV TEAM_POINT_LIMIT 10
ENV PORT 7240
ENV STEAM_PORT 7241
ENV FRIENDLY_FIRE 1
RUN dpkg --add-architecture i386 &&\
    apt update &&\
    apt install -y wine32 wget unzip &&\
    wget http://download3.taleworlds.com/mb_warband_dedicated_1174.zip -P /tmp &&\
    unzip /tmp/mb_war* -d /tmp &&\
    mv /tmp/mb_warband_dedicated_1174/* /warband &&\
    apt purge -y wget unzip &&\
    rm -r /tmp/*
WORKDIR /warband/
EXPOSE 7240 7241 7240/udp
COPY docker-entrypoint /usr/bin/docker-entrypoint
ENTRYPOINT ["docker-entrypoint"]
CMD wineconsole --backend=curses mb_warband_dedicated.exe -r docker.txt
