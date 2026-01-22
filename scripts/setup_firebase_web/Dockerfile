FROM google/cloud-sdk:slim

WORKDIR /workspace

COPY cors.json cors.json
COPY apply_storage_cors.sh apply_storage_cors.sh

RUN chmod +x apply_storage_cors.sh

ENTRYPOINT ["./apply_storage_cors.sh"]
