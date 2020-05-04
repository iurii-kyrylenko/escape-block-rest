# ESCAPE BLOCK puzzle solver & REST API

### Escape Block Puzzle | Breadth First Search Algorithm | Haskell | REST API based on [Scotty](https://github.com/scotty-web/scotty) and [Aeson](https://github.com/bos/aeson)

### [Demo](https://iurii-kyrylenko.github.io/escape-block-react)
 - > https://esc-block.herokuapp.com/
 - > `curl -X POST -d "{\"board\":[{\"dir\":\"h\",\"len\":2,\"row\":1},{\"dir\":\"h\",\"len\":2,\"row\":2},{\"dir\":\"h\",\"len\":3,\"row\":3},{\"dir\":\"h\",\"len\":2,\"row\":5},{\"dir\":\"h\",\"len\":2,\"row\":5},{\"dir\":\"v\",\"len\":3,\"row\":0},{\"dir\":\"v\",\"len\":2,\"row\":2},{\"dir\":\"v\",\"len\":2,\"row\":3},{\"dir\":\"v\",\"len\":3,\"row\":4},{\"dir\":\"v\",\"len\":2,\"row\":5},{\"dir\":\"v\",\"len\":2,\"row\":5}],\"state\":[1,2,0,0,3,0,4,0,2,0,3],\"target\":{\"index\":1,\"position\":4}}" https://esc-block.herokuapp.com/backtrack`
 - > `curl -X POST -d "{\"board\":[{\"dir\":\"h\",\"len\":2,\"row\":1},{\"dir\":\"h\",\"len\":2,\"row\":2},{\"dir\":\"h\",\"len\":3,\"row\":3},{\"dir\":\"h\",\"len\":2,\"row\":5},{\"dir\":\"h\",\"len\":2,\"row\":5},{\"dir\":\"v\",\"len\":3,\"row\":0},{\"dir\":\"v\",\"len\":2,\"row\":2},{\"dir\":\"v\",\"len\":2,\"row\":3},{\"dir\":\"v\",\"len\":3,\"row\":4},{\"dir\":\"v\",\"len\":2,\"row\":5},{\"dir\":\"v\",\"len\":2,\"row\":5}],\"state\":[1,2,0,0,3,0,4,0,2,0,3],\"target\":{\"index\":1,\"position\":4}}" https://esc-block.herokuapp.com/backtrack-length`
 - > `curl -X POST -d "{\"board\":[{\"dir\":\"h\",\"len\":2,\"row\":1},{\"dir\":\"h\",\"len\":2,\"row\":2},{\"dir\":\"h\",\"len\":3,\"row\":3},{\"dir\":\"h\",\"len\":2,\"row\":5},{\"dir\":\"h\",\"len\":2,\"row\":5},{\"dir\":\"v\",\"len\":3,\"row\":0},{\"dir\":\"v\",\"len\":2,\"row\":2},{\"dir\":\"v\",\"len\":2,\"row\":3},{\"dir\":\"v\",\"len\":3,\"row\":4},{\"dir\":\"v\",\"len\":2,\"row\":5},{\"dir\":\"v\",\"len\":2,\"row\":5}],\"state\":[1,2,0,0,3,0,4,0,2,0,3],\"target\":{\"index\":1,\"position\":4}}" https://esc-block.herokuapp.com/length`


### Containerize haskell stack

#### Build docker image for haskell stack
> docker build -t hstack .

#### Run container from the image:
> cd \<shared dir\>

> docker run --name hstack -v $(pwd):/mnt -p 5000:5000 -it hstack bash


### Work inside container

#### Go to project directory
> cd /mnt/\<project dir\>

#### Build project
> stack build

#### Run server
> stack exec escape-block-rest-exe

#### Run tests
> stack test

#### Run REPL
> stack ghci

#### Copy executable to prod
> cp $(stack exec -- which escape-block-rest-exe) prod/


### Deploy on Heroku
> cd prod/

> heroku container:login

> heroku container:push web --app esc-block

> heroku container:release web --app esc-block


### Endpoints

| Description      | Path              | Method | Req body | Example
|:-----------------|:------------------|:-------|:--------:|:-
| Information      | /                 | get    | -        | `curl https://esc-block.herokuapp.com/`
| Solution         | /backtrack        | post   | json     | `curl -X POST -d @test/01.json https://esc-block.herokuapp.com/backtrack`
| Number of steps  | /backtrack-length | post   | json     | `curl -X POST -d @test/01.json https://esc-block.herokuapp.com/backtrack-length`
| Number of states | /length           | post   | json     | `curl -X POST -d @test/01.json https://esc-block.herokuapp.com/length`

### Board examples

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
