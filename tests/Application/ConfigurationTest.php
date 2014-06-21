<?php
/**
 * @package		awf
 * @copyright	2014 Nicholas K. Dionysopoulos / Akeeba Ltd 
 * @license		GNU GPL version 3 or later
 */

namespace Awf\Tests\Application;

use Awf\Application\Configuration;
use Awf\Tests\Helpers\ApplicationTestCase;
use Awf\Tests\Helpers\ReflectionHelper;
use Awf\Tests\Stubs\Application\MockPhpfuncConfig;

class ConfigurationTest extends ApplicationTestCase
{
	/** @var Configuration */
	protected $config;

	public function testConstructWithoutData()
	{
		$conf = new Configuration(static::$container);

		$this->assertEquals(
			static::$container,
			ReflectionHelper::getValue($conf, 'container')
		);
	}

	/**
	 * @param $data
	 *
	 * @dataProvider getTestConstructWithData
	 */
	public function testConstructWithData($data)
	{
		$conf = new Configuration(static::$container, $data);

		$this->assertEquals(
			'bar',
			$conf->get('foo')
		);
	}

	public function getTestConstructWithData()
	{
		return array(
			array(array('foo' => 'bar')),
			array((object)array('foo' => 'bar')),
			array('{"foo": "bar"}')
		);
	}

	public function testGetDefaultPath()
	{
		$this->assertEmpty(
			ReflectionHelper::getValue($this->config, 'defaultPath')
		);

		$path = $this->config->getDefaultPath();
		$defaultPath = static::$container->basePath . '/assets/private/config.php';

		$this->assertEquals(
			$defaultPath,
			$path
		);

		$this->assertEquals(
			$defaultPath,
			ReflectionHelper::getValue($this->config, 'defaultPath')
		);
	}

	public function testSetDefaultPath()
	{
		$this->assertEmpty(
			ReflectionHelper::getValue($this->config, 'defaultPath')
		);

		$this->config->setDefaultPath('/foo/bar');

		$this->assertEquals(
			'/foo/bar',
			ReflectionHelper::getValue($this->config, 'defaultPath')
		);

		$path = $this->config->getDefaultPath();

		$this->assertEquals(
			'/foo/bar',
			$path
		);
	}

	public function testLoadConfiguration()
	{
		$phpfunc = new MockPhpfuncConfig();

		$this->config->set('no', 'I said no');
		$this->config->loadConfiguration('/dev/false', $phpfunc);
		$this->assertEquals(new \stdClass(), ReflectionHelper::getValue($this->config, 'data'));

		$this->config->set('no', 'I said no');
		$this->config->loadConfiguration('/dev/trash', $phpfunc);
		$this->assertEquals(new \stdClass(), ReflectionHelper::getValue($this->config, 'data'));

		$this->config->set('no', 'I said no');
		$this->config->loadConfiguration('/dev/invalid', $phpfunc);
		$this->assertEquals(new \stdClass(), ReflectionHelper::getValue($this->config, 'data'));

		$this->config->set('no', 'I said no');
		$this->config->loadConfiguration('/dev/fake', $phpfunc);
		$this->assertEquals('bar', $this->config->get('foo'));
	}

	public function testSaveConfiguration()
	{
		$this->markTestIncomplete('This test has not yet been implemented');
	}

	protected function setUp()
	{
		$this->config = new Configuration(static::$container);
	}
}