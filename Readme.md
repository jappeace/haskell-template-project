[![https://jappieklooster.nl](https://img.shields.io/badge/blog-jappieklooster.nl-lightgrey)](https://jappieklooster.nl/tag/haskell.html)
[![Jappiejappie](https://img.shields.io/badge/twitch.tv-jappiejappie-purple?logo=twitch)](https://www.twitch.tv/jappiejappie)
[![Jappiejappie](https://img.shields.io/badge/youtube-jappieklooster-red?logo=youtube)](https://www.youtube.com/channel/UCQxmXSQEYyCeBC6urMWRPVw)
[![Build status](https://img.shields.io/travis/jappeace/haskell-template-project)](https://travis-ci.org/jappeace/haskell-template-project/builds/)
[![Githbu actions build status](https://img.shields.io/github/workflow/status/jappeace/haskell-template-project/Test)](https://github.com/jappeace/haskell-template-project/actions)
[![Jappiejappie](https://img.shields.io/badge/discord-jappiejappie-black?logo=discord)](https://discord.gg/Hp4agqy)

> The eye that looks ahead to the safe course is closed forever.

Haskell project template.

Set up cabal within a nix shell.
If you like nix this is a good way of doing haskell development.

similar to: https://github.com/monadfix/nix-cabal
except this has a makefile and ghcid.
We also make aggressive use of [pinning](https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs)
ensuring project builds for ever (theoretically).

Comes with:
+ [GHCID](https://jappieklooster.nl/ghcid-for-multi-package-projects.html)
+ a nix shell, meaning somewhat platform independence.
  + which is pinned by default
+ A couple of handy make commands.
+ Starting haskell files, assuming we put practically all code in library
+ Working HSpec, The detection macro will pickup any file ending with Spec.hs

## Usage

### Modifying for your project
Assuming the name of your new project is `new-project`.

```
git clone git@github.com:jappeace/haskell-template-project.git new-project
cd new-project
```

+ [ ] Edit package.yaml,
    + [ ] find and replace template with `new-project`
    + [ ] Update copyright
    + [ ] Update github
+ [ ] Run `make hpack` to update cabal files
+ [ ] remove template.cabal
+ [ ] Edit Changelog.md
  + [ ] replace template with `new-project`
  + [ ] Also describe your version 1.0.0 release.
+ [ ] Edit default.nix, replace template with `new-project`.
+ [ ] Edit copyright in LICENSE
+ [ ] Edit `nix/bundle.nix` to point to the executable

#### Reconfigure remotes
```
git remote add template git@github.com:jappeace/haskell-template-project.git
git remote set-url origin git@github.com:YOUR-ORG-OR-USER-NAME/new-project.git
```

We can get template updates like this if we want to by doing `git pull template`.
There will be a large amount of conflicts, but the merge commit should solve them permanently.

#### Readme

+ [ ] Select desired badges. 
  + [ ] Point build badges to right project
+ [ ] Give short project description.
+ [ ] Add new quote suited for the project.
  For example for [fakedata-quickcheck](https://github.com/fakedata-haskell/fakedata-quickcheck#readme)
  I used Kant because
  he dealt with the question "what is truth" a lot.
+ [ ] Truncate this checklist
+ [ ] Truncate motivation for using  this template

### Tools
Enter the nix shell.
```
nix-shell
```
You can checkout the makefile to see what's available:
```
cat makefile
```

### Running
```
make run
```

### Fast filewatch which runs tests
```
make ghcid
```
