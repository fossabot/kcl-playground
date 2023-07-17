FROM golang:1.17 as builder

ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct

WORKDIR /app

COPY . .

RUN GOOS=linux GOARCH=amd64 go build -o kcl-playground


FROM kcllang/kcl

WORKDIR /app

COPY --from=builder /app/kcl-playground .

EXPOSE 80

CMD ["/app/kcl-playground", "-deploy"]
