# ESCAPE BLOCK puzzle solver & REST API

## Escape Block Puzzle | Breadth First Search Algorithm | Haskell | REST API based on [Scotty](https://github.com/scotty-web/scotty) and [Aeson](https://github.com/bos/aeson)

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
        0   1   2   3   4   5
      ┌───┬───┬───┬───┬───┬───┐
   0  │ 1 │   │   │ 3 │   │ 5 │
      ├───┼───┼───┼───┼───┼───┤
   1  │ 1 │ a │ a │ 3 │   │ 5 │
      ├───┼───┼───┼───┼───┼───┤
   2  │ 1 │   │ b │ b │ 4 │    => escape gate
      ├───┼───┼───┼───┼───┼───┤
   3  │ c │ c │ c │   │ 4 │ 6 │
      ├───┼───┼───┼───┼───┼───┤
   4  │   │   │ 2 │   │ 4 │ 6 │
      ├───┼───┼───┼───┼───┼───┤
   5  │ d │ d │ 2 │ e │ e │   │
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
  [1,2,0,0,3,0,4,0,2,0,3],
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
  [0,4,1,0,2,2,0,0,3,0,4]
]
```
