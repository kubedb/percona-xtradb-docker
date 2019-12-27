FROM busybox as tester
COPY dockerdir dockerdir
RUN chown -R 1001:1001 /dockerdir/etc/mysql/ && ls -la /dockerdir/etc/mysql

FROM percona/percona-xtradb-cluster:5.7
COPY --from=tester /dockerdir /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld"]
