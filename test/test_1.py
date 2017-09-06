"""Testing basic operation of bgzip_md5, minimal use case."""

from pathlib import Path
from shutil import rmtree
from subprocess import run, PIPE


ORIGINAL_FILE_CONTENTS = 'hello world\n'


def test_1():
    target = Path('target', 'test_1')
    if target.exists():
        rmtree(target)
    target.mkdir(parents=True)
    input_file = target / 'input'
    input_file.write_text(ORIGINAL_FILE_CONTENTS)
    expected_md5 = run(['md5sum', 'input'],
                       cwd=target,
                       stdout=PIPE,
                       check=True).stdout
    run(['./bgzip_md5.py', input_file], check=True)
    output_file = target / 'input.gz'
    md5_file = target / 'input.md5'
    assert md5_file.read_bytes() == expected_md5, 'checksum'
    decompressed_data = run(['gzip', '-cd', output_file],
                            stdout=PIPE,
                            check=True).stdout.decode('ascii')
    assert decompressed_data == ORIGINAL_FILE_CONTENTS, 'decompression'
