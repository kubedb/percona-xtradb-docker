FROM percona/percona-xtradb-cluster:5.7
COPY on-start.sh /
COPY peer-finder /usr/local/bin/
COPY cluster-check.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld"]
