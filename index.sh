   #!/bin/sh
   set -e
   if [ -d /src/.git ]; then
     git -C /src pull --ff-only
   else
     git clone --depth 1 "$REPO_URL" /src
   fi
   cd /src
   graphify extract . --code-only --force
   cp -r graphify-out/. /data/
   echo "indexed $(date -u)"
