# Bulma

You can use this package to install Bulma in your Phoenix project without needing to rely on Node or NPM.
It works by leveraging the [DartSass](https://github.com/cargosense/dart_sass) package.

### Installing DartSass

DartSass is an Elixir library that works similar to Esbuild and does actual Sass processing.

#### Install DartSass in `mix.exs`

[https://github.com/CargoSense/dart_sass](`dart_sass`) Github repo.

Add the following line to your `deps()` section:

```elixir
{:dart_sass, "~> 0.7", runtime: Mix.env() == :dev}
```

Then configure which version of dart-sass to use by adding this to your `config/config.exs` file.

You will probably need to check on [NPM](https://www.npmjs.com/package/sass) to get the latest version number.

```elixir
config :dart_sass,
version: "1.79.3",
default: [
args: ~w(css:../priv/static/assets),
cd: Path.expand("../assets", __DIR__)
]
```

Run `mix deps.get` then install Sass:

```sh
mix sass.install
```

### Rename assets/css/app.css

Rename the existing `assets/css/app.css` to `assets/css/app.scss`.

### Update app.js in assets/js/

Comment out or delete this line:

```javascript
// import "../css/app.css";
```

For development, enable watch mode by changing your watchers configuration for `MyApp.Endpoint` in `config/dev.exs`.

```elixir
watchers: [
  # Start the esbuild watcher by calling Esbuild.install_and_run(:default, args)
  esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
  sass: {
    DartSass,
    :install_and_run,
    [:default, ~w(--embed-source-map --source-map-urls=absolute --watch)]
  }
]
```

Finally, back in your mix.exs, make sure you have an assets.deploy alias for deployments, which will also use the --style=compressed option:

```elixir
"assets.deploy": [
  "esbuild default --minify",
  "sass default --no-source-map --style=compressed",
  "phx.digest"
]
```

## Installing Bulma

There are effectively three different ways to install Bulma.

### Method 1: Using a CDN

The first way to install Bulma is to just include the `bulma.min.css` file from a CDN like [JSDeliver](https://www.jsdelivr.com/package/npm/bulma). With this approach, you would not be able to customize Bulma at all.

### Method 2: Using Node and npm

The second way is to install `node` and `npm`, create a `package.json` file, add `bulma` to it, then tell `dart-sass` where the Sass files were installed. However, this makes our app depend on `node` again.

### Method 3: Using Hex Package

The third way is to install the [Bulma Hex package](https://github.com/kevinlang/bulma-elixir). This approach includes all of the Bulma Sass files in a convenient package that can easily be added to your Mix project. To do this:

* Go to your `mix.exs` file and add it:

```elixir
{:bulma, "1.0.2"}
```

* Update your `dart-sass` config to include it as a load path:

```elixir
config :dart_sass,
  version: "1.79.3",
  default: [
    args: ~w(--load-path=../deps/bulma css:../priv/static/assets),
    cd: Path.expand("../assets", __DIR__)
  ]
```

* Import Bulma into your root style sheet, `assets/css/app.scss`:

```scss
@import "bulma";
```

## Using Bulma and CSS Cleanup

Now that we have Bulma installed, let's do some minimal changes to the generated app. First, get rid of the `assets/css/phoenix.css` file.

Then replace the content of the `assets/css/app.scss` file with:

```scss
// override bulma variables before import to customize
$phoenix-orange: #f05423;
$primary: $phoenix-orange;

@import "bulma";

// add our own styles after the Bulma import
```

Here we are overriding the `$primary` variable outlined in the [Bulma docs](https://bulma.io/documentation/customize/variables/) to our `$phoenix-orange` color.

## Updating HTML Files

Let's update some of our HTML files so we can show Bulma in action. First, remove the header in `root.html.heex`.

Then let's make a nice big Bulma hero section on our main `index.html` page:

```html
<section class="hero is-primary is-fullheight">
  <div class="hero-body">
    <div class="container has-text-centered">
      <p class="title">Phoenix</p>
      <p class="subtitle">With Bulma!</p>
    </div>
  </div>
</section>
```

The version of this package exactly matches the version of Bulma that it contains. As of now, it has version `1.0.2`.
