# -*- coding: utf-8 -*- #

module Rouge
  module Lexers
    class BlitzMax < RegexLexer
      title "BlitzMax"
      desc "BlitzMax"
      tag 'bmx'
      aliases 'blitzmax'
      filenames '*.bmx'
      mimetypes 'text/x-blitzmax'

      def self.keywords
        @keywords ||= Set.new %w(
          AddHandler Alias ByRef ByVal CBool CByte CChar CDate CDbl CDec
          CInt CLng CObj CSByte CShort CSng CStr CType CUInt CULng CUShort
          Call Case Catch Class Const Continue Declare Default Delegate
          Dim DirectCast Do Each Else ElseIf End EndIf Enum Erase Error
          Event Exit False Finally For Friend Function Get Global GoSub
          GoTo Handles If Implements Imports Inherits Interface Let
          Lib Loop Me Module MustInherit MustOverride MyBase MyClass
          Namespace Narrowing New Next Not NotInheritable NotOverridable
          Nothing Of On Operator Option Optional Overloads Overridable
          Overrides ParamArray Partial Private Property Protected Public
          RaiseEvent ReDim ReadOnly RemoveHandler Resume Return Select Set
          Shadows Shared Single Static Step Stop Structure Sub SyncLock
          Then Throw To True Try TryCast Using Wend When While Widening
          With WithEvents WriteOnly Local Print
        )
      end

      def self.keywords_type
        @keywords_type ||= Set.new %w(
          Byte Short Int Long Double Float Object
          String
        )
      end

      def self.operator_words
        @operator_words ||= Set.new %w(
          And EachIn Not Or Var Ptr
        )
      end

      def self.builtins
        @builtins ||= Set.new %w(
          DebugLog
          Module
        )
      end

      id = /[a-z_]\w*/i
      upper_id = /[A-Z]\w*/

      state :whitespace do
        rule /\s+/, Text
        rule /\n/, Text, :bol
        rule /rem\b.*?$/i, Comment::Single
        rule %r(%\{.*?%\})m, Comment::Multiline
        rule /'.*$/, Comment::Single
      end

      state :bol do
        rule /\s+/, Text
        rule /<.*?>/, Name::Attribute
        rule(//) { :pop! }
      end

      state :root do
        mixin :whitespace
        rule %r(
            [#]If\b .*? \bThen
          | [#]ElseIf\b .*? \bThen
          | [#]End \s+ If
          | [#]Const
          | [#]ExternalSource .*? \n
          | [#]End \s+ ExternalSource
          | [#]Region .*? \n
          | [#]End \s+ Region
          | [#]End \s+ Type
          | [#]ExternalChecksum
        )x, Comment::Preproc
        rule /[.]/, Punctuation, :dotted
        rule /[(){}!#,:]/, Punctuation
        rule /Option\s+(Framework|Strict|SuperStrict)\s+(On|Off|Binary|Text)/,
          Keyword::Declaration
        rule /(End|End Function|End Method|End If|End Type)\b/, Keyword, :end
        rule /(Dim|Const|Local|Global)\b/, Keyword, :dim
        rule /(Function|Method)\b/, Keyword, :funcname
        rule /(Type)\b/, Keyword, :classname
        rule /(Import)\b/, Keyword, :namespace

        rule upper_id do |m|
          match = m[0]
          if self.class.keywords.include? match
            token Keyword
          elsif self.class.keywords_type.include? match
            token Keyword::Type
          elsif self.class.operator_words.include? match
            token Operator::Word
          elsif self.class.builtins.include? match
            token Name::Builtin
          else
            token Name
          end
        end

        rule(
          %r(&=|[*]=|/=|\\=|\^=|\+=|-=|<<=|>>=|<<|>>|:=|<=|>=|<>|[-&*/\\^+=<>.]),
          Operator
        )

        rule /"/, Str, :string
        rule /#{id}[%&@!#\$]?/, Name
        rule /#.*?#/, Literal::Date

        rule /(\d+\.\d*|\d*\.\d+)(f[+-]?\d+)?/i, Num::Float
        rule /\d+([SILDFR]|US|UI|UL)?/, Num::Integer
        rule /&H[0-9a-f]+([SILDFR]|US|UI|UL)?/, Num::Integer
        rule /&O[0-7]+([SILDFR]|US|UI|UL)?/, Num::Integer

        rule /_\n/, Keyword
      end

      state :dotted do
        mixin :whitespace
        rule id, Name, :pop!
      end

      state :string do
        rule /""/, Str::Escape
        rule /"C?/, Str, :pop!
        rule /[^"]+/, Str
      end

      state :dim do
        mixin :whitespace
        rule id, Name::Variable, :pop!
        rule(//) { pop! }
      end

      state :funcname do
        mixin :whitespace
        rule id, Name::Function, :pop!
      end

      state :classname do
        mixin :whitespace
        rule id, Name::Class, :pop!
      end

      state :namespace do
        mixin :whitespace
        rule /#{id}([.]#{id})*/, Name::Namespace, :pop!
      end

      state :end do
        mixin :whitespace
        rule /(Function|Method|Type|)\b/,
          Keyword, :pop!
        rule(//) { pop! }
      end
    end
  end
end
