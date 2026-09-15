"""Cryptographically strong password/passphrase generator.
Usage: python password_gen.py 20            /  python password_gen.py --phrase 4"""
import argparse, secrets, string

WORDS = ("anchor breeze carbon drift ember fjord granite harbor ivory jade kernel "
         "lagoon meadow nimbus orbit prism quartz ripple summit tundra velvet").split()

ap = argparse.ArgumentParser()
ap.add_argument("length", nargs="?", type=int, default=20)
ap.add_argument("--phrase", type=int, metavar="WORDS", help="generate a passphrase instead")
ap.add_argument("--no-symbols", action="store_true")
a = ap.parse_args()

if a.phrase:
    print("-".join(secrets.choice(WORDS) for _ in range(a.phrase)))
else:
    pool = string.ascii_letters + string.digits
    if not a.no_symbols:
        pool += "!@#$%^&*-_=+"
    print("".join(secrets.choice(pool) for _ in range(a.length)))
