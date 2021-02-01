import re
from pathlib import Path


ROOT = Path(__file__).resolve().parent
MAIN = ROOT


def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        pass
  
    try:
        import unicodedata
        unicodedata.numeric(s)
        return True
    except (TypeError, ValueError):
        pass
  
    return False


def translate():
    print('Begin translate...')

    code = """
import 'package:flutter/widgets.dart';





class IconFont {

  IconFont._();

  static const font_name = 'IconFont';

{icon_codes}

}
""".strip()

    strings = []

    tmp = []
    p = re.compile(r'.icon(.*?):.*?"\\(.*?)";')

    content = open(MAIN / 'assets/fonts/iconfont.css').read().replace('\n  content', 'content')

    for line in content.splitlines():
        line = line.strip()
        if line:
            res = p.findall(line)
            if res:
                name, value = res[0]
                name = name.replace('-', '_')
                tmp.append((name.lower(), value))

    tmp.sort()
    for name, value in tmp:
        if is_number(name[0]):
            name = name[1:] + name[0]
        string = f'  static const IconData {name} = const IconData(0x{value}, fontFamily: font_name, matchTextDirection: true);'
        strings.append(string)

    strings = '\n'.join(strings)
    
    code = code.replace('{icon_codes}', strings)
    
    open(MAIN / 'lib/utils/iconfont.dart', 'w').write(code)

    print('Finish translate...')


if __name__ == "__main__":
    translate()