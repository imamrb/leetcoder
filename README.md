<p align="center">
  <img src="./spec/cassettes/leetcoder.png" alt="leetcoder"/>
</p>

A Ruby [LeetCode](https://www.leetcode.com) Client to help you download all your accepted leetcode submissions with problem description. Leetcode cookie is used for authentication.

- [Leetcoder](#)
  - [Screenshot](#screenshot)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Run Through Docker](#run-through-docker)
    - [Run Through Github Action](#run-through-github-action)
  - [Why this Exist](#why-this-exist)
  - [Author](#author)

## Screenshot

![screenshot](./spec/cassettes/leetcoder_screenshot.png)

## Requirements
  - Ruby 3.1.1
  - Desire to automate the boring stuff

## Installation

```bash
gem install leetcoder
```

## Usage

After installing the gem, follow these steps:

 - Sign in to [leetcode.com](www.leetcode.com) from any browser
 - Copy the `cookie` value of a leetcode request using the browser network tab

   ![leetcode cookie](/spec/cassettes/leetcode%20cookie.jpg)

 - Save your cookie by running `leetcoder --cookie` from terminal
 - Run `leetcoder --download` to start downloading.

```bash
leetcoder --cookie                    # prompt you to save the leetcode cookie
leetcoder --download all --folder ./  # download all accepted submissions in current folder
```

```bash
> leetcoder --help

Usage: leetcoder [command]

* indicates default value

commands:
    -d, --download [TYPE]            Specify number of accepted submission to download per problem (*one, all)
    -c, --cookie                     Input Leetcode Cookie
    -f, --folder FOLDER_PATH         Specify download folder location (* <current_directory>/leetcode)
    -v, --version                    Show version
    -h, --help                       Show available commands
```

## Run through Github Action

This is the most convenient and recommended way to backup your submissions using the app.

- Create a new repository in github

- Set your leetcode cookie under `Repository Secrets` with name `LEETCODE_COOKIE`

  ```text
  https://github.com/<username>/<repo_name>/settings/secrets/actions
  ```
- Download and commit this [leetcoder.yml](./leetcoder.yml) file inside `.github/wrokflows/` folder in your repo.

This will automatically download and commit the downloaded submissions every week.
You can customize the frequency using the cron syntax inside the yml file.

**Example:** https://github.com/imamrb/leetcode-solutions

## Run through Docker

If you don't have ruby setup locally, you can run the app through docker.

- Open terminal and cd to the directory where you want to download the submissions.

- Run

```bash
docker run -it -v `pwd`:`pwd` -w `pwd` imamrb/leetcoder:latest
```

This will run the [leetcoder docker image](https://hub.docker.com/repository/docker/imamrb/leetcoder) and mount your current directory to container working directory. You can now continue using the app from here.

The downloaded submissions will be saved to your current directory.

**Caveat:** You will need to provide the leetcode cookie every time since the stored configuration will be lost when you exit from the container.

## Why this exist

Initially, I built a simple script to backup my submissions as I did not find anything similar written in Ruby. Later decided to release this as a gem since it might be useful for others. Also it was fun to built something for own use with Ruby. <3

If you find this useful, give it a star. Feel free to create an issue if something doesn't work for you.

## Author

Imam Hossain <br>
Email: imam.swe@gmail.com
