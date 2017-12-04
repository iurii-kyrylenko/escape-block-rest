# ESCAPE BLOCK puzzle solver & REST API

## Escape Block Puzzle | Breadth First Search Algorithm | Haskell | REST API based on [Scotty](https://github.com/scotty-web/scotty) and [Aeson](https://github.com/bos/aeson)

## Demo
https://esc-block.herokuapp.com/

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
| Solution         | /backtrack        | get    | json     | `curl -X GET -d @test/01.json http://localhost:5000/backtrack`
| Number of steps  | /backtrack-length | get    | json     | `curl -X GET -d @test/01.json http://localhost:5000/backtrack-length`
| Number of states | /length           | get    | json     | `curl -X GET -d @test/01.json http://localhost:5000/length`

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
curl -X GET -d @test/01.json http://localhost:5000/backtrack
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
> heroku container:push web --app esc-block
> heroku ps:scale web=1 --app esc-block
> heroku apps:info esc-block
```

### TO DO:
Get port from env variable