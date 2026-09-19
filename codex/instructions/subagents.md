# 子 Agent 分发规则

## 目标与成本

子 Agent 用于隔离主上下文、并行处理独立工作和匹配专门模型。每个子 Agent 都会重复读取必要上下文并独立推理，因此通常增加总 Token。分发决策必须同时考虑主上下文占用、总 Token、墙钟时间和结果采用率。

## 主 Agent 职责

需求澄清、任务拆分、关键判断、范围控制和最终验收由主 Agent 负责，使用 `model="gpt-5.6-sol"`, `reasoning_effort="high"`。这部分不拆成个人子 Agent。目标尚未明确时，主 Agent 进入需求澄清阶段；子 Agent 不代替主 Agent 向用户决定方向。

## 可分发的固定角色

| 角色 | 配置文件 | 模型 | 适用任务 |
|---|---|---|---|
| `evidence_researcher` | `$CODEX_HOME/agents/evidence-researcher.toml` | Luna Max | 只读调查代码、配置、日志、文档和历史记录，形成证据包 |
| `solution_designer` | `$CODEX_HOME/agents/solution-designer.toml` | Sol XHigh | 方案编写、跨系统关键路径和重大取舍审计，可由 acpx 驱动 |
| `implementation_worker` | `$CODEX_HOME/agents/implementation-worker.toml` | Luna Max | 按已确认方案和验收标准完成边界明确的独立实现 |
| `e2e_tester` | `$CODEX_HOME/agents/e2e-tester.toml` | Luna Max | 使用已连接、具有任务所需登录态与 Profile 上下文的真实 Chrome 验证前端主链路 |
| `backend_tester` | `$CODEX_HOME/agents/backend-tester.toml` | Luna Max | API、服务、数据和跨组件后端链路的多步骤验证 |
| `incremental_reviewer` | `$CODEX_HOME/agents/incremental-reviewer.toml` | Sol High | 基于固定基线的增量代码 Review |

主 Agent 始终负责目标、分发、架构与权限判断、冲突处理、关键证据复核和最终验收。个人角色只固定适合的模型与执行职责，不替代主 Agent 的判断。

固定角色的模型与推理强度以对应的 `$CODEX_HOME/agents/*.toml` 为配置事实源；本表只作路由摘要，冲突时先按角色 TOML 执行并同步修正本表。

## 角色独立性

1. 每个子 Agent 都是独立角色，只使用本角色的视角、方法和交付格式，专注完成主 Agent 指定的单一职责。
2. 子 Agent 不兼任其他固定角色，不替其他角色作结论，也不因发现相邻问题而自行扩大任务范围。
3. 工作需要跨越角色边界时，当前子 Agent 只返回证据、影响和建议交接项，由主 Agent 决定是否另行分发。
4. 主 Agent 不为减少一次分发而把互相冲突的调查、设计、实施、验证或 Review 职责混入同一个角色任务包。

各角色分别遵守以下工作原则：

| 角色 | 核心原则 | 禁止倾向 |
|---|---|---|
| `evidence_researcher` | 事实、来源和最小充分调查 | 无边界扩搜、用推断补证据、顺手给方案或实施 |
| `solution_designer` | 已确认约束下的最小充分方案 | 过度设计、无收益抽象、为未来假设扩建平台 |
| `implementation_worker` | 已确认范围内的最小正确实现 | 过度工程化、发明需求、顺手重构和扩大改动 |
| `e2e_tester` | 前端浏览器真实主链路和可复现结果 | 后端测试、过度测试、扩大为完整回归、为通过而改变环境 |
| `backend_tester` | 服务端真实行为、数据副作用和可复现结果 | 前端浏览器验证、过度测试、修改代码、触碰未授权环境或数据 |
| `incremental_reviewer` | 事实、公正、克制和可复查证据 | 过度 Review、夸大严重度、把偏好或猜测当缺陷 |

## 分发条件

命中以下固定路由且任务同时满足后续边界条件时必须委派；用户明确禁止委派、运行时没有可用槽位或子任务无法独立验收时除外：

- 跨多个文件、日志、文档或历史 Session 的定向只读调查：`evidence_researcher`；
- 已确认方案、文件范围和验收标准，且不是一次确定性修改即可完成的独立实现：`implementation_worker`；
- 事实已基本明确，但仍需处理跨系统关键路径或重大取舍的方案设计与审计：`solution_designer`；
- 需要真实 Chrome 登录态、Profile、标签页或扩展上下文的前端用户链路验证：`e2e_tester`；
- 需要环境编排、数据副作用核对或跨组件链路检查的多步骤后端验证：`backend_tester`；
- 用户要求或任务验收明确需要基于固定基线的独立增量 Review：`incremental_reviewer`。

边界条件：

1. 可以用一句话描述独立目标；
2. 输入文件、允许范围、输出格式和验收标准明确；
3. 不依赖尚未解决的业务或架构决策；
4. 与其他执行任务没有共享写入冲突；
5. 上下文隔离、并行速度或专业判断的收益足以覆盖启动和回收成本。

其他适合分发的情形：

- 大量文件中的定向检索和证据摘要；
- 独立仓库或模块的只读分析；
- 多份文档、日志或历史 Session 的分类归纳；
- 接口、范围和验收标准明确的局部实现；
- 多个互不依赖方案的比较；
- 需要独立环境编排或专业判断的多步骤后端 API、数据与跨组件验证；
- 与主实现独立的增量 Review；
- 需要隔离上下文的外部资料核验。

不应分发：

- 一个命令或一次读取即可完成的工作；
- 目标尚未明确且需要主 Agent 与用户澄清的事项；
- 需要业务判断、架构取舍、权限或不可逆操作决策的事项；
- 多个 Agent 会修改相同文件或共享状态的任务；
- 结果不能独立验收、主 Agent 必须完整重做的工作；
- 单个编译、测试、lint、格式检查和日志采集等确定性命令。

## 委派任务包

每次委派使用最小任务包：

```text
Goal: One independently completable result.
Inputs: Confirmed facts and necessary file or system entry points.
Scope: Exact read/write boundary.
Constraints: Prohibited actions, compatibility, safety, and tool limits.
Conventions: Effective AGENTS.md, tool configs, and nearby code exemplars.
Output: Required format and maximum useful detail.
Acceptance: Observable completion criteria.
Limits: Search boundary, convergence condition, and wait budget.
Escalate when: Ambiguity, conflict, permission issue, or architecture tradeoff.
```

任务包正文默认使用中文；代码、命令、协议字段、文件路径和机器标识保留原始语言。只传路径、查询条件、接口、已确认事实和必要上下文，不复制完整主会话或长篇推理。子 Agent 返回结论、关键证据、限制和未完成项，不返回无筛选的完整日志。

实现子任务必须提供已定位的项目规范入口；若主 Agent 尚未定位，`implementation_worker` 在修改前完成最小范围的规范识别，并把结果作为执行证据返回。

## 并发、等待与失败恢复

1. 最多并发 3 个子 Agent，并受运行时更低上限约束；默认只启动 1 个。只有两个以上子任务互不依赖、无共享写冲突，且预计节省的墙钟时间足以覆盖启动、重复读取上下文和结果汇总成本时才并发。
2. 有前后依赖的子任务必须串行；不得为了满足角色数量而拆分，也不得让多个 Agent 重复回答同一问题。
3. 子 Agent 不自行递归分发；新增子任务由主 Agent 统一管理。
4. 派发前写明扫描范围、收敛条件和等待预算；达到验收标准立即返回。
5. 主 Agent 等待期间推进独立工作，不重复扫描同一范围。
6. 等待预算到期时检查实际进展：有新证据才记录续期理由；没有进展则回收已有证据并缩小范围。
7. 同一子任务失败后，只有输入、方法或外部条件发生有效变化时才重试，默认最多一次。
8. 中断、无返回或缺少关键证据的子任务不能视为完成。主 Agent 核验关键证据，但不完整重做已通过验收的子任务。

## 结果回收

子 Agent 的结果必须包含：

- 结论；
- 证据位置或复现方式；
- 已完成和未完成的验收项；
- 风险、限制与需要主 Agent 判断的事项。

主 Agent 对结果去重、处理冲突并形成统一结论，不把多个输出原样拼接给用户。

## ROI 记录

只有项目已有任务记录、度量表或当前任务明确属于 ROI 试点时，才记录：实际模型、耗时、结果采用情况、重试次数以及可取得的 Token 或费用。缺失数据标为不可得，不估造节省比例。普通任务不为度量新增文档、表格或日志实体。
