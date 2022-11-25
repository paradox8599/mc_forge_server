FROM openjdk:15

ENV FORGE_INSTALLER_ADDR=https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.2.34/forge-1.16.5-36.2.34-installer.jar
ENV FORGE_INSTALLER_NAME=forge-1.16.5-36.2.34-installer.jar
ENV SERVER_FILE_NAME=forge-1.16.5-36.2.34.jar

# RUN microdnf update
RUN microdnf install tmux

WORKDIR /root/mc

# # Download Forge installer
RUN curl $FORGE_INSTALLER_ADDR -o $FORGE_INSTALLER_NAME
# # Install mc forge server
RUN java -jar $FORGE_INSTALLER_NAME --installServer
# # Remove installer
RUN rm forge-*-installer*

# # Agree EULA
RUN echo "eula=true" > eula.txt

WORKDIR /root

# bashrc
RUN echo 'alias tn="tmux new -s default"' >> .bashrc
RUN echo 'alias ta="tmux a -t default"' >> .bashrc
RUN echo 'alias t="ta || tn"' >> .bashrc
