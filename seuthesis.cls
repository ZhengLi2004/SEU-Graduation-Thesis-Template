\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{seuthesis}[2026/04/04 Southeast University thesis template]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
\LoadClass[UTF8,oneside,openany,fontset=none]{ctexbook}

\RequirePackage[
  a4paper,
  top=2cm,
  bottom=2cm,
  left=2cm,
  right=2cm,
  bindingoffset=0.5cm,
  headheight=14pt,
  headsep=0.5cm,
  footskip=1.25cm
]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage{setspace}
\RequirePackage{xcolor}
\RequirePackage{hyperref}
\RequirePackage{xparse}
\RequirePackage{expl3}
\RequirePackage{eso-pic}
\RequirePackage{tikz}
\RequirePackage{tikzpagenodes}
\RequirePackage{tabularray}
\RequirePackage{array}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{bm}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{multirow}
\RequirePackage{tocloft}
\RequirePackage{chngcntr}
\RequirePackage[bottom]{footmisc}
\RequirePackage{pifont}
\RequirePackage[
  backend=biber,
  style=gb7714-2015,
  sorting=none,
  gbnamefmt=uppercase,
  doi=false,
  isbn=false,
  eprint=false
]{biblatex}
\addbibresource{bib/references.bib}

\ExplSyntaxOn

\tl_new:N \g_seu_title_tl
\tl_new:N \g_seu_subtitle_tl
\tl_new:N \g_seu_author_tl
\tl_new:N \g_seu_student_id_tl
\tl_new:N \g_seu_school_tl
\tl_new:N \g_seu_major_tl
\tl_new:N \g_seu_supervisor_tl
\tl_new:N \g_seu_date_range_tl
\tl_new:N \g_seu_abstract_zh_tl
\tl_new:N \g_seu_keywords_zh_tl
\tl_new:N \g_seu_abstract_en_tl
\tl_new:N \g_seu_keywords_en_tl
\tl_new:N \g_seu_cover_date_tl
\tl_new:N \g_seu_originality_date_tl
\tl_new:N \g_seu_authorization_author_date_tl
\tl_new:N \g_seu_authorization_supervisor_date_tl
\tl_new:N \g_seu_ai_used_tl
\tl_new:N \g_seu_ai_student_date_tl
\tl_new:N \g_seu_ai_teacher_date_tl
\tl_new:N \g_seu_ai_teacher_comment_tl
\tl_new:N \g_seu_image_path_tl
\tl_new:N \g_seu_logo_image_tl
\tl_new:N \g_seu_degree_image_tl
\tl_new:N \g_seu_cover_bg_image_tl
\tl_new:N \g_seu_motto_image_tl
\tl_new:N \g_seu_ai_tool_display_tl
\tl_new:N \g_seu_ai_scope_display_tl
\tl_new:N \g_seu_ai_process_display_tl
\tl_new:N \g_seu_ai_pages_display_tl
\seq_new:N \g_seu_ai_items_seq
\seq_new:N \g_seu_ai_text_items_seq

\tl_new:N \l_seu_ai_tool_tl
\tl_new:N \l_seu_ai_version_tl
\tl_new:N \l_seu_ai_scope_tl
\tl_new:N \l_seu_ai_process_tl
\tl_new:N \l_seu_ai_pages_tl
\bool_new:N \l_seu_ai_scope_text_bool
\bool_new:N \l_seu_ai_scope_data_bool
\bool_new:N \l_seu_ai_scope_other_bool

\tl_gset:Nn \g_seu_image_path_tl { imgs/ }
\tl_gset:Nn \g_seu_logo_image_tl { logo.png }
\tl_gset:Nn \g_seu_degree_image_tl { degree.jpg }
\tl_gset:Nn \g_seu_cover_bg_image_tl { cover-1.png }
\tl_gset:Nn \g_seu_motto_image_tl { cover-2.png }
\tl_gset:Nn \g_seu_ai_used_tl { no }

\keys_define:nn { seu/setup }
  {
    title       .tl_gset:N = \g_seu_title_tl,
    subtitle    .tl_gset:N = \g_seu_subtitle_tl,
    author      .tl_gset:N = \g_seu_author_tl,
    student_id  .tl_gset:N = \g_seu_student_id_tl,
    school      .tl_gset:N = \g_seu_school_tl,
    major       .tl_gset:N = \g_seu_major_tl,
    supervisor  .tl_gset:N = \g_seu_supervisor_tl,
    date_range  .tl_gset:N = \g_seu_date_range_tl,
    abstract_zh .tl_gset:N = \g_seu_abstract_zh_tl,
    keywords_zh .tl_gset:N = \g_seu_keywords_zh_tl,
    abstract_en .tl_gset:N = \g_seu_abstract_en_tl,
    keywords_en .tl_gset:N = \g_seu_keywords_en_tl,
    cover_date .tl_gset:N = \g_seu_cover_date_tl,
    originality_date .tl_gset:N = \g_seu_originality_date_tl,
    authorization_author_date .tl_gset:N =
      \g_seu_authorization_author_date_tl,
    authorization_supervisor_date .tl_gset:N =
      \g_seu_authorization_supervisor_date_tl,
    ai_student_date .tl_gset:N = \g_seu_ai_student_date_tl,
    ai_teacher_date .tl_gset:N = \g_seu_ai_teacher_date_tl,
    ai_teacher_comment .tl_gset:N = \g_seu_ai_teacher_comment_tl,
    ai_used .choice:,
    ai_used / yes .code:n = { \tl_gset:Nn \g_seu_ai_used_tl { yes } },
    ai_used / no .code:n = { \tl_gset:Nn \g_seu_ai_used_tl { no } },
    ai_used .initial:n = no,
  }

\keys_define:nn { seu/aiitem }
  {
    tool .tl_set:N = \l_seu_ai_tool_tl,
    version .tl_set:N = \l_seu_ai_version_tl,
    scope .tl_set:N = \l_seu_ai_scope_tl,
    process .tl_set:N = \l_seu_ai_process_tl,
    pages .tl_set:N = \l_seu_ai_pages_tl,
  }

\cs_new_protected:Npn \seu_apply_default_fonts:
  {
    \setmainfont
      [
        Path = C:/Windows/Fonts/,
        Extension = .ttf,
        UprightFont = *,
        BoldFont = *bd,
        ItalicFont = *i,
        BoldItalicFont = *bi
      ]
      { times }
    \setCJKmainfont
      [
        BoldFont = SimHei,
        ItalicFont = KaiTi,
        BoldItalicFont = KaiTi
      ]
      { SimSun }
    \setCJKsansfont { SimHei }
    \setCJKmonofont { FangSong }
    \setCJKfamilyfont { zhsong }
      [
        BoldFont = SimHei,
        ItalicFont = KaiTi,
        BoldItalicFont = KaiTi
      ]
      { SimSun }
    \setCJKfamilyfont { zhhei } { SimHei }
    \setCJKfamilyfont { zhkai } { KaiTi }
    \setCJKfamilyfont { zhfs } { FangSong }
  }

\cs_new_protected:Npn \seu_apply_body_style:
  {
    \seuxiaosi
    \setstretch { 1.5 }
    \setlength { \parindent } { 2\ccwd }
    \setlength { \parskip } { 0pt }
  }

\cs_new:Npn \seu_blank_rule:n #1
  { \underline{\hspace{#1}} }

\cs_new:Npn \seu_date_placeholder:
  {
    \underline{\hspace{1.6em}}年\hspace{0.45em}
    \underline{\hspace{1.4em}}月\hspace{0.45em}
    \underline{\hspace{1.4em}}日
  }

\cs_new:Npn \seu_cover_rule_box:nn #1#2
  {
    \parbox[c][1.62cm][c]{#1}
      {
        \centering #2 \par
        \vspace{0.06cm}
        \hrule height 0.4pt
      }
  }

\cs_new:Npn \seu_cover_label:n #1
  { \makebox[3.43cm][l]{\seucoverlabelfont #1} }

\cs_new:Npn \seu_cover_value:n #1
  {
    \parbox[c][0.80cm][c]{7.99cm}
      {
        \centering
        \vbox to 0.80cm
          {
            \vfil
            \hbox to 7.70cm { \hfil \seucovervaluefont #1 \strut \hfil }
            \vspace{0.04cm}
            \hrule height 0.4pt width 7.70cm
          }
      }
  }

\cs_new:Npn \seu_display_or_rule:nN #1#2
  { \tl_if_blank:VTF #2 { \seu_blank_rule:n {#1} } { \tl_use:N #2 } }

\cs_new:Npn \seu_display_or_date_placeholder:N #1
  { \tl_if_blank:VTF #1 { \seu_date_placeholder: } { \tl_use:N #1 } }

\cs_new:Npn \seu_checkbox:nn #1#2
  { \tl_if_eq:nnTF {#1} {#2} { \ensuremath{\blacksquare} } { \ensuremath{\square} } }

\cs_new:Npn \seu_yes_box:
  { \exp_args:NV \seu_checkbox:nn \g_seu_ai_used_tl { yes } }

\cs_new:Npn \seu_no_box:
  { \exp_args:NV \seu_checkbox:nn \g_seu_ai_used_tl { no } }

\cs_new:Npn \seu_tool_version:nn #1#2
  {
    \tl_if_blank:nTF {#1}
      { }
      {
        #1
        \tl_if_blank:nF {#2} { -#2 }
      }
  }

\cs_new_protected:Npn \seu_ai_scope_detect:
  {
    \bool_set_false:N \l_seu_ai_scope_text_bool
    \bool_set_false:N \l_seu_ai_scope_data_bool
    \bool_set_false:N \l_seu_ai_scope_other_bool
    \tl_if_blank:VF \g_seu_ai_scope_display_tl
      {
        \tl_if_in:VnT \g_seu_ai_scope_display_tl { 文本生成 }
          { \bool_set_true:N \l_seu_ai_scope_text_bool }
        \tl_if_in:VnT \g_seu_ai_scope_display_tl { 内容修改 }
          { \bool_set_true:N \l_seu_ai_scope_text_bool }
        \tl_if_in:VnT \g_seu_ai_scope_display_tl { 数据 }
          { \bool_set_true:N \l_seu_ai_scope_data_bool }
        \tl_if_in:VnT \g_seu_ai_scope_display_tl { 图表 }
          { \bool_set_true:N \l_seu_ai_scope_data_bool }
        \tl_if_in:VnT \g_seu_ai_scope_display_tl { 代码调试 }
          { \bool_set_true:N \l_seu_ai_scope_data_bool }
        \bool_if:nF
          { \l_seu_ai_scope_text_bool || \l_seu_ai_scope_data_bool }
          { \bool_set_true:N \l_seu_ai_scope_other_bool }
      }
  }

\cs_new:Npn \seu_ai_scope_box:N #1
  { \bool_if:NTF #1 { \ensuremath{\blacksquare} } { \ensuremath{\square} } }

\cs_new:Npn \seu_ai_item_row:nnnnn #1#2#3#4#5
  {
    \noindent
    \textbf{工具：}
    \tl_if_blank:nTF {#1} { 未填写 } { #1 }
    \quad
    \textbf{版本：}
    \tl_if_blank:nTF {#2} { 未填写 } { #2 }
    \par
    \textbf{使用范围：} #3 \par
    \textbf{使用过程：} #4 \par
    \textbf{章节（页码）：} #5
    \par\medskip
  }

\cs_new:Npn \seu_render_ai_rows:
  {
    \seq_if_empty:NTF \g_seu_ai_text_items_seq
      { \seu_ai_item_row:nnnnn { } { } { } { } { } }
      { \seq_map_inline:Nn \g_seu_ai_text_items_seq { ##1 } }
  }

\cs_new:Npn \seu_ai_item_table_row:nnnnn #1#2#3#4#5
  {
    \seu_tool_version:nn {#1} {#2} & #3 & #4 & #5 \\
    \hline
  }

\cs_new:Npn \seu_render_ai_table_rows:
  {
    \seq_if_empty:NTF \g_seu_ai_items_seq
      {
        \rule{0pt}{2.8cm} & & & \\
        \hline
      }
      { \seq_map_inline:Nn \g_seu_ai_items_seq { ##1 } }
  }

\cs_new_protected:Npn \seu_tl_append_par:Nn #1#2
  {
    \tl_if_empty:NTF #1
      { \tl_gset:Nn #1 {#2} }
      { \tl_gput_right:Nn #1 { \par #2 } }
  }
\cs_generate_variant:Nn \seu_tl_append_par:Nn { Nx }

\cs_new_protected:Npn \seu_insert_fullpage_background:n #1
  {
    \AddToShipoutPictureBG*
      {
        \AtPageLowerLeft
          {
            \includegraphics[width=\paperwidth,height=\paperheight]{#1}
          }
      }
  }

\cs_new_protected:Npn \seu_preface_title:n #1
  {
    \begin{center}
      {\seusanhao\bfseries #1 \par}
    \end{center}
    \vspace{1.0cm}
  }

\cs_new_protected:Npn \seu_make_cover:
  {
    \seublankmatter
    \seu_insert_fullpage_background:n { \seucoverbgimage }
    \begin{center}
      \vspace*{0.52cm}
      \includegraphics[width=8.56cm]{\seulogoimage}\par
      \vspace{1.10cm}
      \includegraphics[width=16.48cm]{\seudegreeimage}\par
      \vspace{1.10cm}
      \seu_cover_rule_box:nn
        { 12.0cm }
        { {\seucovertitlefont \seutitle} }\par
      \tl_if_blank:VTF \g_seu_subtitle_tl
        { }
        {
          \vspace{0.12cm}
          \seu_cover_rule_box:nn
            { 12.0cm }
            { {\seucoversubtitlefont \seusubtitle} }\par
        }
    \end{center}

    \vspace{0.60cm}
    \noindent
    \makebox[\textwidth][c]
      {
        \hspace*{0.35cm}
        \begin{tabular}{@{}p{3.43cm}@{\hspace{0.18cm}}p{7.99cm}@{}}
        \seu_cover_label:n { 学\hspace{1.8em}号： } & \seu_cover_value:n { \seustudentid } \\
        \seu_cover_label:n { 姓\hspace{1.8em}名： } & \seu_cover_value:n { \seuauthor } \\
        \seu_cover_label:n { 学\hspace{1.8em}院： } & \seu_cover_value:n { \seuschool } \\
        \seu_cover_label:n { 专\hspace{1.8em}业： } & \seu_cover_value:n { \seumajor } \\
        \seu_cover_label:n { 指导教师： } & \seu_cover_value:n { \seusupervisor } \\
        \seu_cover_label:n { 起止日期： } & \seu_cover_value:n { \seudaterange } \\
        \end{tabular}
      }

    \vfill
    \vspace*{-0.55cm}
    \begin{center}
      {\songti\fontsize{12pt}{15pt}\selectfont \seu_display_or_rule:nN { 10em } \g_seu_cover_date_tl \par}
    \end{center}
  }

\cs_new_protected:Npn \seu_make_statements_page:
  {
    \seublankmatter
    \begingroup
    \songti\fontsize{12pt}{15pt}\selectfont
    \setlength{\parindent}{2em}
    \vspace*{2.28cm}
    \begin{center}
      {\heiti\fontsize{18pt}{15pt}\selectfont 东南大学毕业（设计）论文独创性声明 \par}
    \end{center}

    \vspace{0.82cm}
    \begin{center}
      \begin{minipage}{15.55cm}
      本人声明所呈交的毕业（设计）论文是我个人在导师指导下进行的研究工作及取得的研究成果。
      尽我所知，除了文中特别加以标注和致谢的地方外，论文中不包含其他人已经发表或撰写过的研究成果，
      也不包含为获得东南大学或其它教育机构的学位或证书而使用过的材料。与我一同工作的同志对本研究所做的
      任何贡献均已在论文中作了明确的说明并表示了谢意。
      \end{minipage}
    \end{center}

    \vspace{0.76cm}
    \begin{center}
      论文作者签名：\seu_blank_rule:n { 8em }
      \qquad
      日期：\seu_display_or_date_placeholder:N \g_seu_originality_date_tl
    \end{center}

    \vspace{2.72cm}
    \begin{center}
      {\heiti\fontsize{18pt}{15pt}\selectfont 东南大学毕业（设计）论文使用授权声明 \par}
    \end{center}

    \vspace{0.82cm}
    \begin{center}
      \begin{minipage}{15.55cm}
      东南大学有权保留本人所送交毕业（设计）论文的复印件和电子文档，可以采用影印、缩印或其他复制手段保存论文。
      本人电子文档的内容和纸质论文的内容相一致。除在保密期内的保密论文外，允许论文被查阅和借阅，
      可以公布（包括刊登）论文的全部或部分内容。论文的公布（包括刊登）授权东南大学教务处办理。
      \end{minipage}
    \end{center}

    \vspace{0.78cm}
    \noindent
    \hspace*{0.55cm}
    \begin{minipage}[t]{0.40\textwidth}
      论文作者签名：\seu_blank_rule:n { 8em }\par
      日期：\seu_display_or_date_placeholder:N \g_seu_authorization_author_date_tl
    \end{minipage}
    \hfill
    \begin{minipage}[t]{0.40\textwidth}
      导师签名：\seu_blank_rule:n { 8em }\par
      日期：\seu_display_or_date_placeholder:N \g_seu_authorization_supervisor_date_tl
    \end{minipage}
    \endgroup
  }

\cs_new_protected:Npn \seu_make_originality_statement:
  {
    \seublankmatter
    \seu_preface_title:n { 东南大学毕业（设计）论文独创性声明 }
    \noindent
    本人声明所呈交的毕业（设计）论文是我个人在导师指导下进行的研究工作及取得的研究成果。
    尽我所知，除了文中特别加以标注和致谢的地方外，论文中不包含其他人已经发表或撰写过的研究成果，
    也不包含为获得东南大学或其它教育机构的学位或证书而使用过的材料。与我一同工作的同志对本研究所做的
    任何贡献均已在论文中作了明确的说明并表示了谢意。

    \vfill
    \noindent
    论文作者签名：\seu_blank_rule:n { 8em }
    \hfill
    日期：\seu_display_or_date_placeholder:N \g_seu_originality_date_tl
  }

\cs_new_protected:Npn \seu_make_authorization_statement:
  {
    \seublankmatter
    \seu_preface_title:n { 东南大学毕业（设计）论文使用授权声明 }
    \noindent
    东南大学有权保留本人所送交毕业（设计）论文的复印件和电子文档，可以采用影印、缩印或其他复制手段保存论文。
    本人电子文档的内容和纸质论文的内容相一致。除在保密期内的保密论文外，允许论文被查阅和借阅，
    可以公布（包括刊登）论文的全部或部分内容。论文的公布（包括刊登）授权东南大学教务处办理。

    \vfill
    \noindent
    \begin{minipage}[t]{0.44\textwidth}
      论文作者签名：\seu_blank_rule:n { 8em }\par
      日期：\seu_display_or_date_placeholder:N \g_seu_authorization_author_date_tl
    \end{minipage}
    \hfill
    \begin{minipage}[t]{0.44\textwidth}
      导师签名：\seu_blank_rule:n { 8em }\par
      日期：\seu_display_or_date_placeholder:N \g_seu_authorization_supervisor_date_tl
    \end{minipage}
  }

\cs_new_protected:Npn \seu_make_ai_statement:
  {
    \seublankmatter
    \seu_ai_scope_detect:
    \begin{center}
      {\seuaititlefont 东南大学本科毕业论文（设计）AI工具使用情况说明表 \par}
    \end{center}

    \vspace{0.16cm}
    \begingroup
    \seuaibodyfont
    \setlength{\arrayrulewidth}{0.5pt}
    \setlength{\tabcolsep}{0pt}
    \renewcommand{\arraystretch}{1}
    \noindent
    \makebox[\textwidth][c]{%
      \begin{tabular}{|p{3.02cm}|p{3.93cm}|p{3.48cm}|p{1.51cm}|p{3.25cm}|}
        \hline
        \parbox[c][0.88cm][c]{3.02cm}{\centering\seuaiheaderfont 课题名称}
          & \multicolumn{4}{>{\centering\arraybackslash}p{12.17cm}|}
              {\parbox[c][0.88cm][c]{12.17cm}{\centering\seuaibodyfont \seutitle}}
          \tabularnewline
        \hline
        \parbox[c][0.88cm][c]{3.02cm}{\centering\seuaiheaderfont 学\hspace{1.6em}号}
          & \parbox[c][0.88cm][c]{3.93cm}{\centering\seuaiboldvaluefont \seustudentid}
          & \parbox[c][0.88cm][c]{3.48cm}{\centering\seuaiheaderfont 姓\hspace{1.6em}名}
          & \multicolumn{2}{>{\centering\arraybackslash}p{4.76cm}|}
              {\parbox[c][0.88cm][c]{4.76cm}{\centering\seuaiboldvaluefont \seuauthor}}
          \tabularnewline
        \hline
        \parbox[c][0.88cm][c]{3.02cm}{\centering\seuaiheaderfont 是否使用生成式人工智能}
          & \multicolumn{4}{>{\centering\arraybackslash}p{12.17cm}|}
              {\parbox[c][0.88cm][c]{12.17cm}{\centering\seuaibodyfont \seu_yes_box:~是 \hspace{2.8cm} \seu_no_box:~否}}
          \tabularnewline
        \hline
        \parbox[c][0.88cm][c]{3.02cm}{\centering\seuaiheaderfont 工具、版本号}
          & \parbox[c][0.88cm][c]{3.93cm}{\centering\seuaiheaderfont 使用范围}
          & \multicolumn{2}{>{\centering\arraybackslash}p{4.99cm}|}
              {\parbox[c][0.88cm][c]{4.99cm}{\centering\seuaiheaderfont 使用过程}}
          & \parbox[c][0.88cm][c]{3.25cm}{\centering\seuaiheaderfont 章节（页码）}
          \tabularnewline
        \hline
        \parbox[t][3.53cm][t]{3.02cm}{\vspace{0pt}\raggedright\seuaibodyfont
          \colorbox{yellow!60}{选择是：}\par
          示例：\par
          \tl_if_empty:NTF \g_seu_ai_tool_display_tl { DeepSeek-V3 } { \g_seu_ai_tool_display_tl }}
          & \parbox[t][3.53cm][t]{3.93cm}{\vspace{0pt}\raggedright\seuaibodyfont
              \seu_ai_scope_box:N \l_seu_ai_scope_text_bool ~文本生成及内容修改\par
              \seu_ai_scope_box:N \l_seu_ai_scope_data_bool ~数据、图表分析、代码调试\par
              \seu_ai_scope_box:N \l_seu_ai_scope_other_bool ~其他：请具体说明
              \bool_if:NT \l_seu_ai_scope_other_bool
                {
                  \tl_if_blank:VF \g_seu_ai_scope_display_tl
                    { \par \g_seu_ai_scope_display_tl }
                }}
          & \multicolumn{2}{p{4.99cm}|}
              {\parbox[t][3.53cm][t]{4.99cm}{\vspace{0pt}\raggedright\seuaibodyfont
                示例：\par
                \tl_if_empty:NTF \g_seu_ai_process_display_tl
                  { 输入哪些关键词或主题，指导AI工具生成或修改了哪些内容 }
                  { \g_seu_ai_process_display_tl }}}
          & \parbox[t][3.53cm][t]{3.25cm}{\vspace{0pt}\raggedright\seuaibodyfont
              填写示例：\par
              \tl_if_empty:NTF \g_seu_ai_pages_display_tl
                { 第二章1.1（P5） }
                { \g_seu_ai_pages_display_tl }}
          \tabularnewline
        \hline
        \multicolumn{5}{|p{15.19cm}|}
          {\parbox[t][2.00cm][t]{15.19cm}{\vspace{0pt}\raggedright\seuaibodyfont
            \colorbox{yellow!60}{选择否：}\par
            填写示例：在本人毕业论文（设计）的撰写过程中，未使用任何生成式人工智能辅助工具。\par
            所有内容均由本人独立撰写和创作完成，能够确保学术诚信，不存在任何AI生成的内容。}}
          \tabularnewline
        \hline
        \parbox[c][3.15cm][c]{3.02cm}{\centering\seuaiheaderfont 学生诚信申明}
          & \multicolumn{4}{p{12.17cm}|}
              {\parbox[t][3.15cm][t]{12.17cm}{\vspace{0pt}\seuaibodylongfont\setlength{\parindent}{0.74cm}
                本人郑重声明，上述关于生成式人工智能使用情况的陈述真实无误，已对使用此类技术的所有细节进行了全面且诚实的报告。本人深知学术诚信的重要性，如有任何隐瞒或虚假之处，愿承担学术不端行为带来的相关惩处。\par
                \noindent\makebox[\linewidth][r]{学生签名：\seu_blank_rule:n { 5em }}\par
                \noindent\makebox[\linewidth][r]{\seu_display_or_date_placeholder:N \g_seu_ai_student_date_tl}}}
          \tabularnewline
        \hline
        \parbox[c][2.00cm][c]{3.02cm}{\centering\seuaiheaderfont 指导教师意见}
          & \multicolumn{4}{p{12.17cm}|}
              {\parbox[t][2.00cm][t]{12.17cm}{\vspace{0pt}\seuaibodylongfont
                意见：\tl_if_blank:VF \g_seu_ai_teacher_comment_tl { \g_seu_ai_teacher_comment_tl }\par
                \mbox{}\par
                \noindent\makebox[\linewidth][r]{指导教师签名：\seu_blank_rule:n { 5em }}\par
                \noindent\makebox[\linewidth][r]{\seu_display_or_date_placeholder:N \g_seu_ai_teacher_date_tl}}}
          \tabularnewline
        \hline
      \end{tabular}
    }
    \endgroup
  }

\cs_new_protected:Npn \seu_make_chinese_abstract:
  {
    \clearpage
    \thispagestyle{seupreface}
    \phantomsection
    \addcontentsline{toc}{chapter}{摘\hspace{2em}要}
    \seu_preface_title:n { 摘\hspace{2em}要 }
    \noindent
    \seuabstractzh
    \par
    \vspace{\baselineskip}
    \noindent
    \textbf{关键词：}\seukeywordszh
    \par
  }

\cs_new_protected:Npn \seu_make_english_abstract:
  {
    \clearpage
    \thispagestyle{seupreface}
    \phantomsection
    \addcontentsline{toc}{chapter}{ABSTRACT}
    \begin{center}
      {\rmfamily\bfseries\seusanhao ABSTRACT \par}
    \end{center}
    \vspace{1.0cm}
    \noindent
    {\rmfamily \seuabstracten \par}
    \vspace{\baselineskip}
    \noindent
    {\rmfamily \textbf{KEY WORDS:} \seukeywordsen \par}
  }

\cs_new_protected:Npn \seu_make_frontmatter:
  {
    \seumakecover
    \seu_make_statements_page:
    \seumakeaistatement
  }

\cs_new_protected:Npn \seu_make_motto_page:
  {
    \seublankmatter
    \seu_insert_fullpage_background:n { \seumottoimage }
    \null
  }

\NewDocumentCommand{\seusetup}{m}
  { \keys_set:nn { seu/setup } { #1 } }

\NewDocumentCommand{\seuaiitem}{m}
  {
    \tl_clear:N \l_seu_ai_tool_tl
    \tl_clear:N \l_seu_ai_version_tl
    \tl_clear:N \l_seu_ai_scope_tl
    \tl_clear:N \l_seu_ai_process_tl
    \tl_clear:N \l_seu_ai_pages_tl
    \keys_set:nn { seu/aiitem } { #1 }
    \seq_gput_right:Nx \g_seu_ai_items_seq
      {
        \exp_not:N \seu_ai_item_table_row:nnnnn
          { \exp_not:V \l_seu_ai_tool_tl }
          { \exp_not:V \l_seu_ai_version_tl }
          { \exp_not:V \l_seu_ai_scope_tl }
          { \exp_not:V \l_seu_ai_process_tl }
          { \exp_not:V \l_seu_ai_pages_tl }
      }
    \seq_gput_right:Nx \g_seu_ai_text_items_seq
      {
        \exp_not:N \seu_ai_item_row:nnnnn
          { \exp_not:V \l_seu_ai_tool_tl }
          { \exp_not:V \l_seu_ai_version_tl }
          { \exp_not:V \l_seu_ai_scope_tl }
          { \exp_not:V \l_seu_ai_process_tl }
          { \exp_not:V \l_seu_ai_pages_tl }
      }
    \seu_tl_append_par:Nx \g_seu_ai_tool_display_tl
      { \seu_tool_version:nn { \l_seu_ai_tool_tl } { \l_seu_ai_version_tl } }
    \seu_tl_append_par:Nx \g_seu_ai_scope_display_tl
      { \l_seu_ai_scope_tl }
    \seu_tl_append_par:Nx \g_seu_ai_process_display_tl
      { \l_seu_ai_process_tl }
    \seu_tl_append_par:Nx \g_seu_ai_pages_display_tl
      { \l_seu_ai_pages_tl }
  }

\NewDocumentCommand{\seutitle}{}       { \tl_use:N \g_seu_title_tl }
\NewDocumentCommand{\seusubtitle}{}    { \tl_use:N \g_seu_subtitle_tl }
\NewDocumentCommand{\seuauthor}{}      { \tl_use:N \g_seu_author_tl }
\NewDocumentCommand{\seustudentid}{}   { \tl_use:N \g_seu_student_id_tl }
\NewDocumentCommand{\seuschool}{}      { \tl_use:N \g_seu_school_tl }
\NewDocumentCommand{\seumajor}{}       { \tl_use:N \g_seu_major_tl }
\NewDocumentCommand{\seusupervisor}{}  { \tl_use:N \g_seu_supervisor_tl }
\NewDocumentCommand{\seudaterange}{}   { \tl_use:N \g_seu_date_range_tl }
\NewDocumentCommand{\seuabstractzh}{}  { \tl_use:N \g_seu_abstract_zh_tl }
\NewDocumentCommand{\seukeywordszh}{}  { \tl_use:N \g_seu_keywords_zh_tl }
\NewDocumentCommand{\seuabstracten}{}  { \tl_use:N \g_seu_abstract_en_tl }
\NewDocumentCommand{\seukeywordsen}{}  { \tl_use:N \g_seu_keywords_en_tl }
\NewDocumentCommand{\seucoverdate}{}   { \tl_use:N \g_seu_cover_date_tl }
\NewDocumentCommand{\seumottoimage}{}  { \tl_use:N \g_seu_motto_image_tl }
\NewDocumentCommand{\seuimagepath}{}   { \tl_use:N \g_seu_image_path_tl }
\NewDocumentCommand{\seulogoimage}{}   { \tl_use:N \g_seu_logo_image_tl }
\NewDocumentCommand{\seudegreeimage}{} { \tl_use:N \g_seu_degree_image_tl }
\NewDocumentCommand{\seucoverbgimage}{} { \tl_use:N \g_seu_cover_bg_image_tl }

\NewDocumentCommand{\seusetlatinfont}{m}
  { \setmainfont { #1 } }
\NewDocumentCommand{\seusetcjkmainfont}{m}
  { \setCJKmainfont { #1 } }
\NewDocumentCommand{\seusetcjksansfont}{m}
  { \setCJKsansfont { #1 } }

\NewDocumentCommand{\seuerhao}{}   { \zihao{2} }
\NewDocumentCommand{\seusanhao}{}  { \zihao{3} }
\NewDocumentCommand{\seusihao}{}   { \zihao{4} }
\NewDocumentCommand{\seuxiaosi}{}  { \zihao{-4} }
\NewDocumentCommand{\seuwuhao}{}   { \zihao{5} }
\NewDocumentCommand{\seuxiaowu}{}  { \zihao{-5} }
\NewDocumentCommand{\seuapplybodystyle}{} { \seu_apply_body_style: }
\NewDocumentCommand{\seumakecover}{} { \seu_make_cover: }
\NewDocumentCommand{\seumakeoriginalitystatement}{} { \seu_make_originality_statement: }
\NewDocumentCommand{\seumakeauthorizationstatement}{} { \seu_make_authorization_statement: }
\NewDocumentCommand{\seumakeaistatement}{} { \seu_make_ai_statement: }
\NewDocumentCommand{\seumakefrontmatter}{} { \seu_make_frontmatter: }
\NewDocumentCommand{\seumakechineseabstract}{} { \seu_make_chinese_abstract: }
\NewDocumentCommand{\seumakeenglishabstract}{} { \seu_make_english_abstract: }
\NewDocumentCommand{\seumottopage}{} { \seu_make_motto_page: }

\seu_apply_default_fonts:

\ExplSyntaxOff

\graphicspath{{imgs/}}
\raggedbottom
\hypersetup{
  unicode=true,
  hidelinks
}

\providecommand{\songti}{\CJKfamily{zhsong}}
\providecommand{\heiti}{\CJKfamily{zhhei}}
\providecommand{\kaishu}{\CJKfamily{zhkai}}
\providecommand{\fangsong}{\CJKfamily{zhfs}}
\IfFontExistsTF{思源黑体 CN Medium}
  {\newCJKfontfamily\seucoverlabelcjk{思源黑体 CN Medium}}
  {
    \IfFileExists{C:/Windows/Fonts/NotoSansSC-Medium.ttf}
      {
        \newCJKfontfamily\seucoverlabelcjk
          [
            Path = C:/Windows/Fonts/,
            Extension = .ttf,
            UprightFont = *
          ]
          {NotoSansSC-Medium}
      }
      {\newCJKfontfamily\seucoverlabelcjk{SimHei}}
  }

\newcommand{\seucovertitlefont}{\heiti\fontsize{22pt}{46pt}\selectfont}
\newcommand{\seucoversubtitlefont}{\fontsize{16pt}{46pt}\selectfont}
\newcommand{\seucoverlabelfont}{\seucoverlabelcjk\fontsize{14pt}{14pt}\selectfont}
\newcommand{\seucovervaluefont}{\songti\fontsize{18pt}{18pt}\selectfont}
\IfFileExists{C:/Windows/Fonts/NotoSerifSC-Bold.ttf}
  {
    \newCJKfontfamily\seuaiboldvaluecjk
      [
        Path = C:/Windows/Fonts/,
        Extension = .ttf,
        UprightFont = *
      ]
      {NotoSerifSC-Bold}
  }
  {\newcommand{\seuaiboldvaluecjk}{\bfseries}}
\IfFileExists{C:/Windows/Fonts/NotoSansSC-Bold.ttf}
  {
    \newCJKfontfamily\seuaiboldsanscjk
      [
        Path = C:/Windows/Fonts/,
        Extension = .ttf,
        UprightFont = *
      ]
      {NotoSansSC-Bold}
  }
  {\newcommand{\seuaiboldsanscjk}{\heiti}}
\newcommand{\seuaititlefont}{\seuaiboldsanscjk\fontsize{16pt}{18pt}\selectfont}
\newcommand{\seuaiheaderfont}{\seuaiboldsanscjk\fontsize{10.5pt}{12pt}\selectfont}
\newcommand{\seuaibodyfont}{\songti\fontsize{10.5pt}{12pt}\selectfont}
\newcommand{\seuaibodylongfont}{\songti\fontsize{10.5pt}{13.9pt}\selectfont}
\newcommand{\seuaiboldvaluefont}{\seuaiboldvaluecjk\fontsize{10.5pt}{12pt}\selectfont}

\fancypagestyle{seublank}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{seupreface}{
  \fancyhf{}
  \fancyfoot[C]{\normalfont\seuxiaowu \Roman{page}}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{seumain}{
  \fancyhf{}
  \fancyhead[C]{\normalfont\seuxiaowu 东南大学本科毕业设计（论文）}
  \fancyfoot[C]{\normalfont\seuxiaowu \thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyhead[C]{\normalfont\seuxiaowu 东南大学本科毕业设计（论文）}
  \fancyfoot[C]{\normalfont\seuxiaowu \thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\AtBeginDocument{
  \seuapplybodystyle
  \pagestyle{seublank}
}

\NewDocumentCommand{\seublankmatter}{}{
  \clearpage
  \pagenumbering{gobble}
  \pagestyle{seublank}
  \thispagestyle{seublank}
}

\NewDocumentCommand{\seuprefacematter}{}{
  \clearpage
  \pagenumbering{Roman}
  \setcounter{page}{1}
  \pagestyle{seupreface}
  \thispagestyle{seupreface}
}

\NewDocumentCommand{\seumainmatter}{}{
  \clearpage
  \pagenumbering{arabic}
  \setcounter{page}{1}
  \pagestyle{seumain}
  \thispagestyle{seumain}
}

\makeatletter
\NewDocumentCommand{\seumaketableofcontents}{}{
  \clearpage
  \thispagestyle{seupreface}
  \phantomsection
  \addcontentsline{toc}{chapter}{目\hspace{2em}录}
  \begin{center}
    {\seusanhao\bfseries 目\hspace{2em}录 \par}
  \end{center}
  \vspace{0.8cm}
  \@starttoc{toc}
}
\makeatother

\NewDocumentCommand{\seuprintbibliography}{}{
  \clearpage
  \begingroup
  \seuwuhao
  \sloppy
  \printbibliography[heading=seubibliography]
  \endgroup
}

\defbibheading{seubibliography}{
  \chapter*{参考文献}
  \addcontentsline{toc}{chapter}{参考文献}
}

\ctexset{
  chapter = {
    name = {第,章},
    number = \chinese{chapter},
    aftername = \quad,
    beforeskip = 0pt,
    afterskip = 18pt,
    format = \centering\heiti\seusanhao
  },
  section = {
    beforeskip = 12pt,
    afterskip = 6pt,
    format = \heiti\seusihao
  },
  subsection = {
    beforeskip = 10pt,
    afterskip = 4pt,
    format = \songti\normalfont\seuxiaosi
  }
}

\setcounter{tocdepth}{2}
\renewcommand{\contentsname}{目\hspace{2em}录}
\renewcommand{\cfttoctitlefont}{\hfill\seusanhao\bfseries}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftchapfont}{\seuxiaosi}
\renewcommand{\cftsecfont}{\seuxiaosi}
\renewcommand{\cftsubsecfont}{\seuxiaosi}
\renewcommand{\cftchappagefont}{\seuxiaosi}
\renewcommand{\cftsecpagefont}{\seuxiaosi}
\renewcommand{\cftsubsecpagefont}{\seuxiaosi}
\setlength{\cftbeforechapskip}{0pt}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}
\setlength{\cftchapindent}{0pt}
\setlength{\cftsecindent}{2\ccwd}
\setlength{\cftsubsecindent}{4\ccwd}
\setlength{\cftchapnumwidth}{4\ccwd}
\setlength{\cftsecnumwidth}{4\ccwd}
\setlength{\cftsubsecnumwidth}{5\ccwd}

\DeclareCaptionFont{seucaptionfont}{\seuwuhao\songti}
\captionsetup{
  font=seucaptionfont,
  labelfont=normalfont,
  labelsep=space,
  justification=centering,
  singlelinecheck=false
}
\captionsetup[figure]{position=bottom,skip=8pt}
\captionsetup[table]{position=top,skip=6pt}
\captionsetup[subfigure]{font=seucaptionfont,justification=centering}

\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}
\numberwithin{equation}{chapter}
\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}
\renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}

\setlength{\textfloatsep}{\baselineskip}
\setlength{\intextsep}{\baselineskip}
\setlength{\floatsep}{\baselineskip}
\allowdisplaybreaks[2]

\renewcommand{\thefootnote}{\ding{\numexpr171+\value{footnote}\relax}}
\makeatletter
\renewcommand\footnotesize{\zihao{-5}\selectfont}
\renewcommand\@makefntext[1]{%
  \parindent 1em\noindent
  \hb@xt@ 1.8em{\hss\@makefnmark}#1%
}
\makeatother
