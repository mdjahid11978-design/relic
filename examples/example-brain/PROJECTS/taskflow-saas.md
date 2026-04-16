---
name: sideproject-saas
version: "1.0"
created: 2026-03-28
author: Claude Code
status: active
---

# SideProject — 个人项目管理工具

## 项目概述
轻量级项目管理工具，支持看板视图、拖拽排序。个人开发者向。

## 技术栈
- 前端：React + Vite + 纯 CSS
- 后端：Node.js + SQLite (Turso)
- 部署：Fly.io
- 包管理：pnpm

## 当前状态
开发中，核心功能完成约60%。

## 已完成
- 用户注册/登录
- 看板基础视图
- 任务创建/编辑/删除

## 当前卡点
- 跨列拖拽动画不流畅（@dnd-kit）
- Turso 免费版行数快到上限

## 关键决策
- 定价：免费版3项目，Pro版$5/月（3/31决定）
- 不用 CSS 框架，手写 CSS（3/29决定）
- 不做移动端适配，桌面优先（3/31决定）
