TEST_DIR=$1
# etcd default listens on port 2379
# etcd --listen-client-urls http://0.0.0.0:2379 --advertise-client-urls http://10.0.0.1:2379 &
pushd $TEST_DIR/mooncake-transfer-engine/tests
export MC_GID_INDEX=1 && ./rdma_transport_test --mode=target  --metadata_server=127.0.0.1:2379 --local_server_name=127.0.0.2:14345 --device_name=erdma_0 &
export MC_GID_INDEX=1 && ./rdma_transport_test --metadata_server=127.0.0.1:2379 --segment_id=127.0.0.2:14345 --local_server_name=127.0.0.3:14346 --device_name=erdma_1
export MC_GID_INDEX=1 && ./rdma_transport_test2 --metadata_server=127.0.0.1:2379 --segment_id=127.0.0.2:14345 --local_server_name=127.0.0.3:14346 --device_name=erdma_1
kill $(pidof rdma_transport_test)
popd