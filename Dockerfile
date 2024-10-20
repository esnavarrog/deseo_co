# Usa una imagen base de Ruby
FROM ruby:3.1

# Instala dependencias del sistema
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm

# Instala npm y yarn
RUN npm install -g npm
RUN npm install -g yarn

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo Gemfile y Gemfile.lock al contenedor
COPY Gemfile* ./

RUN gem install bundler -v 2.4.6

# Instala las gemas necesarias
RUN bundle install

# Copia toda la aplicación al contenedor
COPY . .

# Instala las dependencias de JavaScript
RUN yarn install

ARG DATABASE_HOST
ARG DATABASE_DATABASE
ARG DATABASE_URL
ARG DATABASE_PORT
ARG DATABASE_USERNAME
ARG RAILS_ENV
ARG AWS_REGION
ARG AWS_BUCKET
ARG AWS_ENDPOINT

# Precompila los activos (CSS, JS, etc.) para producción
RUN bundle exec rails assets:precompile

RUN bundle exec rails db:create
RUN bundle exec rails db:migrate

# Exponer el puerto que la aplicación va a usar
EXPOSE 80

# Comando para iniciar la aplicación
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]