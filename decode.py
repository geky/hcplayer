#!/usr/bin/env python2

from pydub import AudioSegment


def main(inf, outf, rate=8000):
    sound = AudioSegment.from_file(inf)
    sound = sound.set_channels(1)
    sound = sound.set_sample_width(1)
    sound = sound.set_frame_rate(rate)
    sound.export(outf, format="wav")


if __name__ == "__main__":
    import sys
    main(*sys.argv[1:])

