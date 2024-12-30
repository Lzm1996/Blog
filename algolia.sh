APP_ID=1JWS888IAB
ADMIN_KEY=d01c8793b26f45de349c9fa49adaf09b

hugo
algolia import -s public/index.json -a ${APP_ID} -k ${ADMIN_KEY} -n index -b 999999
