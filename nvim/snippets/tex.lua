local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local types = require("luasnip.util.types")

local rec_ls
rec_ls = function()
	return sn(
		nil,
		c(1, {
			-- Order is important, sn(...) first would cause infinite loop of expansion.
			t(""),
			sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
		})
	)
end

return {
  s({trig = "ul", dscr = "Itemize with endless items"}, {
			t({ "\\begin{itemize}", "\t\\item " }),
			i(1),
			d(2, rec_ls, {}),
			t({ "", "\\end{itemize}" }),
		}),
    s({trig = "ol", dscr = "Enumerate with endless items"}, {
			t({ "\\begin{enumerate}", "\t\\item " }),
			i(1),
			d(2, rec_ls, {}),
			t({ "", "\\end{enumerate}" }),
		}),
    s({trig = "sec", dscr = "Section" }, {
      c(1, {
        t '\\section{',
        t '\\subsection{',
        t '\\subsubsection{'
      }), i(2), t '}', i(0)
    }),
		s({trig = "bf", dscr = "textbf"}, { t({"\\textbf{"}), i(1), t({"}"}), i(0) }),
		s({trig = "it", dscr = "textit"}, { t({"\\textit{"}), i(1), t({"}"}), i(0) }),
		s({trig = "rm", dscr = "textrm"}, { t({"\\textrm{"}), i(1), t({"}"}), i(0) }),
		s({trig = "verb", dscr = "verb"}, { t({"\\verb|"}), i(1), t({"|"}), i(0) }),
    s({trig = "frame", dscr="New frame"}, {t {'\\begin{frame}', '\t'}, i(0), t {'', '\\end{frame}'}})
}
