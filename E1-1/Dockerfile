FROM nginx:stable-alpine
LABEL org.opencontainers.image.title="codyssey-allinone-e1-1"
COPY site/ /usr/share/nginx/html/
EXPOSE 80
HEALTHCHECK --interval=5s --timeout=2s --retries=5 CMD wget -q -O /dev/null http://127.0.0.1/ || exit 1
