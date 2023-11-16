ARG NVIDIA_DRIVER_VERSION
ARG OS_RELEASE
FROM nvcr.io/nvidia/driver:${NVIDIA_DRIVER_VERSION}-rhel${OS_RELEASE}

ARG RPM_BASE_URL
RUN  dnf mark install gcc binutils cpp glibc-devel glibc-headers isl libgomp libmpc libxcrypt-devel && \
 echo "${RPM_BASE_URL}" > /rpm-base-url

COPY nvidia-driver /usr/local/bin

ENTRYPOINT ["nvidia-driver", "init"]

