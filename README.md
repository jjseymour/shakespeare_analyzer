# Shakespeare Analyzer

Small Ruby on Rails Application built to display shakespearian characters' lines per play.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Installing

Clone down the repository:

```
git clone git@github.com:jjseymour/shakespeare_analyzer.git
```
cd into the file:

```
cd shakespeare_analyzer/
```

Bundle the ruby gems:

```
bundle install
```

### Run CLI

The CLI is accessed through `rake` commands. Run `rake -T` to see a list of the possible commands namespaced under `shakespeare` or look below for some examples.

To see the lines per character for Macbeth:

```
rake shakespeare:macbeth
```

For Hamlet:

```
rake shakespeare:hamlet
```

For any other Shakespeare play:

```
rake shakespeare:any[<Enter Play Name>]
```

For a list of plays you can enter into any:

```
rake shakespeare:list
```

**Note** - When using `any` be sure to remove all whitespace, comma's and apostrophe's from the play you're trying to check. 
Example: If you're searching for `A Midsummer Night's Dream` enter `rake shakespeare:any[AMidsummerNightsDream]`. Likewise, if you're searching for `Henry VII, Part 3` enter `rake shakespeare:any[Henryviipart3]`. Case does not matter.

Sample Output:

```
$ rake shakespeare:hamlet
  1495 Hamlet
  550 King Claudius
  355 Lord Polonius
  289 Horatio
  ...
```

### Run Development Server

Run the Rails server:

```
rails s
```

Navigate to `http://localhost:3000/`.

If everything is working you should see a simple input box and submit button. Enter a play into the input field (unlike the CLI whitespacing, commas and apostrophe's are available to use).

After entering the play name a chart with the play's characters' lines will appear. Otherwise, you will see an error saying the content could not be found and to try again. This just means what was entered was not recognized.

## Running the tests

Run:

```
$ rspec
```

## Live Version

[This is a live working version of the application.](https://shakespeareanalyzer.herokuapp.com/)

## Authors

* **JJ Seymour** - [GitHub](https://github.com/jjseymour)