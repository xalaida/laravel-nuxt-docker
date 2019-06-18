# Image
FROM node:12.4-alpine

# Install service dependencies
#RUN apk update
#RUN apk add --no-cache git
#RUN apk add libpq

# Set up work directory
WORKDIR /var/www/client

# TODO: npm install -g @vue/cli @vue/cli-init
# TODO: Check if project exists. If not - create the new one (nuxt create-project)

#RUN echo | ls
#RUN npm install
#RUN npm run build
#

ENV HOST 0.0.0.0

CMD ["sh", "-c", "yarn install && yarn dev"]
