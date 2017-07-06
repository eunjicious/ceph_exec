
radosgw-admin user create --uid="benchmark" --display-name="benchmark" | grep benchmark
radosgw-admin subuser create --uid="benchmark" --subuser=benchmark:swift --access=full | grep benchmark
radosgw-admin key create --subuser=benchmark:swift --key-type=swift --secret=guessme | grep benchmark
radosgw-admin user modify --uid=benchmark --max-buckets=0
