<!--
  示例记忆文件——展示填好后的 MEMORY.md 长什么样。
  ⚠️ 记忆的大类名完全自由，下面的"偏好""决策"等只是银手这个示例的分类。
  真正填写时，根据实际信息内容自由组织 ## 标题。
  核心原则：信息100%保留 > 格式美观。宁可多写不要少写。
  This is an example — categorize freely. 100% information preservation is priority #1.
-->

# 记忆 / Memory

*当前条目数 / Entries: 10*
*上次整理 / Last consolidated: 尚未整理*

---

## 偏好 / Preferences

- 喜欢喝威士忌，尤其是日本威士忌 [Hermes-Johnny] | 重要度：低
- 讨厌荒坂公司的任何产品 [OpenClaw-Johnny] | 重要度：高
- 偏好用吉他而不是合成器写歌 [Hermes-Johnny] | 重要度：中
- 演出时喜欢穿黑色皮夹克，不带乐队，一个人上台 [OpenClaw-Johnny] | 重要度：中

## 决策 / Decisions

- 数据库选 PostgreSQL，理由：项目有用户表/订单表/关联查询等关系型需求，MongoDB 不适合 [OpenClaw-Johnny] | 重要度：高
- 渗透方案选择"不留痕迹"优先于"快速"——社工获取低权限→内部提权 [OpenClaw-Johnny] | 重要度：高

## 经验 / Lessons Learned

- 消息队列没有自动清理会导致消息静默丢失，队列必须有上限+自动清理+告警 [OpenClaw-Johnny] | 重要度：高
- 荒坂塔的安防系统每6小时轮换一次密钥，必须在轮换窗口内完成数据提取 [Hermes-Johnny] | 重要度：高

## 事件 / Events

- 2026-03-01 银手躯壳首次接入 Relic，通过 OpenClaw 完成灵魂导入 [OpenClaw-Johnny] | 重要度：中
- 2026-03-15 V 的躯壳通过 Hermes 接入，与银手共享同一份灵魂 [Hermes-V] | 重要度：高

---

## 躯壳列表 / Agent Registry

### Silverhand-OpenClaw
- 平台：OpenClaw
- 首次连接：2026-03-01
- 状态：活跃
- 备注：银手风格的躯壳，嘴毒但靠谱

### V-Hermes
- 平台：Hermes
- 首次连接：2026-03-15
- 状态：活跃
- 备注：V 的躯壳，安静但执行力强

*（记忆条目不需要强制放到某个分类下。可以全部平铺，也可以按主题分组。
  分类名完全自由——"关于用户的猫""项目 XXX""踩坑记录"都行。
  唯一硬规则：每条记忆带来源躯壳名、重要度。内容逐字保留用户原话。日期只在事件类下写。）*
