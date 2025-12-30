#!/usr/bin/env sage

import sys
from pprint import pprint, pformat
from string import Template

class MyTemplate(Template):
    delimiter = '@@'  # Use @@ instead of $

if len(sys.argv) < 3:
    print("Usage: gen_challenge.py <md template> <file>", file=sys.stderr)
    sys.exit(1)

template_md_file = sys.argv[1]
list_file = sys.argv[2]

nums = load(list_file)

pretty_nums = pformat(nums, width=80, compact=True)

with open(template_md_file, 'r') as f:
    template=MyTemplate(f.read())


md_contents=template.substitute(
    target=2,
    modulus=1000,
    list_size=100,
    num_summed=50,
    the_list=pretty_nums);

print(md_contents)


