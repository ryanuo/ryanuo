// generate-lists.js
import fs from 'node:fs'
import { Octokit } from '@octokit/rest'

const username = 'ryanuo'
const token = process.env.GITHUB_TOKEN
const octokit = new Octokit({ auth: token })

// ⭐ 格式化 star 数（大于 1000 显示为 1.2k）
function formatStars(num) {
  if (num >= 1000) return `${(num / 1000).toFixed(num >= 10000 ? 0 : 1)}k`
  return `${num}`
}

async function fetchRepos() {
  const res = await octokit.rest.repos.listForUser({ username, per_page: 100 })
  return res.data
    .filter(r => !r.fork)
    .map(r => ({
      name: r.name,
      stars: r.stargazers_count,
      desc: r.description || '',
      url: r.html_url,
    }))
    .sort((a, b) => b.stars - a.stars)
}

async function fetchStarred() {
  const res = await octokit.paginate(octokit.rest.activity.listReposStarredByUser, {
    username,
    per_page: 100,
  })
  return res
    .map(r => ({
      name: `${r.owner.login}/${r.name}`,
      stars: r.stargazers_count,
      desc: r.description || '',
      url: r.html_url,
    }))
    .sort((a, b) => b.stars - a.stars)
}

function genMarkdown(title, repos) {
  const lines = [
    `# ${title}\n`,
    `自动生成于 ${new Date().toLocaleString()}。\n`,
    `| 项目 | Star | 描述 |`,
    `| ---- | ---- | ---- |`,
    ...repos.map(r =>
      `| [${r.name}](${r.url}) | ⭐ ${formatStars(r.stars)} | ${r.desc.replace(/\|/g, '\\|')} |`,
    ),
  ]
  return lines.join('\n')
}

async function main() {
  const [repos, starred] = await Promise.all([fetchRepos(), fetchStarred()])
  fs.writeFileSync('PROJECTS.md', genMarkdown(`⭐ ${username} 的项目列表`, repos))
  fs.writeFileSync('STARRED.md', genMarkdown(`🌟 ${username} Star 的项目`, starred))
  console.log('✅ 已生成 PROJECTS.md 与 STARRED.md（含简写 Star 数）')
}

main().catch(err => console.error('❌ Error:', err))
