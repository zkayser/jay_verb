# jay_verb

JayVerb is a gem for conjugating Japanese verbs. The main driver is the JayVerb class. Instances should be initialized
with Japanese verbs in plain form and include both kanji and hiragana, i.e.:

```ruby
say = JayVerb.new("言う", "いう")
```

This will return a JayVerb instance, which will automatically convert the provided hiragana into roman letters and process the verb.
Note that the first kanji argument does not necessarily have to be written in Kanji. The library would still work given: 

```ruby
say = JayVerb.new("いう", "いう")
```

Note, however, that failing to provide both arguments will result in errors. The second argument MUST be written in hiragana for
proper behavior.

When instantiating the verb, the type of verb will be resolved behind the scenes, which can be retrieved from the @part_of_speech
instance variable. This enables the conjugator to conjugate the verb appropriately.

```ruby
say = JayVerb.new("言う", "いう")
say.part_of_speech # => "v5u"
```

To find most common conjugations, access the @conjugations hash:

```ruby
say = JayVerb.new("言う", "いう")
say.conjugations # => {:te_form=>"言って", :ta_form=>"言った", :polite_forms=>{:present=>"言います", :past=>"言いました", :present_negative=>"言いません", :past_negative=>"言いませんでした", :volitional=>"言いましょう", :te_form=>"言いまして"},
                 # :negative_plain_forms=>{:present=>"言わない", :past=>"言わなかった", :te_form=>"言わなくて"},
                 # :continuous_forms=>{:present_spoken=>"言ってる", :present_written=>"言っている", :present_polite=>"言っています", :present_polite_spoken=>"言ってます", :past_spoken=>"言ってた", :past_written=>"言っていた", :past_polite=>"言っていました", :past_polite_spoken=>"言ってました", :te_form_spoken=>"言ってて", :te_form_written=>"言っていて", :te_form_polite=>"言っていまして", :te_form_polite_spoken=>"言ってまして", :negative_te_form_spoken=>"言ってなくて", :negative_te_form_written=>"言っていなくて"},
                 # :prohibitive=>"言うな", :plain_present_potential=>"言える", :conditional=>"言えば", :imperative=>"言え", :volitional=>"言おう"}
```

The @hiragana_forms and @romaji_forms reflect these conjugations in hiragana and roman letters, respectively.

More forms can be accessed through the @passive_forms, @causative_forms, and @causative_passive_forms hashes. Check the
@passive_forms_hiragana/@passive_forms_romaji, @causative_forms_hiragana/@causative_forms_romaji, and
@causative_passive_forms_hiragana/@causative_passive_forms_romaji for the hiragana and roman letter versions.

A final note on naming conventions: the names ascribed to tenses and modes of verbs may not coincide with the names given
in formal grammars. For example, continuous forms are of the format "te-form verb plus a conjugated 'iru' verb," and _spoken
suffixes are added to denote that the "-i" in "iru" is being dropped as it generally would in speech, i.e.: "itteru" as opposed
to the more enunciated "itte iru." The forms not dropping the "-i" in "iru" have been ascribed a _written suffix temporarily
for lack of a better title. The standard "-masu" forms are described by polite_forms or denoted by _polite suffixes.
