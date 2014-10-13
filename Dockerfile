FROM x110dc/base
MAINTAINER Daniel Craigmile
ENV DEBIAN_FRONTEND noninteractive

# Download Rundeck
ADD http://download.rundeck.org/deb/rundeck-2.1.2-1-GA.deb /tmp/rundeck.deb

# Add supervisord services
ADD ./supervisor /etc/supervisor

# Add rundeck to sudoers
ADD ./sudoers.d/rundeck /etc/sudoers.d/

# Add files to cron.d
ADD ./cron.d /etc/

# Add the install commands
ADD ./install.sh /

ADD ./profile /

# Change Rundeck admin from default to CH4NGE_Me
ENV RDPASS RDPASS

# Change this to your hostname (used for generating URLs):
ENV MYHOST MYHOST

# From address when sending email:
ENV MAILFROM MAILFROM

# Run the installation script
RUN /install.sh
RUN chown rundeck /tmp/rundeck

# Start the services with supervisord
CMD ["/usr/bin/supervisord", "--nodaemon"]

EXPOSE 4440 22
