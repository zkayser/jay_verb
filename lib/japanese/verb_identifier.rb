require 'active_support'
require 'active_support/core_ext'

module Japanese
  module VerbIdentifier
  
    # List of consonant stem verbs ending in -iru
    CONSONANT_VERBS =     %w(脂ぎる びびる 契る 散る どじる 愚痴る 入る 走る 穿る 迸る
                            熱る いびる 弄る 炒る 要る 限る 齧る 呪る 切る 霧る 切る
                            きしる 軋る 抉る 参る 混じる　交じる 滅入る 見縊る 漲る
                            毟る 捩じる 握る 罵る 陥る 思い入る 思い切る せびる 知る
                            謗る 滾る 魂消る 迸る とちる 野次る 過る 横切る 嘲る 駄弁る
                            彫る 選る 啁る 耽る 伏せる 侍る 減る 撚る 翻る 火照る 帰る
                            返る 反る 還る 孵る 陰る 駆ける 蹴る くねる 覆る 練る のめる
                            滑る 阿る 競る 挵る 喋る 茂る 湿気る そべる 滑る 猛る 照る
                            抓める 抓る うねる 蘇る 甦る 放る 括る 抉る 捥る 捩る 詰る
                            )
                           
    RU_IRREGULAR_MAPPING = {
      "する": "v-suru",
      "来る": "v-kuru",
      "有る": "v-aru",
      "ある": "v-aru",
      "居らっしゃる": "v5r-i",
      "いらっしゃる": "v5r-i"
    }
  
    AMBIGUITY_IF_HIRAGANA_ONLY = %w(いる きる える へる かえる ねる しめる)
  
    E_HIRAGANA = %w(え け せ て へ ね め れ げ ぜ で べ ぺ)
    I_HIRAGANA = %w(い き し ち ひ に み り ぎ じ ぢぃ び ぴ)
  
    def resolve_ru_verb_class
      return nil if ambiguous?
      unless irregular?
        if ends_in_iru_eru? && is_consonant_verb?
          self.part_of_speech = "v5r"
        elsif ends_in_ru? && !ends_in_iru_eru?
          self.part_of_speech = "v5r"
        elsif ends_in_iru_eru? && !is_consonant_verb?
          self.part_of_speech = "v1"
        end
      else
        RU_IRREGULAR_MAPPING.stringify_keys!
        RU_IRREGULAR_MAPPING.each do |k, v|
          self.part_of_speech = v if self.kanji == k
        end
      end
    end
  
    def resolve_verb_class
      # Check if the word is a special case of "k" or "u" verb
      if self.kanji == "行く"
        self.part_of_speech = "v5k-s"
      elsif self.kanji == "問う"
        self.part_of_speech = "v5u-s"
      else
        case self.kanji[-1]
          when "ぶ"
            self.part_of_speech = "v5b"
          when "ぐ"
            self.part_of_speech = "v5g"
          when "く"
            self.part_of_speech = "v5k" unless self.kanji == "行く"
          when "む"
            self.part_of_speech = "v5m"
          when "ぬ"
            self.part_of_speech = "v5n"
          when "す"
            self.part_of_speech = "v5s"
          when "る"
            resolve_ru_verb_class
          when "つ"
            self.part_of_speech = "v5t"
          when "う"
            self.part_of_speech = "v5u" unless self.kanji == "問う"
        end
      end
    end
  
      # Include into the word class and use on word instances
      def ends_in_ru?
        unless self.kanji.blank?
          self.kanji[-1] == "る" ? true : false
        else 
          self.hiragana[-1] == "る" ? true : false
        end
      end
  
      # Returns true if the class of the verb cannot be determined without more information
      def ambiguous?
        self.kanji == self.hiragana && self.kanji.in?(AMBIGUITY_IF_HIRAGANA_ONLY) ? true : false
      end
  
      def ends_in_iru_eru?
        self.hiragana[-2].in?(E_HIRAGANA) || self.hiragana[-2].in?(I_HIRAGANA) ? true : false
      end
  
      def is_consonant_verb?
        if self.ends_in_iru_eru? && !ambiguous?
          self.kanji.in?(CONSONANT_VERBS) ? true : false
        end
      end
  
      # Verifies the verb is not a "ru" irregular
      def irregular?
        irregulars = RU_IRREGULAR_MAPPING.stringify_keys!
        ireg = irregulars.keys
        self.kanji.in?(ireg) ? true : false
      end
  end
end