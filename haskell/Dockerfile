FROM haskell:9.10 AS deps

ENV CABAL_DIR=/opt/cabal/

WORKDIR /src

# cabal.project.freeze should contain merged deps from
# all the projects (defined with *.cabal file)
COPY *.cabal cabal.project.freeze ./

RUN cabal update -v
RUN cabal build --only-dependencies --global

RUN chmod -R a+rwx ${CABAL_DIR}

