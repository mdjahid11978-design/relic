<!--
  技能目录 / Skills Directory
  每个 .md 文件是一个技能 / Each .md file is one skill
  义体可添加新技能 / Agents can add new skills
-->

# 技能 / Skills

> 📭 **目录现在是空的，这是正常的。**
> 当你的 AI 在工作中学会了某种可复用的流程（比如"怎么调试报错"、"怎么写周报"），它会自动在这里创建技能文件。你不需要手动添加。

每个技能一个 Markdown 文件，放在此目录下。
One Markdown file per skill, stored in this directory.

义体会在工作中按需加载相关技能。
Agents load relevant skills on demand during work.

## 创建技能示例 / Minimal Example

```markdown
---
name: my-skill
version: "1.0"
created: 2026-04-16
author: [义体名 / Agent Name]
trigger: 关键词, 触发词
---

# 我的技能 / My Skill

## 触发条件 / Trigger
当用户说"关键词"或"触发词"时使用。

## 步骤 / Steps
1. 第一步 / Step one
2. 第二步 / Step two

## 注意事项 / Notes
- 注意点 / Notes
```
