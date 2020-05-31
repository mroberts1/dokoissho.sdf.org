---
title: Testing Emacs extensions with guard and ert-runner
date:  2020-05-16
---

I use [ert-runner](https://github.com/rejeep/ert-runner.el) for running unit
tests in my Emacs packages. It's a handy way to run all unit tests in a single
go, and it works nicely with [Cask](https://github.com/cask/cask) to make
repeatable runs easier.

One thing I missed was automatic testing when files are saved. I use
[Guard](https://github.com/guard/guard) when developing Rails projects and
wanted to hook it into my Emacs setup.

The following `Guardfile` uses `guard-shell` to run ert-runner whenever an `.el`
file is modified. I added a workaround for ignoring flycheck files, which Emacs
saves when a file is modified and can trigger a huge amount of builds.

```ruby
guard :shell do
  watch (/(.*)\.el$/) do |file|
    # Ugly fix but I couldn't spend time messing around with regex.
    unless file[0].to_s.include? 'flycheck'
      if system('cask exec ert-runner')
        n 'Tests succeeded', 'ERT', :success
      else
        n 'Tests failed', 'ERT', :failed
      end

      ''
    end
  end
end
```

Using `:success` and `:failed` with the process result also means Guard's
notifier works correctly, so it's possible to use the Emacs notifier to get
realtime test pass & fail colours whenever a file is saved. Pretty neat!
