FROM debian:latest

RUN echo '\
Acquire::Retries "100";\
Acquire::https::Timeout "240";\
Acquire::http::Timeout "240";\
APT::Get::Assume-Yes "true";\
APT::Install-Recommends "false";\
APT::Install-Suggests "false";\
Debug::Acquire::https "true";\
' > /etc/apt/apt.conf.d/99custom

RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \ 
    apt-get update -q && apt-get install -y texlive-full gnuplot 
