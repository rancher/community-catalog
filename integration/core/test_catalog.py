import pytest
import cattle
import subprocess
import sys
import os
import re
# import yaml


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


@pytest.fixture(scope='session')
def client():
    url = 'http://localhost:8088/v1-catalog/schemas'
    return cattle.from_env(url=url)


@pytest.fixture(scope='session')
def templates(client):
    templates = client.list_template()
    assert len(templates) > 0
    return templates


@pytest.fixture(scope='session')
def requests():
    return requests.Session()


@pytest.fixture(scope='session')
def template_details(client, templates):
    for template in templates:
        template.versionDetails = {}
        for version, link in template.versionLinks.iteritems():
            template.versionDetails[version] = client._get(link)
    return templates


def test_validate_exits_normal(catalog_service):
    catalog_service.assert_retcode(
        0, '-catalogUrl',
        _file('./'),
        '-validate', '-port', '18088')


def test_stack_name(templates):
    hostname_label = re.compile(r'^[a-zA-Z0-9\-]{1,63}$')
    for template in templates:
        # stack_name must be a valid hostname label
        assert hostname_label.match(template.id.split(':')[-1].split('*')[-1])


def test_maintainers(templates):
    maintainer = re.compile(r'^([\S]+ ){2,5}<[^@]+@[^@]+\.[^@]+>$')
    for template in templates:
        # Maintainer will soon be a requirement
        # assert template.maintainer
        if template.maintainer:
            assert maintainer.match(template.maintainer)


def test_versions(templates):
    for template in templates:
        # default version must be defined
        assert template.defaultVersion
        # template with default version must be defined
        assert template.versionLinks[template.defaultVersion]


def test_template_questions(template_details):
    for template in template_details:
        for _, template in template.versionDetails.iteritems():
            # there must exist a rancher-compose.yml file
            assert template.files['rancher-compose.yml']
            # rancherConfig = yaml.load(template.files['rancher-compose.yml'])
            # there must exist at least one question
            # assert len(rancherConfig['.catalog']['questions']) > 0
