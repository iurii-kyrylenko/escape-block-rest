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

### Example of request body

```
board ┌───┬───┬───┬───┬───┬───┐
      │ 1 │   │   │ 3 │   │ 5 │
      ├───┼───┼───┼───┼───┼───┤
      │ 1 │ a │ a │ 3 │   │ 5 │
      ├───┼───┼───┼───┼───┼───┤
      │ 1 │   │ b │ b │ 4 │   │
      ├───┼───┼───┼───┼───┼───┤
      │ c │ c │ c │   │ 4 │ 6 │
      ├───┼───┼───┼───┼───┼───┤
      │   │   │ 2 │   │ 4 │ 6 │
      ├───┼───┼───┼───┼───┼───┤
      │ d │ d │ 2 │ e │ e │   │
      └───┴───┴───┴───┴───┴───┘
```
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
