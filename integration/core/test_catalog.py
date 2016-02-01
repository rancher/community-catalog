import pytest
import cattle
import subprocess
import sys
import os


def _base():
    return os.path.dirname(__file__)


def _file(f):
    return os.path.join(_base(), '../../{}'.format(f))


class CatalogService(object):
    def __init__(self, catalog_bin):
        self.catalog_bin = catalog_bin

    def assert_retcode(self, ret_code, *args):
        p = self.call(*args)
        r_code = p.wait()
        assert r_code == ret_code

    def call(self, *args, **kw):
        cmd = [self.catalog_bin]
        cmd.extend(args)

        kw_args = {
            'stdin': subprocess.PIPE,
            'stdout': sys.stdout,
            'stderr': sys.stderr,
            'cwd': _base(),
        }

        kw_args.update(kw)
        return subprocess.Popen(cmd, **kw_args)


@pytest.fixture(scope='session')
def catalog_bin():
    c = '/usr/bin/rancher-catalog-service'
    assert os.path.exists(c)
    return c


@pytest.fixture(scope='session')
def catalog_service(catalog_bin):
    return CatalogService(catalog_bin)


@pytest.fixture
def client():
    url = 'http://localhost:8088/v1-catalog/schemas'
    return cattle.from_env(url=url)


def test_validate_exits_normal(catalog_service):
    catalog_service.assert_retcode(
        0, '-catalogUrl',
        _file('./'),
        '-validate', '-port', '18088')


def test_catalog_list(client):
    templates = client.list_template()
    assert len(templates) > 0
