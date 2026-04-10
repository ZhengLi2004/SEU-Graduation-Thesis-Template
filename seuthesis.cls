\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{seuthesis}[2026/04/04 Southeast University thesis template]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
\LoadClass[UTF8,oneside,openany,fontset=none]{ctexbook}

\RequirePackage[
  a4paper,
  includehead,
  top=1.65cm,
  bottom=2cm,
  left=2cm,
  right=2cm,
  bindingoffset=0.5cm,
  headheight=14.6pt,
  headsep=0.30cm,
  footskip=0.45cm
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
\usetikzlibrary{calc}
\RequirePackage{tikzpagenodes}
\RequirePackage{tabularray}
\RequirePackage{array}
\RequirePackage{ragged2e}
\RequirePackage{microtype}
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
  defernumbers=true,
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
\tl_new:N \g_seu_ai_subject_tl
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
\tl_gset:Nn \g_seu_ai_used_tl { unset }

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
    ai_subject .tl_gset:N = \g_seu_ai_subject_tl,
    ai_student_date .tl_gset:N = \g_seu_ai_student_date_tl,
    ai_teacher_date .tl_gset:N = \g_seu_ai_teacher_date_tl,
    ai_teacher_comment .tl_gset:N = \g_seu_ai_teacher_comment_tl,
    ai_used .choice:,
    ai_used / unset .code:n = { \tl_gset:Nn \g_seu_ai_used_tl { unset } },
    ai_used / yes .code:n = { \tl_gset:Nn \g_seu_ai_used_tl { yes } },
    ai_used / no .code:n = { \tl_gset:Nn \g_seu_ai_used_tl { no } },
    ai_used .initial:n = unset,
  }

\keys_define:nn { seu/aiitem }
  {
    tool .tl_set:N = \l_seu_ai_tool_tl,
    version .tl_set:N = \l_seu_ai_version_tl,
    scope .tl_set:N = \l_seu_ai_scope_tl,
    process .tl_set:N = \l_seu_ai_process_tl,
    pages .tl_set:N = \l_seu_ai_pages_tl,
  }

\cs_new_protected:Npn \seu_font_missing_error:nn #1#2
  {
    \ClassError { seuthesis }
      { Required~font~'#1'~not~found }
      {
        This~template~uses~strict~font~matching.
        Non-distributable~fonts~must~be~installed~in~the~operating~system.
        Distributable/open-source~fonts~must~be~placed~under~the~relative~directory~'fonts/'.
        Lookup~scope:~#2.
      }
  }

\cs_new_protected:Npn \seu_require_system_main_font:n #1
  {
    \IfFontExistsTF { #1 }
      { \setmainfont { #1 } [ Ligatures = TeX ] }
      { \seu_font_missing_error:nn {#1} {system-font-name lookup only} }
  }

\cs_new_protected:Npn \seu_require_system_cjk_main_font:n #1
  {
    \IfFontExistsTF { #1 }
      {
        \setCJKmainfont { #1 }
        \setCJKfamilyfont { zhsong } { #1 }
      }
      { \seu_font_missing_error:nn {#1} {system-font-name lookup only} }
  }

\cs_new_protected:Npn \seu_require_system_cjk_sans_font:n #1
  {
    \IfFontExistsTF { #1 }
      {
        \setCJKsansfont { #1 }
        \setCJKfamilyfont { zhhei } { #1 }
      }
      { \seu_font_missing_error:nn {#1} {system-font-name lookup only} }
  }

\cs_new_protected:Npn \seu_require_system_cjk_family_font:nn #1#2
  {
    \IfFontExistsTF { #2 }
      { \setCJKfamilyfont { #1 } { #2 } }
      { \seu_font_missing_error:nn {#2} {system-font-name lookup only} }
  }

\cs_new_protected:Npn \seu_set_cover_label_font:
  {
    \IfFontExistsTF { SimHei }
      { \setCJKfamilyfont { seucovershmedium } { SimHei } }
      {
        \IfFontExistsTF { 黑体 }
          { \setCJKfamilyfont { seucovershmedium } { 黑体 } }
          {
            \seu_font_missing_error:nn
              { SimHei~or~黑体 }
              {system-font-name~lookup~only}
          }
      }
  }

\cs_new_protected:Npn \seu_set_heading_font:
  {
    \IfFontExistsTF { SimHei }
      {
        \setCJKfamilyfont { seuheadingmedium } { SimHei }
        \setCJKfamilyfont { seuheadingbold } [ AutoFakeBold = { 4.5 } ] { SimHei }
      }
      {
        \IfFontExistsTF { 黑体 }
          {
            \setCJKfamilyfont { seuheadingmedium } { 黑体 }
            \setCJKfamilyfont { seuheadingbold } [ AutoFakeBold = { 4.5 } ] { 黑体 }
          }
          {
            \seu_font_missing_error:nn
              { SimHei~or~黑体 }
              {system-font-name~lookup~only}
          }
      }
  }

\cs_new_protected:Npn \seu_apply_default_fonts:
  {
    % Strict mode:
    % - no absolute paths
    % - no fallback / substitution / synthetic bold-slant
    % - non-distributable fonts: search system fonts only
    % - distributable fonts: search relative directory fonts/ only
    % Exact fonts required by the Word template.

    \seu_set_cover_label_font:
    \seu_set_heading_font:

    \seu_require_system_main_font:n { Times~New~Roman }

    \IfFontExistsTF { SimSun }
      { \seu_require_system_cjk_main_font:n { SimSun } }
      {
        \IfFontExistsTF { 宋体 }
          { \seu_require_system_cjk_main_font:n { 宋体 } }
          { \seu_font_missing_error:nn { SimSun~or~宋体 } {system-font-name lookup only} }
      }

    \IfFontExistsTF { SimHei }
      { \seu_require_system_cjk_sans_font:n { SimHei } }
      {
        \IfFontExistsTF { 黑体 }
          { \seu_require_system_cjk_sans_font:n { 黑体 } }
          { \seu_font_missing_error:nn { SimHei~or~黑体 } {system-font-name lookup only} }
      }

    \IfFontExistsTF { KaiTi }
      { \seu_require_system_cjk_family_font:nn { zhkai } { KaiTi } }
      {
        \IfFontExistsTF { 楷体 }
          { \seu_require_system_cjk_family_font:nn { zhkai } { 楷体 } }
          { \seu_font_missing_error:nn { KaiTi~or~楷体 } {system-font-name lookup only} }
      }

    \IfFontExistsTF { FangSong }
      {
        \setCJKmonofont { FangSong }
        \setCJKfamilyfont { zhfs } { FangSong }
      }
      {
        \IfFontExistsTF { 仿宋 }
          {
            \setCJKmonofont { 仿宋 }
            \setCJKfamilyfont { zhfs } { 仿宋 }
          }
          { \seu_font_missing_error:nn { FangSong~or~仿宋 } {system-font-name lookup only} }
      }
  }

\cs_new_protected:Npn \seu_apply_body_style:
  {
    \normalfont
    \rmfamily
    \songti
    \seuxiaosi\selectfont
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

\cs_new:Npn \seu_statement_signature_rule:
  { \underline{\makebox[3.15cm][c]{\strut}} }

\cs_new:Npn \seu_statement_date_placeholder:
  {
    \underline{\makebox[1.05cm][c]{\strut}}年\hspace{0.28em}
    \underline{\makebox[0.95cm][c]{\strut}}月\hspace{0.28em}
    \underline{\makebox[0.95cm][c]{\strut}}日
  }

\cs_new:Npn \seu_display_or_statement_date:N #1
  { \tl_if_blank:VTF #1 { \seu_statement_date_placeholder: } { \tl_use:N #1 } }

\cs_new:Npn \seu_ai_date_placeholder:
  {
    \makebox[1.05cm][c]{}年\hspace{0.28em}
    \makebox[0.95cm][c]{}月\hspace{0.28em}
    \makebox[0.95cm][c]{}日
  }

\cs_new:Npn \seu_display_or_ai_date:N #1
  { \tl_if_blank:VTF #1 { \seu_ai_date_placeholder: } { \tl_use:N #1 } }

\cs_new:Npn \seu_ai_date_line:N #1
  {
    \tl_if_blank:VTF #1
      { 日期：\hspace{1.8em}年\hspace{1.8em}月\hspace{1.8em}日 }
      { 日期：\tl_use:N #1 }
  }

\cs_new:Npn \seu_ai_signature_space:
  { \makebox[2.85cm][c]{} }

\cs_new:Npn \seu_cover_date_display:
  { \tl_if_blank:VTF \g_seu_cover_date_tl { \seu_date_placeholder: } { \tl_use:N \g_seu_cover_date_tl } }

\cs_new_protected:Npn \seu_cover_draw_horizontal_rule:nnn #1#2#3
  {
    \draw[line\c_space_tl width=0.15pt]
      ($(current\c_space_tl page.north\c_space_tl west)+(#1,-#2)$) --
      ++(#3,0);
  }

\cs_new_protected:Npn \seu_cover_draw_center_text:nnn #1#2#3
  {
    \node[anchor=center,inner\c_space_tl sep=0pt,outer\c_space_tl sep=0pt]
      at ($(current\c_space_tl page.north\c_space_tl west)+(#1,-#2)$)
      {#3};
  }

\cs_new_protected:Npn \seu_cover_draw_label:nn #1#2
  {
    \node[
      anchor=west,
      inner\c_space_tl sep=0pt,
      outer\c_space_tl sep=0pt,
      text\c_space_tl width=3.436cm,
      align=left
    ]
      at ($(current\c_space_tl page.north\c_space_tl west)+(5.21cm,-#1)$)
      {{\seucoverlabelfont #2}};
  }

\cs_new_protected:Npn \seu_cover_draw_value:nn #1#2
  {
    \node[
      anchor=center,
      inner\c_space_tl sep=0pt,
      outer\c_space_tl sep=0pt,
      text\c_space_tl width=7.976cm,
      align=center
    ]
      at ($(current\c_space_tl page.north\c_space_tl west)+(12.45cm,-#1)$)
      {{\seucovervaluefont #2}};
  }

\cs_new_protected:Npn \seu_cover_draw_field_row:nnn #1#2#3
  {
    \seu_cover_draw_label:nn {#1} {#2}
    \seu_cover_draw_value:nn {#1} {#3}
    \seu_cover_draw_horizontal_rule:nnn { 8.46cm } { \fp_eval:n {#1 + 0.44} cm } { 7.976cm }
  }

\cs_new_protected:Npn \seu_statement_draw_text:nnn #1#2#3
  {
    \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt,outer\c_space_tl sep=0pt]
      at ($(current\c_space_tl page.north\c_space_tl west)+(#1,-#2)$)
      {#3};
  }

\cs_new:Npn \seu_cover_rule_box:nn #1#2
  {
    \parbox[c][1.84cm][c]{#1}
      {
        \centering
        \vbox to 1.84cm
          {
            \vfil
            \hbox to #1 { \hfil #2 \hfil }
            \vspace{0.17cm}
            \hrule height 0.2pt
          }
      }
  }

\cs_new:Npn \seu_cover_note_box:nn #1#2
  {
    \parbox[c][1.20cm][c]{#1}
      {
        \centering
        \vbox to 1.20cm
          {
            \vfil
            \hbox to #1 { \hfil #2 \hfil }
            \vspace{0.14cm}
            \hrule height 0.2pt
          }
      }
  }

\cs_new:Npn \seu_cover_label:n #1
  {
    \parbox[c][1.00cm][c]{3.436cm}
      {
        \vbox to 1.00cm
          {
            \vfil
            \hbox to 3.436cm { \seucoverlabelfont #1 \hfil }
            \vfil
          }
      }
  }

\cs_new:Npn \seu_cover_value:n #1
  {
    \parbox[c][1.00cm][c]{7.992cm}
      {
        \centering
        \vbox to 1.00cm
          {
            \vfil
            \hbox to 7.992cm { \hfil \seucovervaluefont #1 \strut \hfil }
            \vspace{0.14cm}
            \hrule height 0.2pt width 7.992cm
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

\cs_new:Npn \seu_highlight_label:n #1
  {
    \tikz[baseline=(seulabel.base)]
      \node[
        fill=yellow!60,
        inner\c_space_tl xsep=0.9pt,
        inner\c_space_tl ysep=0pt,
        outer\c_space_tl sep=0pt,
        anchor=base
      ] (seulabel) { {\songti\fontsize{10.5pt}{12pt}\selectfont \strut #1} };
  }

\cs_new:Npn \seu_ai_justified_box:nn #1#2
  {
    \parbox[t]{#1}
      {
        \microtypesetup{protrusion=true}
        \setlength{\parindent}{0pt}
        \setlength{\parskip}{0pt}
        \justifying
        #2
      }
  }

\cs_new:Npn \seu_ai_plain_box:nn #1#2
  {
    \parbox[t]{#1}
      {
        \setlength{\parindent}{0pt}
        \setlength{\parskip}{0pt}
        \RaggedRight
        #2
      }
  }

\cs_new:Npn \seu_ai_indented_justified_box:nn #1#2
  {
    \parbox[t]{#1}
      {
        \microtypesetup{protrusion=true}
        \setlength{\parindent}{2em}
        \setlength{\parskip}{0pt}
        \justifying
        #2
      }
  }

\cs_new:Npn \seu_ai_signature_line:Nn #1#2
  {
    \makebox[0pt][l]
      {
        #2：\hspace{1.8em}\makebox[4.4em][l]{}
        \hspace{1.8em}\seu_display_or_ai_date:N #1
      }
  }

\cs_new:Npn \seu_ai_signature_date_block:Nn #1#2
  {
    \parbox[t]{11.4em}
      {
        \seuaibodyfont
        \setlength{\parindent}{0pt}
        \setlength{\parskip}{0pt}
        #2 \par
        \vspace{4pt}
        日期：\seu_display_or_ai_date:N #1
      }
  }

\cs_new:Npn \seu_ai_subject_display:
  { \tl_use:N \g_seu_ai_subject_tl }

\cs_new:Npn \seu_ai_tool_display_or_blank:
  {
    \tl_if_empty:NTF \g_seu_ai_tool_display_tl
      { }
      { \g_seu_ai_tool_display_tl }
  }

\cs_new:Npn \seu_ai_process_display_or_blank:
  {
    \tl_if_empty:NTF \g_seu_ai_process_display_tl
      { }
      { \g_seu_ai_process_display_tl }
  }

\cs_new:Npn \seu_ai_pages_display_or_blank:
  {
    \tl_if_empty:NTF \g_seu_ai_pages_display_tl
      { }
      { \g_seu_ai_pages_display_tl }
  }

\cs_new:Npn \seu_ai_yes_tool_block:
  {
    \seu_highlight_label:n { 选择是： }\par
    \str_if_eq:eeTF { \tl_use:N \g_seu_ai_used_tl } { unset }
      { 示例：\par DeepSeek-V3 }
      {
        \str_if_eq:eeTF { \tl_use:N \g_seu_ai_used_tl } { yes }
          {
            \tl_if_empty:NTF \g_seu_ai_tool_display_tl
              { }
              { \g_seu_ai_tool_display_tl }
          }
          { }
      }
  }

\cs_new:Npn \seu_ai_yes_scope_block:
  {
    \str_if_eq:eeTF { \tl_use:N \g_seu_ai_used_tl } { no }
      { }
      {
        \seu_ai_scope_box:N \l_seu_ai_scope_text_bool ~文本生成及内容修改\par
        \seu_ai_scope_box:N \l_seu_ai_scope_data_bool ~数据、图表分析、代码调试\par
        \seu_ai_scope_box:N \l_seu_ai_scope_other_bool ~其他：请具体说明
        \bool_if:NT \l_seu_ai_scope_other_bool
          {
            \tl_if_blank:VF \g_seu_ai_scope_display_tl
              { \par \g_seu_ai_scope_display_tl }
          }
      }
  }

\cs_new:Npn \seu_ai_yes_process_block:
  {
    \str_if_eq:eeTF { \tl_use:N \g_seu_ai_used_tl } { unset }
      { 示例：\\ 输入哪些关键词或主题，指\\ 导AI工具生成或修改了哪些\\ 内容 }
      {
        \str_if_eq:eeTF { \tl_use:N \g_seu_ai_used_tl } { yes }
          { \seu_ai_process_display_or_blank: }
          { }
      }
  }

\cs_new:Npn \seu_ai_yes_pages_block:
  {
    \str_if_eq:eeTF { \tl_use:N \g_seu_ai_used_tl } { unset }
      { 填写示例：\par 第二章1.1（P5） }
      {
        \str_if_eq:eeTF { \tl_use:N \g_seu_ai_used_tl } { yes }
          { \seu_ai_pages_display_or_blank: }
          { }
      }
  }

\cs_new:Npn \seu_ai_no_block:
  {
    \seu_highlight_label:n { 选择否： }\par
    \str_if_eq:eeTF { \tl_use:N \g_seu_ai_used_tl } { yes }
      { }
      {
        填写示例：在本人毕业论文（设计）的撰写过程中，未使用任何生成式人工智能辅助工具。\par
        所有内容均由本人独立撰写和创作完成，能够确保学术诚信，不存在任何AI生成的内容。
      }
  }

\cs_new:Npn \seu_ai_student_statement_block:
  {
    本人郑重声明，上述关于生成式人工智能使用情况的陈述真实无误，\\
    已对使用此类技术的所有细节进行了全面且诚实的报告。本人深知学术诚\\
    信的重要性，如有任何隐瞒或虚假之处，愿承担学术不端行为带来的相关\\
    惩处。
  }

\cs_new:Npn \seu_ai_teacher_statement_block:
  {
    意见：\tl_if_blank:VF \g_seu_ai_teacher_comment_tl { \g_seu_ai_teacher_comment_tl }
  }

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

\cs_new:Npn \seu_ai_title_cell:nn #1#2
  {
    \parbox[c][#2][c]{3.023cm}
      {
        \centering
        \seuaiheaderfont #1
      }
  }

\cs_new:Npn \seu_ai_body_cell:nnn #1#2#3
  {
    \parbox[c][#2][c]{#1}
      {
        \centering
        #3
      }
  }

\cs_new:Npn \seu_ai_item_row:nnnnn #1#2#3#4#5
  {
    \noindent
    {\seuaiheaderfont 工具：}
    \tl_if_blank:nTF {#1} { 未填写 } { #1 }
    \quad
    {\seuaiheaderfont 版本：}
    \tl_if_blank:nTF {#2} { 未填写 } { #2 }
    \par
    {\seuaiheaderfont 使用范围：} #3 \par
    {\seuaiheaderfont 使用过程：} #4 \par
    {\seuaiheaderfont 章节（页码）：} #5
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

\cs_new_protected:Npn \seu_make_cover_fields_table:
  {
    \renewcommand{\arraystretch}{1}
    \begin{tabular}{@{}m{3.436cm}@{\hspace{0.20cm}}m{7.992cm}@{}}
    \seu_cover_label:n { 学\hspace{1.8em}号： } & \seu_cover_value:n { \seustudentid } \\[0.22cm]
    \seu_cover_label:n { 姓\hspace{1.8em}名： } & \seu_cover_value:n { \seuauthor } \\[0.22cm]
    \seu_cover_label:n { 学\hspace{1.8em}院： } & \seu_cover_value:n { \seuschool } \\[0.22cm]
    \seu_cover_label:n { 专\hspace{1.8em}业： } & \seu_cover_value:n { \seumajor } \\[0.22cm]
    \seu_cover_label:n { 指导教师： } & \seu_cover_value:n { \seusupervisor } \\[0.22cm]
    \seu_cover_label:n { 起止日期： } & \seu_cover_value:n { \seudaterange } \\
    \end{tabular}
  }

\cs_new_protected:Npn \seu_preface_title:n #1
  {
    \par
    {
      \centering
      {\seuboldheiti\seusanhao #1 \par}
    }
    \vspace{0.24cm}
  }

\cs_new_protected:Npn \seu_compact_preface_title:n #1
  {
    \vspace*{-8pt}
    {
      \centering
      {\seuboldheiti\seusanhao #1 \par}
    }
    \vspace{0.12cm}
  }

\cs_new_protected:Npn \seu_compact_english_preface_title:n #1
  {
    \vspace*{-12pt}
    {
      \centering
      {\rmfamily\fontseries{b}\selectfont\seusanhao #1 \par}
    }
    \vspace{0.12cm}
  }

\cs_new_protected:Npn \seu_make_cover:
  {
    \seublankmatter
    \seu_insert_fullpage_background:n { \seucoverbgimage }
    \begin{tikzpicture}[remember\c_space_tl picture,overlay]
      \node[anchor=north,inner\c_space_tl sep=0pt]
        at ($(current\c_space_tl page.north)+(0.23cm,-4.06cm)$)
        {\includegraphics[width=8.56cm]{\seulogoimage}};

      \node[anchor=north,inner\c_space_tl sep=0pt]
        at ($(current\c_space_tl page.north)+(0.23cm,-6.74cm)$)
        {\includegraphics[width=16.48cm]{\seudegreeimage}};

      \seu_cover_draw_center_text:nnn
        { 10.73cm }
        { 11.79cm }
        { {\seucovertitlefont \seutitle} }
      \seu_cover_draw_horizontal_rule:nnn { 4.31cm } { 12.38cm } { 12.843cm }

      \tl_if_blank:VTF \g_seu_subtitle_tl
        { }
        {
          \seu_cover_draw_center_text:nnn
            { 10.73cm }
            { 13.50cm }
            { {\seucovernotefont \seusubtitle} }
          \seu_cover_draw_horizontal_rule:nnn { 4.28cm } { 14.03cm } { 12.843cm }
        }

      \seu_cover_draw_field_row:nnn { 15.64 } { 学\hspace{1.8em}号： } { \seustudentid }
      \seu_cover_draw_field_row:nnn { 16.78 } { 姓\hspace{1.8em}名： } { \seuauthor }
      \seu_cover_draw_field_row:nnn { 17.92 } { 学\hspace{1.8em}院： } { \seuschool }
      \seu_cover_draw_field_row:nnn { 19.06 } { 专\hspace{1.8em}业： } { \seumajor }
      \seu_cover_draw_field_row:nnn { 20.20 } { 指导教师： } { \seusupervisor }
      \seu_cover_draw_field_row:nnn { 21.34 } { 起止日期： } { \seudaterange }

      \seu_cover_draw_center_text:nnn
        { 11.00cm }
        { 24.05cm }
        { {\seucoverdatefont \seu_cover_date_display:} };
    \end{tikzpicture}
    \null
  }

\cs_new_protected:Npn \seu_make_statements_page:
  {
    \seublankmatter
    \begingroup
    \begin{tikzpicture}[remember\c_space_tl picture,overlay]
      \node[anchor=north,inner\c_space_tl sep=0pt]
        at ($(current\c_space_tl page.north)+(1.04cm,-4.73cm)$)
        {{\CJKfamily{seuheadingmedium}\fontsize{18pt}{18pt}\selectfont 东南大学毕业（设计）论文独创性声明}};

      \seu_statement_draw_text:nnn { 3.35cm } { 6.83cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 本人声明所呈交的毕业（设计）论文是我个人在导师指导下进行的研究工作及取得的}};
      \seu_statement_draw_text:nnn { 2.50cm } { 7.52cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 研究成果。尽我所知，除了文中特别加以标注和致谢的地方外，论文中不包含其他人已经}};
      \seu_statement_draw_text:nnn { 2.50cm } { 8.21cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 发表或撰写过的研究成果，也不包含为获得东南大学或其它教育机构的学位或证书而使用}};
      \seu_statement_draw_text:nnn { 2.50cm } { 8.90cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并}};
      \seu_statement_draw_text:nnn { 2.50cm } { 9.59cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 表示了谢意。}};

      \seu_statement_draw_text:nnn { 4.19cm } { 10.96cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 论文作者签名：}};
      \seu_cover_draw_horizontal_rule:nnn { 7.06cm } { 11.37cm } { 3.38cm }
      \seu_statement_draw_text:nnn { 11.10cm } { 10.96cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 日期：}};
      \tl_if_blank:VTF \g_seu_originality_date_tl
        {
          \seu_cover_draw_horizontal_rule:nnn { 12.45cm } { 11.37cm } { 1.47cm }
          \seu_cover_draw_horizontal_rule:nnn { 14.35cm } { 11.37cm } { 1.05cm }
          \seu_cover_draw_horizontal_rule:nnn { 15.83cm } { 11.37cm } { 1.05cm }
          \seu_statement_draw_text:nnn { 14.02cm } { 10.96cm } {{\songti\fontsize{12pt}{12pt}\selectfont 年}}
          \seu_statement_draw_text:nnn { 15.49cm } { 10.96cm } {{\songti\fontsize{12pt}{12pt}\selectfont 月}}
          \seu_statement_draw_text:nnn { 16.96cm } { 10.96cm } {{\songti\fontsize{12pt}{12pt}\selectfont 日}}
        }
        {
          \seu_statement_draw_text:nnn { 12.45cm } { 10.96cm }
            {{\songti\fontsize{12pt}{12pt}\selectfont \tl_use:N \g_seu_originality_date_tl}};
        }

      \node[anchor=north,inner\c_space_tl sep=0pt]
        at ($(current\c_space_tl page.north)+(1.04cm,-16.97cm)$)
        {{\CJKfamily{seuheadingmedium}\fontsize{18pt}{18pt}\selectfont 东南大学毕业（设计）论文使用授权声明}};

      \seu_statement_draw_text:nnn { 3.35cm } { 18.66cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 东南大学有权保留本人所送交毕业（设计）论文的复印件和电子文档，可以采用影印、}};
      \seu_statement_draw_text:nnn { 2.50cm } { 19.35cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 缩印或其他复制手段保存论文。本人电子文档的内容和纸质论文的内容相一致。除在保密}};
      \seu_statement_draw_text:nnn { 2.50cm } { 20.04cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 期内的保密论文外，允许论文被查阅和借阅，可以公布（包括刊登）论文的全部或部分内}};
      \seu_statement_draw_text:nnn { 2.50cm } { 20.73cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 容。论文的公布（包括刊登）授权东南大学教务处办理。}};

      \seu_statement_draw_text:nnn { 3.35cm } { 22.10cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 论文作者签名：}};
      \seu_cover_draw_horizontal_rule:nnn { 6.31cm } { 22.50cm } { 4.02cm }
      \seu_statement_draw_text:nnn { 11.00cm } { 22.10cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 导师签名：}};
      \seu_cover_draw_horizontal_rule:nnn { 13.30cm } { 22.50cm } { 4.86cm }

      \seu_statement_draw_text:nnn { 3.35cm } { 22.71cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 日期：}};
      \tl_if_blank:VTF \g_seu_authorization_author_date_tl
        {
          \seu_cover_draw_horizontal_rule:nnn { 4.62cm } { 23.20cm } { 1.47cm }
          \seu_cover_draw_horizontal_rule:nnn { 6.53cm } { 23.20cm } { 1.26cm }
          \seu_cover_draw_horizontal_rule:nnn { 8.22cm } { 23.20cm } { 1.26cm }
          \seu_statement_draw_text:nnn { 6.20cm } { 22.71cm } {{\songti\fontsize{12pt}{12pt}\selectfont 年}}
          \seu_statement_draw_text:nnn { 7.92cm } { 22.71cm } {{\songti\fontsize{12pt}{12pt}\selectfont 月}}
          \seu_statement_draw_text:nnn { 9.60cm } { 22.71cm } {{\songti\fontsize{12pt}{12pt}\selectfont 日}}
        }
        {
          \seu_statement_draw_text:nnn { 4.62cm } { 22.71cm }
            {{\songti\fontsize{12pt}{12pt}\selectfont \tl_use:N \g_seu_authorization_author_date_tl}};
        }

      \seu_statement_draw_text:nnn { 11.00cm } { 22.71cm }
        {{\songti\fontsize{12pt}{12pt}\selectfont 日期：}};
      \tl_if_blank:VTF \g_seu_authorization_supervisor_date_tl
        {
          \seu_cover_draw_horizontal_rule:nnn { 12.45cm } { 23.20cm } { 1.05cm }
          \seu_cover_draw_horizontal_rule:nnn { 13.94cm } { 23.20cm } { 1.26cm }
          \seu_cover_draw_horizontal_rule:nnn { 15.63cm } { 23.20cm } { 1.25cm }
          \seu_statement_draw_text:nnn { 13.65cm } { 22.71cm } {{\songti\fontsize{12pt}{12pt}\selectfont 年}}
          \seu_statement_draw_text:nnn { 15.33cm } { 22.71cm } {{\songti\fontsize{12pt}{12pt}\selectfont 月}}
          \seu_statement_draw_text:nnn { 17.01cm } { 22.71cm } {{\songti\fontsize{12pt}{12pt}\selectfont 日}}
        }
        {
          \seu_statement_draw_text:nnn { 12.45cm } { 22.71cm }
            {{\songti\fontsize{12pt}{12pt}\selectfont \tl_use:N \g_seu_authorization_supervisor_date_tl}};
        }
    \end{tikzpicture}
    \null
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
    \begingroup
    \begin{tikzpicture}[remember\c_space_tl picture,overlay,line\c_space_tl width=0.5pt]
      \coordinate (seuainw) at (current\c_space_tl page.north\c_space_tl west);
      \def\seuaisharedlineone{-261.83pt}
      \def\seuaisharedlinetwo{-277.65pt}
      \def\seuaisharedlinethree{-293.18pt}
      \def\seuaisharedlinefour{-308.96pt}
      \node[anchor=north,inner\c_space_tl sep=0pt]
        at ($(seuainw)+(304.73pt,-102.92pt)$)
        {{\seuaititlefont 东南大学本科毕业论文（设计）AI 工具使用情况说明表}};

      \draw ($(seuainw)+(89.10pt,-126.90pt)$) -- ($(seuainw)+(520.02pt,-126.90pt)$);
      \draw ($(seuainw)+(89.10pt,-152.46pt)$) -- ($(seuainw)+(520.02pt,-152.46pt)$);
      \draw ($(seuainw)+(89.10pt,-177.66pt)$) -- ($(seuainw)+(520.02pt,-177.66pt)$);
      \draw ($(seuainw)+(89.10pt,-225.18pt)$) -- ($(seuainw)+(520.02pt,-225.18pt)$);
      \draw ($(seuainw)+(89.10pt,-250.38pt)$) -- ($(seuainw)+(520.02pt,-250.38pt)$);
      \draw ($(seuainw)+(89.10pt,-351.18pt)$) -- ($(seuainw)+(520.02pt,-351.18pt)$);
      \draw ($(seuainw)+(89.10pt,-408.42pt)$) -- ($(seuainw)+(520.02pt,-408.42pt)$);
      \draw ($(seuainw)+(89.10pt,-585.54pt)$) -- ($(seuainw)+(520.02pt,-585.54pt)$);
      \draw ($(seuainw)+(89.10pt,-690.30pt)$) -- ($(seuainw)+(520.02pt,-690.30pt)$);

      \draw ($(seuainw)+(89.10pt,-126.90pt)$) -- ($(seuainw)+(89.10pt,-690.30pt)$);
      \draw ($(seuainw)+(174.78pt,-126.90pt)$) -- ($(seuainw)+(174.78pt,-351.18pt)$);
      \draw ($(seuainw)+(174.78pt,-408.42pt)$) -- ($(seuainw)+(174.78pt,-690.30pt)$);
      \draw ($(seuainw)+(289.10pt,-152.46pt)$) -- ($(seuainw)+(289.10pt,-177.66pt)$);
      \draw ($(seuainw)+(289.10pt,-225.18pt)$) -- ($(seuainw)+(289.10pt,-351.18pt)$);
      \draw ($(seuainw)+(384.93pt,-152.46pt)$) -- ($(seuainw)+(384.93pt,-177.66pt)$);
      \draw ($(seuainw)+(427.86pt,-225.18pt)$) -- ($(seuainw)+(427.86pt,-351.18pt)$);
      \draw ($(seuainw)+(520.02pt,-126.90pt)$) -- ($(seuainw)+(520.02pt,-690.30pt)$);

      \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=85.68pt,align=center]
        at ($(seuainw)+(135.60pt,-140.47pt)$)
        {{\seuaiheaderfont 课题名称}};
      \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=345.24pt,align=center]
        at ($(seuainw)+(347.40pt,-139.68pt)$)
        {{\seuaibodyfont \seu_ai_subject_display:}};

      \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=85.68pt,align=center]
        at ($(seuainw)+(131.94pt,-165.06pt)$)
        {{\seuaiheaderfont 学\hspace{1.6em}号}};
      \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=111.60pt,align=center]
        at ($(seuainw)+(230.58pt,-165.06pt)$)
        {{\seuaiboldvaluefont \seustudentid}};
      \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=98.55pt,align=center]
        at ($(seuainw)+(335.66pt,-165.06pt)$)
        {{\seuaiheaderfont 姓\hspace{1.6em}名}};
      \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=135.09pt,align=center]
        at ($(seuainw)+(452.48pt,-165.06pt)$)
        {{\seuaiboldvaluefont \seuauthor}};

      \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=72.22pt,align=center]
        at ($(seuainw)+(132.25pt,-201.42pt)$)
        {{\seuaiheaderfont 是否使用生成\\式人工智能}};
      \node[anchor=center,inner\c_space_tl sep=0pt]
        at ($(seuainw)+(271.01pt,-201.42pt)$)
        {{\seuaibodyfont \seu_yes_box:}};
      \node[anchor=center,inner\c_space_tl sep=0pt]
        at ($(seuainw)+(283.10pt,-201.42pt)$)
        {{\seuaibodyfont 是}};
      \node[anchor=center,inner\c_space_tl sep=0pt]
        at ($(seuainw)+(401.59pt,-201.42pt)$)
        {{\seuaibodyfont \seu_no_box:}};
      \node[anchor=center,inner\c_space_tl sep=0pt]
        at ($(seuainw)+(413.68pt,-201.42pt)$)
        {{\seuaibodyfont 否}};

      \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=85.68pt,align=center]
        at ($(seuainw)+(131.94pt,-237.78pt)$)
        {{\seuaiheaderfont 工具、版本号}};
      \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=111.60pt,align=center]
        at ($(seuainw)+(235.80pt,-238.99pt)$)
        {{\seuaiheaderfont 使用范围}};
      \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=141.48pt,align=center]
        at ($(seuainw)+(365.07pt,-238.99pt)$)
        {{\seuaiheaderfont 使用过程}};
      \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=92.16pt,align=center]
        at ($(seuainw)+(473.94pt,-237.78pt)$)
        {{\seuaiheaderfont 章节（页码）}};

      \str_if_eq:eeTF { \tl_use:N \g_seu_ai_used_tl } { unset }
        {
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(94.08pt,-273.82pt)$)
            {{\seuaibodyfont \seu_highlight_label:n { 选择是： }}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(94.97pt,-294.55pt)$)
            {{\seuaibodyfont 示例：}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(94.97pt,-313.08pt)$)
            {{\seuaibodyfont DeepSeek-V3}};

          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(180.92pt,\seuaisharedlineone)$)
            {{\seuaibodyfont □文本生成及内容修}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(180.92pt,\seuaisharedlinetwo)$)
            {{\seuaibodyfont 改}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(180.92pt,\seuaisharedlinethree)$)
            {{\seuaibodyfont □数据、图表分析、代}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(180.92pt,\seuaisharedlinefour)$)
            {{\seuaibodyfont 码调试}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(180.92pt,-328.31pt)$)
            {{\seuaibodyfont □其他：请具体说明}};

          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(292.74pt,\seuaisharedlineone)$)
            {{\seuaibodyfont 示例：}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(292.74pt,\seuaisharedlinetwo)$)
            {{\seuaibodyfont 输入哪些关键词或主题，指}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(292.74pt,\seuaisharedlinethree)$)
            {{\seuaibodyfont 导AI工具生成或修改了哪些}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(292.74pt,\seuaisharedlinefour)$)
            {{\seuaibodyfont 内容}};

          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(434.76pt,-289.71pt)$)
            {{\seuaibodyfont 填写示例：}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(434.30pt,-301.33pt)$)
            {{\seuaibodyfont 第二章1.1（P5）}};

          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(94.08pt,-351.99pt)$)
            {{\seuaibodyfont \seu_highlight_label:n { 选择否： }}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(94.82pt,-371.31pt)$)
            {{\seuaibodyfont 填写示例：在本人毕业论文（设计）的撰写过程中，未使用任何生成式人工智能辅助工具。}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(94.82pt,-386.59pt)$)
            {{\seuaibodyfont 所有内容均由本人独立撰写和创作完成，能够确保学术诚信，不存在任何AI生成的内容。}};

          \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=72.22pt,align=center]
            at ($(seuainw)+(131.21pt,-499.06pt)$)
            {{\seuaiheaderfont 学生诚信申明}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(200.01pt,-414.31pt)$)
            {{\seuaibodylongfont 本人郑重声明，上述关于生成式人工智能使用情况的陈述真实无误，}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(178.92pt,-432.48pt)$)
            {{\seuaibodylongfont 已对使用此类技术的所有细节进行了全面且诚实的报告。本人深知学术诚}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(178.92pt,-450.71pt)$)
            {{\seuaibodylongfont 信的重要性，如有任何隐瞒或虚假之处，愿承担学术不端行为带来的相关}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(178.92pt,-468.81pt)$)
            {{\seuaibodylongfont 惩处。}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(391.76pt,-521.21pt)$)
            {{\seuaibodyfont 学生签名：}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(451.01pt,-547.52pt)$)
            {{\seuaibodyfont 年}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(474.65pt,-547.52pt)$)
            {{\seuaibodyfont 月}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(498.29pt,-547.52pt)$)
            {{\seuaibodyfont 日}};

          \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=78.24pt,align=center]
            at ($(seuainw)+(133.59pt,-640.55pt)$)
            {{\seuaiheaderfont 指导教师意见}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(180.92pt,-592.15pt)$)
            {{\seuaibodylongfont 意见：}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(391.76pt,-644.46pt)$)
            {{\seuaibodyfont 指导教师签名：}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(451.01pt,-671.04pt)$)
            {{\seuaibodyfont 年}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(474.65pt,-671.04pt)$)
            {{\seuaibodyfont 月}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(498.29pt,-671.04pt)$)
            {{\seuaibodyfont 日}};
        }
        {
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt,text\c_space_tl width=61.56pt,align=left]
            at ($(seuainw)+(94.82pt,-276.34pt)$)
            {{\seuaibodyfont \seu_ai_yes_tool_block:}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(183.20pt,-260.74pt)$)
            {{\seu_ai_plain_box:nn { 89.00pt } { \seuaibodylongfont \seu_ai_yes_scope_block: }}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(295.10pt,-272.16pt)$)
            {{\seu_ai_plain_box:nn { 118.00pt } { \seuaibodylongfont \seu_ai_yes_process_block: }}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt,text\c_space_tl width=81.99pt,align=left]
            at ($(seuainw)+(433.39pt,-287.76pt)$)
            {{\seuaibodyfont \seu_ai_yes_pages_block:}};

          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(100.20pt,-353.88pt)$)
            {{\seu_ai_plain_box:nn { 400.00pt } { \seuaibodylongfont \seu_ai_no_block: }}};

          \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=72.22pt,align=center]
            at ($(seuainw)+(131.94pt,-496.98pt)$)
            {{\seuaiheaderfont 学生诚信申明}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(185.30pt,-412.66pt)$)
            {{\seu_ai_plain_box:nn { 314.00pt } { \seuaibodylongfont \seu_ai_student_statement_block: }}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(390.55pt,-510.00pt)$)
            {{\seuaibodyfont 学生签名：}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(404.80pt,-527.40pt)$)
            {{\seuaibodyfont \seu_ai_date_line:N \g_seu_ai_student_date_tl}};

          \node[anchor=center,inner\c_space_tl sep=0pt,text\c_space_tl width=78.24pt,align=center]
            at ($(seuainw)+(131.94pt,-637.92pt)$)
            {{\seuaiheaderfont 指导教师意见}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(185.30pt,-589.46pt)$)
            {{\seu_ai_plain_box:nn { 314.00pt } { \seuaibodylongfont \seu_ai_teacher_statement_block: }}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(390.55pt,-633.00pt)$)
            {{\seuaibodyfont 指导教师签名：}};
          \node[anchor=north\c_space_tl west,inner\c_space_tl sep=0pt]
            at ($(seuainw)+(404.80pt,-650.40pt)$)
            {{\seuaibodyfont \seu_ai_date_line:N \g_seu_ai_teacher_date_tl}};
        };
    \end{tikzpicture}
    \null
    \endgroup
  }

\cs_new_protected:Npn \seu_make_chinese_abstract:
  {
    \clearpage
    \thispagestyle{seupreface}
    \phantomsection
    \addcontentsline{toc}{chapter}{摘\hspace{2em}要}
    \vspace*{-3pt}
    \seu_compact_preface_title:n { 摘\hspace{2em}要 }
    \vspace{2pt}
    {\normalfont\rmfamily\songti\seuxiaosi\selectfont \parindent=2\ccwd \indent \seuabstractzh}
    \par
    \vspace{\baselineskip}
    \noindent
    {\normalfont\rmfamily\songti\seuxiaosi\selectfont {\CJKfamily{seuheadingmedium}关键词：}\seukeywordszh}
    \par
  }

\cs_new_protected:Npn \seu_make_english_abstract:
  {
    \clearpage
    \thispagestyle{seupreface}
    \phantomsection
    \addcontentsline{toc}{chapter}{ABSTRACT}
    \vspace*{-6pt}
    {
      \centering
      {\rmfamily\fontseries{b}\selectfont\seusanhao ABSTRACT \par}
    }
    \vspace{7pt}
    {\rmfamily\seuxiaosi\setstretch{1.5}\selectfont \parindent=21pt \indent \seuabstracten \par}
    \vspace{\baselineskip}
    \noindent
    {\normalfont\rmfamily\seuxiaosi\selectfont KEY\space WORDS:\space \seukeywordsen \par}
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
\NewDocumentCommand{\seuaisubject}{}   { \tl_use:N \g_seu_ai_subject_tl }
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
\NewDocumentCommand{\seuprefacetitle}{m} { \seu_preface_title:n { #1 } }
\NewDocumentCommand{\seucompactprefacetitle}{m} { \seu_compact_preface_title:n { #1 } }
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
\IfFontExistsTF{KaiTi}
  { \newfontfamily\seucoverdatefamily{KaiTi} }
  { \newfontfamily\seucoverdatefamily{楷体} }

\makeatletter
\renewcommand\normalsize{\zihao{-4}\selectfont}
\makeatother

\newcommand{\seunaturalheiti}{\CJKfamily{seuheadingmedium}}
\newcommand{\seuboldheiti}{\CJKfamily{seuheadingbold}\bfseries}
\newcommand{\seucovertitlefont}{\CJKfamily{seucovershmedium}\fontsize{22pt}{46pt}\selectfont}
\newcommand{\seucoversubtitlefont}{\fontsize{16pt}{46pt}\selectfont}
\newcommand{\seucovernotefont}{\songti\fontsize{16pt}{46pt}\selectfont}
\newcommand{\seucoverlabelfont}{\CJKfamily{seucovershmedium}\fontsize{13.6pt}{14pt}\selectfont}
\newcommand{\seucovervaluefont}{\songti\fontsize{18pt}{18pt}\selectfont}
\newcommand{\seucoverdatefont}{\seucoverdatefamily\CJKfamily{zhkai}\fontsize{14pt}{14pt}\selectfont}
\newcommand{\seuaititlefont}{\seuboldheiti\fontsize{16pt}{18pt}\selectfont}
\newcommand{\seuaiheaderfont}{\seuboldheiti\fontsize{12pt}{12pt}\selectfont}
\newcommand{\seuaibodyfont}{\songti\fontsize{10.5pt}{12pt}\selectfont}
\newcommand{\seuaibodylongfont}{\songti\fontsize{10.5pt}{13.9pt}\selectfont}
\newcommand{\seuaiboldvaluefont}{\CJKfamily{seucovershmedium}\fontsize{12pt}{12pt}\selectfont}
\newcommand{\seumainheadertext}{\songti\seuxiaowu 东南大学本科毕业设计（论文）}
\newcommand{\seumainheadercontent}{%
  \makebox[\headwidth][c]{%
    \vbox to \headheight{%
      \offinterlineskip
      \vfil
      \hbox to \headwidth{\hfil \raisebox{-0.9pt}{\seumainheadertext} \hfil}%
      \vskip 0.2pt%
    }%
  }%
}

\fancypagestyle{seublank}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{seupreface}{
  \fancyhf{}
  \fancyfoot[C]{\songti\seuxiaowu \Roman{page}}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{seumain}{
  \fancyhf{}
  \fancyhead[C]{\seumainheadercontent}
  \fancyfoot[C]{\songti\seuxiaowu \thepage}
  \renewcommand{\headrulewidth}{0.55pt}
  \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyhead[C]{\seumainheadercontent}
  \fancyfoot[C]{\songti\seuxiaowu \thepage}
  \renewcommand{\headrulewidth}{0.55pt}
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
  \seuapplybodystyle
  \pagestyle{seupreface}
  \thispagestyle{seupreface}
}

\NewDocumentCommand{\seumainmatter}{}{
  \clearpage
  \pagenumbering{arabic}
  \setcounter{page}{1}
  \seuapplybodystyle
  \pagestyle{seumain}
  \thispagestyle{seumain}
}

\NewDocumentCommand{\seutextpagebreak}{}{
  \clearpage
}

\NewDocumentCommand{\seutoppageparagraph}{+m}{
  \clearpage
  \noindent
  \rule{0pt}{14.6pt}#1\par
}

\makeatletter
\NewDocumentCommand{\seumaketableofcontents}{}{
  \clearpage
  \thispagestyle{seupreface}
  \phantomsection
  \addcontentsline{toc}{chapter}{目\hspace{2em}录}
  \vspace*{-3pt}
  \seucompactprefacetitle{目\hspace{2em}录}
  \vspace{2pt}
  \@starttoc{toc}
}
\makeatother

\NewDocumentCommand{\seuprintbibliography}{}{
  \clearpage
  \begingroup
  \seuwuhao
  \setlength{\bibitemsep}{0.18\baselineskip}
  \sloppy
  \printbibliography[heading=seubibliography]
  \endgroup
}

\newcommand{\seubibliographyheading}{%
  \chapter*{参考文献}
  \addcontentsline{toc}{chapter}{参考文献}
}
\defbibheading{seubibliography}{\seubibliographyheading}
\renewcommand*{\bibfont}{\songti\seuwuhao}

\ctexset{
  chapter = {
    name = {第,章},
    number = \chinese{chapter},
    aftername = \enspace,
    beforeskip = -20pt,
    afterskip = 6pt,
    format = \centering\seuboldheiti\seusanhao
  },
  section = {
    beforeskip = 4pt,
    afterskip = 4pt,
    format = \seunaturalheiti\seusihao
  },
  subsection = {
    beforeskip = 4pt,
    afterskip = 3pt,
    format = \songti\normalfont\seuxiaosi
  }
}

\setcounter{tocdepth}{2}
\renewcommand{\contentsname}{目\hspace{2em}录}
\renewcommand{\cfttoctitlefont}{\hfill\CJKfamily{seuheadingmedium}\seusanhao}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftchapfont}{\songti\seuxiaosi}
\renewcommand{\cftsecfont}{\songti\seuxiaosi}
\renewcommand{\cftsubsecfont}{\songti\seuxiaosi}
\renewcommand{\cftchappagefont}{\songti\seuxiaosi}
\renewcommand{\cftsecpagefont}{\songti\seuxiaosi}
\renewcommand{\cftsubsecpagefont}{\songti\seuxiaosi}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftdotsep}}
\setlength{\cftbeforechapskip}{0pt}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}
\renewcommand{\cftdotsep}{0.8}
\setlength{\cftchapindent}{2\ccwd}
\setlength{\cftsecindent}{4\ccwd}
\setlength{\cftsubsecindent}{6\ccwd}
\setlength{\cftchapnumwidth}{3.4\ccwd}
\setlength{\cftsecnumwidth}{1.85\ccwd}
\setlength{\cftsubsecnumwidth}{4.0\ccwd}

\DeclareCaptionFont{seucaptionfont}{\songti\seuwuhao\selectfont}
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

\makeatletter
\newif\ifseuappendixmode
\seuappendixmodefalse
\g@addto@macro\appendix{%
  \global\seuappendixmodetrue
  \ctexset{%
    chapter = {%
      name = {附录,},%
      number = \Alph{chapter},%
      aftername = \space,%
      beforeskip = -21pt,%
      afterskip = 4pt,%
      format = \centering\seuboldheiti\seusanhao%
    }%
  }%
}
\g@addto@macro\@afterheading{%
  \seuapplybodystyle
}
\makeatother

\let\seuorigchapter\chapter
\RenewDocumentCommand{\chapter}{s o m}
  {
    \IfBooleanTF{#1}
      {
        \seuorigchapter*{#3}
      }
      {
        \ifseuappendixmode
          \vspace*{-8pt}%
        \fi
        \IfValueTF{#2}
          {\seuorigchapter[#2]{#3}}
          {\seuorigchapter{#3}}
        \ifseuappendixmode
          \vspace{1pt}%
        \else
          \vspace{-4pt}%
        \fi
      }
  }

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
