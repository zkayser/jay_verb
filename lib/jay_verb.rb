require 'active_support'
require 'active_support/core_ext'
require 'japanese/verb_identifier'
require 'japanese/conjugator'
require 'japanese/to_romaji'

class JayVerb
  include Japanese::VerbIdentifier
  include Japanese::Conjugator
  include Japanese::ToRomaji
    
  attr_accessor :kanji, :hiragana, :romaji, :part_of_speech, :passive_forms,
                :stem_form, :hiragana_forms, :romaji_forms, :negative_stem,
                :base, :passive_dictionary_form, :causative_dictionary_form,
                :causative_passive_dictionary_form, :causative_forms, :conjugations,
                :causative_passive_forms_hiragana, :causative_passive_forms_romaji,
                :passive_forms_hiragana, :passive_forms_romaji, :causative_passive_forms,
                :causative_passive_forms_hiragana, :causative_passive_forms_romaji,
                :causative_forms_hiragana, :causative_forms_romaji, :has_imperative,
                :has_causative, :has_causative_passive, :has_passive, :has_volitional
                  
  def initialize(kanji, hiragana)
    @kanji = kanji
    @hiragana = hiragana
    @romaji = Japanese::ToRomaji.convert_hiragana(String.new(hiragana))
    @part_of_speech = self.resolve_verb_class
    self.set_verb_behavior_types
    @hiragana_forms = {}
    @romaji_forms = {}
    @passive_forms = {}
    @causative_forms = {}
    @conjugations = {}
    @causative_passive_forms = {}
    @causative_passive_forms_hiragana = {}
    @causative_passive_forms_romaji = {}
    @passive_forms_hiragana = {}
    @passive_forms_romaji ={}
    @causative_forms_hiragana = {}
    @causative_forms_romaji = {}
    self.process_verb
  end
    
  # Defaults all has_* attributes to true for now. When self.process_verb is
  # called, this will conjugate the verb for all possible modes. This may
  # not make sense for all verbs —- for example, some verbs may never
  # be realistically used in the imperative sense, such as "存在しろ!"
  # ("Exist!"), which while grammatically correct, may sound nonsensical.
  def set_verb_behavior_types
    if part_of_speech.in?(%w(v1 v5b v5g v5k v5k-s v5m v5n v5r v5r-i v5s v5t v5u v5u-s v-aru v-kuru v-suru))
      attrs = %w(imperative passive volitional causative causative_passive)
      attrs.each do |a|
        unless self.send("has_#{a}") == false
          eval "self.has_#{a} = true"
        end
      end
    end
  end
end
# JayVerb.new("言う", "いう")