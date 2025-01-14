FROM nimlang/nim:latest as build-image

WORKDIR /work
COPY ./ ./

RUN nimble build --passL:-static -d:release
RUN mv main bootstrap
RUN chmod +x bootstrap

FROM public.ecr.aws/lambda/provided:latest

COPY --from=build-image /work/bootstrap /var/runtime/

CMD ["dummyHandler"]
