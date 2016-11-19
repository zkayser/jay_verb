module Japanese
  module ToRomaji
  
    BASIC_HIRAGANA_MAP = {"あ": "a",
                          "い": "i",
                          "う": "u",
                          "え": "e",
                          "お": "o",
                          "か": "ka",
                          "き": "ki",
                          "く": "ku",
                          "け": "ke",
                          "こ": "ko",
                          "さ": "sa",
                          "し": "shi",
                          "す": "su",
                          "せ": "se",
                          "そ": "so",
                          "た": "ta",
                          "ち": "chi",
                          "つ": "tsu",
                          "て": "te",
                          "と": "to",
                          "な": "na",
                          "に": "ni",
                          "ぬ": "nu",
                          "ね": "ne",
                          "の": "no",
                          "は": "ha",
                          "ひ": "hi",
                          "ふ": "fu",
                          "へ": "he",
                          "ほ": "ho",
                          "ま": "ma",
                          "み": "mi",
                          "む": "mu",
                          "め": "me",
                          "も": "mo",
                          "や": "ya",
                          "ゆ": "yu",
                          "よ": "yo",
                          "ら": "ra",
                          "り": "ri",
                          "る": "ru",
                          "れ": "re",
                          "ろ": "ro",
                          "わ": "wa",
                          "を": "wo",
                          "ん": "n",
                          "が": "ga",
                          "ぎ": "gi",
                          "ぐ": "gu",
                          "げ": "ge",
                          "ご": "go",
                          "ざ": "za",
                          "じ": "ji",
                          "ず": "zu",
                          "ぜ": "ze",
                          "ぞ": "zo",
                          "だ": "da", 
                          "ぢ": "dchi",
                          "づ": "dzu",
                          "で": "de",
                          "ど": "do",
                          "ば": "ba",
                          "び": "bi",
                          "ぶ": "bu",
                          "べ": "be",
                          "ぼ": "bo",
                          "ぱ": "pa",
                          "ぴ": "pi",
                          "ぷ": "pu",
                          "ぺ": "pe",
                          "ぽ": "po" 
                          }
  
    SMALL_COMBO_HIRAGANA_MAP = {
      "きゃ": "kya",
      "きゅ": "kyu",
      "きょ": "kyo",
      "しゃ": "sha",
      "しゅ": "shu",
      "しょ": "sho",
      "ちゃ": "cha",
      "ちゅ": "chu",
      "ちょ": "cho",
      "にゃ": "nya",
      "にゅ": "nyu",
      "にょ": "nyo",
      "ひゃ": "hya",
      "ひゅ": "hyu",
      "ひょ": "hyo",
      "みゃ": "mya",
      "みゅ": "myu",
      "みょ": "myo",
      "りゃ": "rya",
      "りゅ": "ryu",
      "りょ": "ryo",
      "ぎゃ": "gya",
      "ぎゅ": "gyu",
      "ぎょ": "gyo",
      "じゃ": "ja",
      "じゅ": "ju",
      "じょ": "jo",
      "ぢゃ": "dja",
      "ぢゅ": "dju",
      "ぢょ": "djo",
      "びゃ": "bya",
      "びゅ": "byu",
      "びょ": "byo",
      "ぴゃ": "pya",
      "ぴゅ": "pyu",
      "ぴょ": "pyo",
      "てぃ": "ti"
    }
  
    DOUBLED_CONSONANT_HIRAGANA_MAP = {
      "っか": "kka",
      "っき": "kki",
      "っく": "kku",
      "っけ": "kke",
      "っこ": "kko",
      "っさ": "ssa",
      "っし": "sshi",
      "っす": "ssu",
      "っせ": "sse",
      "っそ": "sso",
      "った": "tta",
      "っち": "cchi",
      "っつ": "ttsu",
      "って": "tte",
      "っと": "tto",
      "っば": "bba",
      "っび": "bbi",
      "っぶ": "bbu",
      "っべ": "bbe",
      "っぼ": "bbo",
      "っぱ": "ppa",
      "っぴ": "ppi",
      "っぷ": "ppu",
      "っぺ": "ppe",
      "っぽ": "ppo"
    }
  
    TRIPLE_CHAR_HIRAGANA_MAP = {
      "っきゃ": "kkya",
      "っきゅ": "kkyu",
      "っきょ": "kkyo",
      "っしゃ": "ssha",
      "っしゅ": "sshu",
      "っしょ": "ssho",
      "っちゃ": "ccha",
      "っちゅ": "cchu",
      "っちょ": "ccho",
      "っじゃ": "jja",
      "っじゅ": "jju",
      "っじょ": "jjo",
      "っびゃ": "bbya",
      "っびゅ": "bbyu",
      "っびょ": "bbyo",
      "っぴゃ": "ppya",
      "っぴゅ": "ppyu",
      "っぴょ": "ppyo"
    }
  
    SPECIALS = {
      "ゃ": "ya",
      "ゅ": "yu",
      "ょ": "yo",
      "っ": "",
      "ぁ": "a",
      "ぃ": "i",
      "ぅ": "u",
      "ぇ": "e",
      "ぉ": "o",
      "。": "."
    }
  
    # Converts a hiragana string into Roman letters
    def self.convert_hiragana(string)
      hierarchy = [TRIPLE_CHAR_HIRAGANA_MAP, DOUBLED_CONSONANT_HIRAGANA_MAP, SMALL_COMBO_HIRAGANA_MAP, BASIC_HIRAGANA_MAP, SPECIALS]
      hierarchy.length.times do |n|
        # Stringify the keys so that you can use them in the Regex in the loop.
        hierarchy[n].stringify_keys!
        hierarchy[n].each do |k, v|
          mtch = Regexp.new k
          if mtch.match(string)
            string.gsub!(mtch, v)
          end
        end
      end
      return string
    end
  end
end