file(GLOB ENGINE_SOURCES "*.cpp")
add_subdirectory(transport)

add_library(transfer_engine ${ENGINE_SOURCES} $<TARGET_OBJECTS:transport>)

add_compile_definitions(transfer_engine PUBLIC MOONCAKE_USE_ETCD)
if (USE_STATIC_ETCD_CPP_API)
  target_link_libraries(transfer_engine PUBLIC etcd-cpp-api-core protobuf grpc++ grpc)
else()
  target_link_libraries(transfer_engine PUBLIC etcd-cpp-api)
endif()
target_link_libraries(transfer_engine PUBLIC transport rdma_transport ibverbs glog gflags pthread jsoncpp numa)

if (USE_CUDA)  
  target_include_directories(transfer_engine PRIVATE /usr/local/cuda/include)
  target_link_libraries(transfer_engine PUBLIC nvmeof_transport cuda cufile cudart rt)
endif()

