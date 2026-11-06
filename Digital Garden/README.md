# Quartz v5

> “[One] who works with the door open gets all kinds of interruptions, but [they] also occasionally gets clues as to what the world is and what might be important.” — Richard Hamming

Quartz is a set of tools that helps you publish your [digital garden](https://jzhao.xyz/posts/networked-thought) and notes as a website for free.

🔗 Read the documentation and get started: https://quartz.jzhao.xyz/

[Join the Discord Community](https://discord.gg/cRFFHYye7t)

## Sponsors

<p align="center">
  <a href="https://github.com/sponsors/jackyzha0">
    <img src="https://cdn.jsdelivr.net/gh/jackyzha0/jackyzha0/sponsorkit/sponsors.svg" />
  </a>
</p>

# Command to run the server locally:
`cd "Digital Garden"` \
`node ./quartz/bootstrap-cli.mjs build --serve`
then navigate to `http://localhost:8080`
lsof -ti:8080 | xargs kill -9; sleep 1; cd "/Users/hamsini/Chaos/hamsini-digital-garden/Digital Garden/public" && python3 -m http.server 8080

# Commands to push to github:
Please add anything you don't want tracked to the .gitignore file first
`git add -A`
`git commit -m "this is my commit message"`
`git push origin main`