FROM oraclelinux:7-slim

RUN yum -y install oraclelinux-developer-release-el7 oracle-instantclient-release-el7 && \
    yum clean all && \
    yum -y install python3 \
                   python3-libs \
                   python3-pip \
                   python3-setuptools \
                   python36-cx_Oracle && \
    pip3 install flask && \
    rm -rf /var/cache/yum/*

COPY . .
ARG db_user
ARG db_password
ARG db_connection

CMD /bin/python3 transaction_interface.py $db_user $db_password $db_connection
