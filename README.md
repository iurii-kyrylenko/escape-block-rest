# ESCAPE BLOCK puzzle solver & REST API

## Escape Block Puzzle | Breadth First Search Algorithm | Haskell | REST API based on [Scotty](https://github.com/scotty-web/scotty) and [Aeson](https://github.com/bos/aeson)

## Demo
 - > https://esc-block.herokuapp.com/
 - > `curl -X POST -d "{\"board\":[{\"dir\":\"h\",\"len\":2,\"row\":1},{\"dir\":\"h\",\"len\":2,\"row\":2},{\"dir\":\"h\",\"len\":3,\"row\":3},{\"dir\":\"h\",\"len\":2,\"row\":5},{\"dir\":\"h\",\"len\":2,\"row\":5},{\"dir\":\"v\",\"len\":3,\"row\":0},{\"dir\":\"v\",\"len\":2,\"row\":2},{\"dir\":\"v\",\"len\":2,\"row\":3},{\"dir\":\"v\",\"len\":3,\"row\":4},{\"dir\":\"v\",\"len\":2,\"row\":5},{\"dir\":\"v\",\"len\":2,\"row\":5}],\"state\":[1,2,0,0,3,0,4,0,2,0,3],\"target\":{\"index\":1,\"position\":4}}" https://esc-block.herokuapp.com/backtrack`
 - > `curl -X POST -d "{\"board\":[{\"dir\":\"h\",\"len\":2,\"row\":1},{\"dir\":\"h\",\"len\":2,\"row\":2},{\"dir\":\"h\",\"len\":3,\"row\":3},{\"dir\":\"h\",\"len\":2,\"row\":5},{\"dir\":\"h\",\"len\":2,\"row\":5},{\"dir\":\"v\",\"len\":3,\"row\":0},{\"dir\":\"v\",\"len\":2,\"row\":2},{\"dir\":\"v\",\"len\":2,\"row\":3},{\"dir\":\"v\",\"len\":3,\"row\":4},{\"dir\":\"v\",\"len\":2,\"row\":5},{\"dir\":\"v\",\"len\":2,\"row\":5}],\"state\":[1,2,0,0,3,0,4,0,2,0,3],\"target\":{\"index\":1,\"position\":4}}" https://esc-block.herokuapp.com/backtrack-length`
 - > `curl -X POST -d "{\"board\":[{\"dir\":\"h\",\"len\":2,\"row\":1},{\"dir\":\"h\",\"len\":2,\"row\":2},{\"dir\":\"h\",\"len\":3,\"row\":3},{\"dir\":\"h\",\"len\":2,\"row\":5},{\"dir\":\"h\",\"len\":2,\"row\":5},{\"dir\":\"v\",\"len\":3,\"row\":0},{\"dir\":\"v\",\"len\":2,\"row\":2},{\"dir\":\"v\",\"len\":2,\"row\":3},{\"dir\":\"v\",\"len\":3,\"row\":4},{\"dir\":\"v\",\"len\":2,\"row\":5},{\"dir\":\"v\",\"len\":2,\"row\":5}],\"state\":[1,2,0,0,3,0,4,0,2,0,3],\"target\":{\"index\":1,\"position\":4}}" https://esc-block.herokuapp.com/length`

### Build project
> stack setup

> stack build

### Run server
> stack exec escape-block-rest-exe

### Run tests
> stack test

### Run REPL
> stack ghci

### Endpoints

| Description      | Path              | Method | Req body | Example
|:-----------------|:------------------|:-------|:--------:|:-
| Information      | /                 | get    | -        | `curl http://localhost:5000/`
| Solution         | /backtrack        | post   | json     | `curl -X POST -d @test/01.json http://localhost:5000/backtrack`
| Number of steps  | /backtrack-length | post   | json     | `curl -X POST -d @test/01.json http://localhost:5000/backtrack-length`
| Number of states | /length           | post   | json     | `curl -X POST -d @test/01.json http://localhost:5000/length`

### Board example

```
start: [1,2,0,0,3,0,4,0,2,0,3]
        0   1   2   3   4   5
      ┌───┬───┬───┬───┬───┬───┐
   0  │ 1 │   │   │ 3 │   │ 5 │
      ├───┼───┼───┼───┼───┼───┤
   1  │ 1 │ a │ a │ 3 │   │ 5 │
      ├───┼───┼───┼───┼───┼───┤
   2  │ 1 │   │ b │ b │ 4 │    => escape
      ├───┼───┼───┼───┼───┼───┤
   3  │ c │ c │ c │   │ 4 │ 6 │
      ├───┼───┼───┼───┼───┼───┤
   4  │   │   │ 2 │   │ 4 │ 6 │
      ├───┼───┼───┼───┼───┼───┤
   5  │ d │ d │ 2 │ e │ e │   │
      └───┴───┴───┴───┴───┴───┘

 finish: [0,4,1,0,2,2,0,0,3,0,4]
        0   1   2   3   4   5
      ┌───┬───┬───┬───┬───┬───┐
   0  │   │   │ 2 │ 3 │   │   │
      ├───┼───┼───┼───┼───┼───┤
   1  │ a │ a │ 2 │ 3 │   │   │
      ├───┼───┼───┼───┼───┼───┤
   2  │ 1 │   │   │   │ b │ b  => escape
      ├───┼───┼───┼───┼───┼───┤
   3  │ 1 │ c │ c │ c │ 4 │   │
      ├───┼───┼───┼───┼───┼───┤
   4  │ 1 │   │   │   │ 4 │ 6 │
      ├───┼───┼───┼───┼───┼───┤
   5  │ d │ d │ e │ e │ 4 │ 6 │
      └───┴───┴───┴───┴───┴───┘
```

### Request body (file test/01.json)
``` json
{
  "board": [
    { "dir": "h", "len": 2, "row": 1 },
    { "dir": "h", "len": 2, "row": 2 },
    { "dir": "h", "len": 3, "row": 3 },
    { "dir": "h", "len": 2, "row": 5 },
    { "dir": "h", "len": 2, "row": 5 },
    { "dir": "v", "len": 3, "row": 0 },
    { "dir": "v", "len": 2, "row": 2 },
    { "dir": "v", "len": 2, "row": 3 },
    { "dir": "v", "len": 3, "row": 4 },
    { "dir": "v", "len": 2, "row": 5 },
    { "dir": "v", "len": 2, "row": 5 }
  ],
  "state": [1, 2, 0, 0, 3, 0, 4, 0 ,2, 0, 3],
  "target": { "index": 1, "position": 4 }
}
```

### Request
```
curl -X POST -d @test/01.json http://localhost:5000/backtrack
```

### Response
```
[
  [1,2,0,0,3,0,4,0,2,0,3], // start state
  [1,2,0,0,3,0,4,0,0,0,3],
  [1,2,0,0,3,0,4,0,0,0,4],
  [1,2,3,0,3,0,4,0,0,0,4],
  [1,2,3,0,3,0,3,0,0,0,4],
  [1,2,3,1,3,0,3,0,0,0,4],
  [1,2,3,1,3,3,3,0,0,0,4],
  [0,2,3,1,3,3,3,0,0,0,4],
  [0,0,3,1,3,3,3,0,0,0,4],
  [0,0,3,1,3,3,0,0,0,0,4],
  [0,0,1,1,3,3,0,0,0,0,4],
  [0,1,1,1,3,3,0,0,0,0,4],
  [0,1,1,1,3,2,0,0,0,0,4],
  [0,1,1,0,3,2,0,0,0,0,4],
  [0,1,1,0,2,2,0,0,0,0,4],
  [0,1,1,0,2,2,0,0,3,0,4],
  [0,4,1,0,2,2,0,0,3,0,4]  // finish state
]
```

### Build docker image (esc-block)
> docker build -t esc-block .

### Start new container from the esc-block image
> docker run -p 5000:5000 -d --name esc-block esc-block

### Copy executable from container to the prod direcory
> docker cp esc-block:/opt/escape-block-rest/bin/escape-block-rest-exe ./prod/escape-block-rest-exe

### Build production docker image (esc-block-prod)
> cd prod

> docker build -t esc-block-prod .

### Start new container from the esc-block-prod image
> docker run -p 5000:5000 -d --name esc-block-prod esc-block-prod

### Deploy on Heroku (https://arow.info/blog/posts/2017-03-30-servant-on-heroku.html)
```
> heroku plugins:install heroku-container-registry
> heroku login
> heroku apps:create esc-block
> heroku apps:info esc-block
> heroku container
> heroku container:login
> cd prod
> heroku container:push web --app esc-block
> heroku ps:scale web=1 --app esc-block
> heroku apps:info esc-block
```
### Dev cycle
- make changes and test on dev host
- run container with dev environment:
  - docker run -d --name esc-block esc-block
- stop container:
  - docker stop esc-block
- copy changes from dev host to container, e.g.:
  - docker cp ./escape-block-rest.cabal esc-block:/opt/escape-block-rest/src/escape-block-rest.cabal
  - docker cp ./src/Server.hs esc-block:/opt/escape-block-rest/src/src/Server.hs
- start container:
  - docker start esc-block
- go inside container:
  - docker exec -it esc-block bash
- build app inside container: stack build
- install app binary inside container:
  - stack --local-bin-path /opt/escape-block-rest/bin install
- exit container
- copy binary from container to the prod directory:
  - docker cp esc-block:/opt/escape-block-rest/bin/escape-block-rest-exe ./prod/escape-block-rest-exe
- build prod image (optionally):
  - cd prod/
  - docker build -t esc-block-prod .
- deploy to heroku:
  - cd prod/
  - heroku container:login
  - heroku container:push web --app esc-block
