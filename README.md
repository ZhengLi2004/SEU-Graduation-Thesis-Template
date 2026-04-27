# 东南大学本科毕业设计（论文）LaTeX 模板

本仓库提供一套基于 `XeLaTeX` 的东南大学本科毕业设计（论文）模板，以及一份可以直接编译的完整示例。模板当前以 Windows 环境为主要目标，已经覆盖封面、声明页、AI 使用情况说明表、摘要、目录、正文、参考文献、附录、致谢与末页。

## 目录结构

- `main.tex`：主入口文件，绝大多数元信息在这里填写
- `seuthesis.cls`：模板类文件
- `content/abstract_zh.tex`：中文摘要正文
- `content/abstract_en.tex`：英文摘要正文
- `content/chapter*.tex`：正文示例章节
- `content/appendix-a.tex`：附录示例
- `content/acknowledgements.tex`：致谢示例
- `bib/references.bib`：参考文献数据库
- `imgs/`：模板图片、签名图片等资源
- `latexmkrc`：推荐编译配置

## 环境配置

### 推荐环境

推荐使用 TeX Live 2025 及以上版本，并通过 `latexmk + XeLaTeX + biber` 编译。模板支持 Windows 和 macOS（通过 Songti SC / Heiti SC 等系统字体回退）。

本机实测环境如下：
- `latexmk`：`4.86a`
- `XeLaTeX`：`XeTeX 3.141592653-2.6-0.999997 (TeX Live 2025)`
- `biber`：`2.20`

### 安装步骤

如果你是第一次在新机器上使用本模板，建议按下面顺序准备环境：

1. 安装 `TeX Live 2025`，并确保其中包含 `xelatex`、`latexmk`、`biblatex`、`biber`。
2. 将 TeX Live 的可执行文件目录加入系统 `PATH`，使得终端可以直接运行 `xelatex`、`latexmk`、`biber`。
3. 确认系统已安装模板依赖的 Windows 字体。
4. 将仓库克隆或解压到本地目录后，在仓库根目录运行编译命令。

建议安装完成后先做一次自检：

```powershell
latexmk -v
xelatex --version
biber --version
```

只要这三个命令都能正常输出版本号，通常就具备了基本编译条件。

### 可复现环境清单

如果你希望尽量复现当前仓库在开发机上的编译表现，建议至少满足以下条件：
- TeX 发行版：TeX Live 2025
- 编译引擎：XeLaTeX
- 构建工具：latexmk 4.86a 或同代版本
- 文献工具：biber 2.20 或兼容版本
- 字体：`Times New Roman`、`SimSun`、`SimHei`、`KaiTi`、`FangSong`（macOS 下自动回退到 `Songti SC`、`Heiti SC`、`Kaiti SC`、`STFangsong`）
- 仓库内编译配置：使用项目自带的 `latexmkrc`

如果你的环境与上述差异较大，例如改用 Linux、MiKTeX 或非系统自带字体方案，请预期自行处理字体兼容与行距差异。

### 字体依赖

模板采用严格字体匹配策略，按以下顺序查找字体（优先 Windows 名称，其次 macOS 名称）：

| 用途 | Windows | macOS 回退 |
|------|---------|-----------|
| 宋体 | `SimSun` / `宋体` | `Songti SC` |
| 黑体 | `SimHei` / `黑体` | `Heiti SC` |
| 楷体 | `KaiTi` / `楷体` | `Kaiti SC` |
| 仿宋 | `FangSong` / `仿宋` | `STFangsong` |
| 西文 | `Times New Roman` | `Times New Roman` |

注意事项：

- 由于版权、授权和分发限制，本仓库**不打包**上述商业 / 系统字体。
- 如果缺少这些字体，模板会在编译时直接报错，而不是静默替换为其他字体。
- macOS 下仿宋字体 (`STFangsong`) 可能未预装，如缺少可忽略或自行安装。

### 编译配置

仓库内置的 `latexmkrc` 内容如下：

```perl
$pdf_mode = 5;
$xelatex = 'xelatex -interaction=nonstopmode -file-line-error -synctex=0 %O %S';
$biber = 'biber %O %B';
```

含义如下：

- `$pdf_mode = 5` 指定使用 `xelatex` 作为编译引擎
- 开启 `-file-line-error`，便于定位错误行号
- 默认使用 `-synctex=0`，减少日常编译生成和维护 SyncTeX 文件的开销
- 参考文献由 `biber` 处理

### 编译指令

日常快速编译推荐直接使用 `latexmk`：

```powershell
latexmk -xelatex main.tex
```

如果需要编辑器反向跳转，可临时覆盖 `latexmkrc` 中的 XeLaTeX 命令：

```powershell
latexmk -xelatex -e '$xelatex = q/xelatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S/' main.tex
```

强制全量重编译仅建议在清理缓存、排查异常或定稿前使用，不要作为日常编译命令：

```powershell
latexmk -gg -xelatex main.tex
```

清理辅助文件：

```powershell
latexmk -c
```

如果需要手动编译，推荐顺序为：

```powershell
xelatex -interaction=nonstopmode -file-line-error -synctex=0 main.tex
biber main
xelatex -interaction=nonstopmode -file-line-error -synctex=0 main.tex
xelatex -interaction=nonstopmode -file-line-error -synctex=0 main.tex
```

## 使用说明

### 完成一份毕业设计通常需要修改哪些文件

通常至少需要修改以下内容：

- `main.tex` 中 `\begin{document}` 之前的元信息、关键词、AI 说明配置、签名图片路径
- `content/abstract_zh.tex` 中的中文摘要正文
- `content/abstract_en.tex` 中的英文摘要正文
- `content/chapter*.tex` 中的正文内容
- `bib/references.bib` 中的参考文献条目
- `imgs/` 中你自己的插图、学生签名图片、教师签名图片

### `\begin{document}` 之前各指令的含义

以下说明按 `main.tex` 当前顺序展开。

#### 1. `\addkey{中文关键词}{EnglishKeyword}`

用于填写中英文关键词，一条命令同时追加一对关键词。

使用规则：

- 必须写在 `\begin{document}` 之前
- 可重复写多次，每次增加一组中英文关键词
- 中文摘要页显示所有中文关键词
- 英文摘要页显示所有英文关键词

示例：

```tex
\addkey{机器学习}{Machine Learning}
\addkey{知识图谱}{Knowledge Graph}
\addkey{大语言模型}{Large Language Model}
```

#### 2. `\seusetup{...}`

这是模板最主要的元信息入口。下面逐项说明当前可填写的键。

##### 封面与基本信息

- `title`
  封面主标题，通常必填。
  当前模板**不会自动换行**，请尽量控制在一行内。若标题过长，建议自行精简标题，或把拆分之后的后半部分标题放进 `subtitle`。

- `subtitle`
  封面副标题，可省略。
  如果不需要副标题，可以直接删掉这一行，或者写成 `subtitle = {}`。
  当前模板省略 `subtitle` 后，封面只显示 `title` 一行；AI 说明表中的课题名称也会只显示 `title`。

- `author`
  学生姓名。

- `student_id`
  学号。

- `school`
  学院名称。

- `major`
  专业名称。

- `supervisor`
  指导教师姓名。

- `date_range`
  起止日期，显示在封面中。
  例如：`2026.03.09—2026.05.30`。

##### 自动分段日期

以下日期字段会自动渲染成“年 月 日”分段样式，建议统一使用数字格式：

- `cover_date`
- `originality_date`
- `authorization_author_date`
- `authorization_supervisor_date`
- `ai_student_date`
- `ai_teacher_date`

推荐格式：

```tex
2026-04-10
```

也可以写成：

```tex
2026-4-10
```

##### AI 使用情况说明表

- `ai_used`
  控制是否使用生成式人工智能。
  可选值：
  - `yes`：使用了 AI
  - `no`：未使用 AI
  - `unset`：模板调试状态，正式写作不建议使用

- `ai_scope`
  仅当 `ai_used = yes` 时需要填写。
  当前模板使用数字编码：
  - `1`：文本生成及内容修改
  - `2`：数据、图表分析、代码调试
  - `3`：其他

  可组合填写，例如：
  - `1`
  - `2`
  - `12`
  - `13`
  - `123`

  如果 `ai_used = yes` 但没有填写 `ai_scope`，模板会直接报错。

- `ai_checkbox_style`
  控制 AI 使用情况说明表中“已选中”方框的样式。
  可选值：
  - `checkedbox`：方框内打勾
  - `blacksquare`：实心方块

- `ai_teacher_comment`
  指导教师意见内容。
  可以先留空，打印后手写；也可以直接填写文字。

- `signature_student_image`
  学生签名图片路径，可选。
  填写后会自动渲染到：
  - 第二页两处论文作者签名
  - 第三页学生签名

- `signature_teacher_image`
  教师签名图片路径，可选。
  填写后会自动渲染到：
  - 第二页导师签名
  - 第三页指导教师签名

补充说明：
- 当前类文件中的 AI 说明表课题名称会自动由 `title + subtitle` 生成

示例：

```tex
\seusetup{
  title                         = {基于 Transformer 的},
  subtitle                      = {毕业论文设计},
  author                        = {张三},
  student_id                    = {71122100},
  school                        = {软件学院},
  major                         = {软件工程},
  supervisor                    = {张三丰},
  date_range                    = {2026.03.09—2026.05.30},
  cover_date                    = {2026-04-10},
  originality_date              = {2026-04-10},
  authorization_author_date     = {2026-04-10},
  authorization_supervisor_date = {2026-04-10},
  ai_used                       = yes,
  ai_scope                      = {12},
  ai_checkbox_style             = checkedbox,
  signature_student_image       = {imgs/zhangsan.png},
  signature_teacher_image       = {imgs/zhangsanfeng.png},
  ai_student_date               = {2026-04-10},
  ai_teacher_date               = {2026-04-10},
  ai_teacher_comment            = {同意。}
}
```

#### 5. `\seuaiitem{...}`

用于补充 AI 使用记录。只有在 `ai_used = yes` 时才需要填写。

当前推荐填写以下字段：

- `tool_version`
  工具与版本号。
  已支持把多个工具版本写在同一项中，并通过 `\par` 手动换行。

- `process`
  使用过程说明。

- `pages`
  使用涉及到的章节与页码。

示例：

```tex
\seuaiitem{
  tool_version = {DeepSeek-V3.2\par ChatGPT-5.4},
  process      = {用于生成初稿表述、润色部分段落，并辅助检查措辞。最终内容均由本人核对修改。},
  pages        = {第二章 1.1（P5）\par 第二章 1.2（P7）}
}
```

说明：
- 如果 `ai_used = no`，不需要写 `\seuaiitem`

### `\begin{document}` 之后的文档流程

当前 `main.tex` 的正文流程如下：

- `\seumakefrontmatter`
  生成封面、独创性声明 / 授权声明页、AI 使用情况说明表

- `\seuprefacematter`
  切换到前置部分页码样式（罗马数字）

- `\seumakechineseabstract`
  生成中文摘要页

- `\seumakeenglishabstract`
  生成英文摘要页

- `\seumaketableofcontents`
  生成目录

- `\seumainmatter`
  切换到正文页码样式（阿拉伯数字）

- `\input{content/chapter1.tex}` 等
  正文章节内容。你可以继续添加、删除或重排章节，但要同步修改这些 `\input` 行。

- `\seuprintbibliography`
  输出参考文献列表

- `\appendix`
  切换到附录编号样式

- `\input{content/appendix-a.tex}`
  附录内容

- `\input{content/acknowledgements.tex}`
  致谢内容

- `\seumottopage`
  末页“止于至善”图片页

## 签名图片要求

学生签名和教师签名图片请遵循以下要求：

- 建议使用 `PNG`
- 背景建议为**透明背景**
- 建议是**黑笔签名**
- 四周不要保留白边，尽量裁切到只剩签名本体

如果暂时不想自动插入签名图片，可以留空对应字段，打印后手写签名。

## 最常见的修改位置

第一次使用时，通常至少需要修改这些文件：

- [main.tex](main.tex)：封面信息、日期、AI 说明、签名图片路径
- [content/abstract_zh.tex](content/abstract_zh.tex)：中文摘要
- [content/abstract_en.tex](content/abstract_en.tex)：英文摘要
- [content/chapter1.tex](content/chapter1.tex) 等：正文
- [bib/references.bib](bib/references.bib)：参考文献

## 常见问题

### 1. 编译报字体不存在

如果出现类似以下错误：

```text
Required font 'SimSun or 宋体' not found
```

说明当前系统缺少模板要求的字体。Windows 用户请确认系统已安装对应字体；macOS 用户请确认 Songti SC / Heiti SC 等系统字体可用。

### 2. 参考文献不出现或引用编号不对

优先使用：

```powershell
latexmk -xelatex main.tex
```

不要只运行一次 `xelatex main.tex` 就判断模板有问题。

### 3. 标题过长挤出封面

当前封面标题不会自动换行。请优先：

- 缩短 `title`
- 把补充描述挪到 `subtitle`

### 4. AI 说明表报错 `missing-ai-scope`

说明你设置了：

```tex
ai_used = yes
```

但没有填写合法的：

```tex
ai_scope = {1}
```

请至少选择一个范围编码。

### 5. 出现 `main.bbl-SAVE-ERROR`、`main.bcf-SAVE-ERROR` 或辅助文件无法删除

这通常不是模板逻辑错误，而是目标文件正被其他程序占用，例如：

- PDF 阅读器正在打开 `main.pdf`
- 编辑器正在占用某些中间文件

关闭占用文件的程序后重新编译即可。

## 备注

- `main.pdf` 是当前示例文档的编译产物，不是模板说明文档
- 模板已支持 Windows 和 macOS 字体自动回退；Linux 用户请自行处理字体兼容问题
