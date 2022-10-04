FROM swift:5.7.0

RUN apt-get update
RUN apt-get install -y curl 

# Install node 18
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

# Enable node corepack and update pnpm
RUN npm install -g corepack
RUN corepack enable
RUN corepack prepare pnpm@latest --activate

WORKDIR /build/web-app
COPY ./packages/web-app .
RUN pnpm i
RUN pnpm build

WORKDIR /build/backend
COPY ./packages/backend . 
RUN Utilities/build.sh 

WORKDIR /app
RUN cp /build/backend/.build/debug/Run .
RUN mkdir Public
RUN cp -r /build/web-app/dist/* Public

CMD /app/Run serve --hostname 0.0.0.0

EXPOSE 8000

