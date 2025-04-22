#!/bin/bash

echo "==> Registrando agente"

./config.sh --unattended \
  --url "$AZP_URL" \
  --auth pat \
  --token "$AZP_TOKEN" \
  --pool "$AZP_POOL" \
  --agent "${AZP_AGENT_NAME:-$(hostname)}" \
  --replace \
  --acceptTeeEula \
  --work "_work"

trap 'echo "Removendo agente..."; ./config.sh remove --unattended --auth pat --token $AZP_TOKEN; exit 0' SIGINT SIGTERM

./run.sh &
wait $!
