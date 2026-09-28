;;; arkts-ts-mode.el --- ArkTS major mode on tree-sitter -*- lexical-binding: t; -*-

;; ArkTS (HarmonyOS, .ets) mode.  The grammar is a fork of
;; tree-sitter-typescript, so we reuse `typescript-ts-mode' rules against the
;; `arkts' language and add highlighting for the ArkUI extensions: `struct',
;; decorators and component blocks such as `Column() { ... }'.
;;
;; Install the grammar once with M-x treesit-install-language-grammar RET arkts.

;;; Code:

(require 'cl-lib)
(require 'treesit)
(require 'typescript-ts-mode)

(add-to-list 'treesit-language-source-alist
             '(arkts "https://github.com/harmony-contrib/tree-sitter-arkts"))

(defvar arkts-ts-mode--font-lock-settings
  (treesit-font-lock-rules
   :language 'arkts
   :feature 'keyword
   '(["struct"] @font-lock-keyword-face)

   :language 'arkts
   :feature 'declaration
   '((struct_declaration name: (type_identifier) @font-lock-type-face)
     (decorator "@" @font-lock-preprocessor-face
                [(identifier) @font-lock-preprocessor-face
                 (call_expression
                  function: (identifier) @font-lock-preprocessor-face)]))

   :language 'arkts
   :feature 'function
   '((arkui_component_expression
      function: (identifier) @font-lock-function-call-face)))
  "ArkUI-specific font-lock rules, applied before the TypeScript ones.")

(defmacro arkts-ts-mode--as-typescript (&rest body)
  "Run BODY with the typescript-ts-mode dialect guard disabled.
The guard only rejects dialects other than `typescript'/`tsx'; the rule
builders otherwise treat any non-`tsx' language as plain TypeScript."
  `(cl-letf (((symbol-function 'typescript-ts-mode--check-dialect) #'ignore))
     ,@body))

(defun arkts-ts-mode--syntax-propertize (beg end)
  (tsx-ts--syntax-propertize-captures
   (treesit-query-capture 'arkts typescript-ts--s-p-query beg end)))

;;;###autoload
(define-derived-mode arkts-ts-mode typescript-ts-base-mode "ArkTS"
  "Major mode for editing ArkTS (HarmonyOS) files."
  (when (and (treesit-ensure-installed 'arkts)
             (treesit-ready-p 'arkts))
    (setq treesit-primary-parser (treesit-parser-create 'arkts))

    (setq-local treesit-simple-indent-rules
                (arkts-ts-mode--as-typescript
                 (typescript-ts-mode--indent-rules 'arkts)))
    (setq-local treesit-simple-indent-standalone-predicate
                #'typescript-ts--standalone-parent-p)

    ;; The base mode keys thing settings by `typescript'; rekey for `arkts'.
    (setq-local treesit-thing-settings
                `((arkts ,@(alist-get 'typescript treesit-thing-settings))))

    (setq-local treesit-font-lock-settings
                (append arkts-ts-mode--font-lock-settings
                        (arkts-ts-mode--as-typescript
                         (typescript-ts-mode--font-lock-settings 'arkts))))
    (setq-local treesit-font-lock-feature-list
                '((comment declaration)
                  (keyword string escape-sequence)
                  (constant expression identifier number pattern property)
                  (operator function bracket delimiter)))
    (setq-local syntax-propertize-function #'arkts-ts-mode--syntax-propertize)

    (treesit-major-mode-setup)))

(provide 'arkts-ts-mode)
;;; arkts-ts-mode.el ends here
