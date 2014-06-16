<?php
/**
 * @package		awf
 * @copyright	2014 Nicholas K. Dionysopoulos / Akeeba Ltd 
 * @license		GNU GPL version 3 or later
 */

namespace Awf\Tests\Document;

use Awf\Application\Application;
use Awf\Document\Document;
use Awf\Tests\Helpers\ReflectionHelper;
use Awf\Tests\Stubs\Fakeapp\Container as FakeContainer;

/**
 * @package Awf\Tests\Document
 *
 * @coversDefaultClass \Awf\Document\Json
 */
class JsonTest extends \PHPUnit_Framework_TestCase
{
	/** @var FakeContainer A container suitable for unit testing */
	public static $container = null;

	public function __construct($name = null, array $data = array(), $dataName = '')
	{
		parent::__construct($name, $data, $dataName);

		// We can't use setUpBeforeClass or setUp because PHPUnit will not run these methods before
		// getting the data from the data provider of each test :(

		ReflectionHelper::setValue('\\Awf\\Application\\Application', 'instances', array());

		// Convince the autoloader about our default app and its container
		static::$container = new FakeContainer();
		$app = \Awf\Application\Application::getInstance('Fakeapp', static::$container);

		$app->setTemplate('nada');
	}

	public function testSetAndGetUseHashes()
	{
		$document = Document::getInstance('json', Application::getInstance('Fakeapp'));
		$this->assertInstanceOf('\\Awf\\Document\\Json', $document);

		$document->setUseHashes(true);
		$this->assertTrue(ReflectionHelper::getValue($document, 'useHashes'));
		$this->assertTrue($document->getUseHashes());

		$document->setUseHashes(false);
		$this->assertFalse(ReflectionHelper::getValue($document, 'useHashes'));
		$this->assertFalse($document->getUseHashes());

		$document->setUseHashes(1);
		$this->assertTrue(ReflectionHelper::getValue($document, 'useHashes'));
		$this->assertTrue($document->getUseHashes());

		$document->setUseHashes(0);
		$this->assertFalse(ReflectionHelper::getValue($document, 'useHashes'));
		$this->assertFalse($document->getUseHashes());
	}

	public function testRenderJsonPlain()
	{
		$document = Document::getInstance('json', Application::getInstance('Fakeapp'));
		$this->assertInstanceOf('\\Awf\\Document\\Json', $document);
		$document->setBuffer("{test: true}");

		$this->expectOutputString('{test: true}');
		$document->render();

		$contentType = $document->getHTTPHeader('Content-Type');
		$this->assertEquals('application/json', $contentType);

		$contentDisposition = $document->getHTTPHeader('Content-Disposition');
		$this->assertNull($contentDisposition);
	}

	public function testRenderJsonHashes()
	{
		$document = Document::getInstance('json', Application::getInstance('Fakeapp'));
		$this->assertInstanceOf('\\Awf\\Document\\Json', $document);
		$document->setUseHashes(true);
		$document->setBuffer("{test: true}");

		$this->expectOutputString('###{test: true}###');
		$document->render();

		$contentType = $document->getHTTPHeader('Content-Type');
		$this->assertEquals('application/json', $contentType);

		$contentDisposition = $document->getHTTPHeader('Content-Disposition');
		$this->assertNull($contentDisposition);
	}

	public function testRenderJsonAttachment()
	{
		$document = Document::getInstance('json', Application::getInstance('Fakeapp'));
		$this->assertInstanceOf('\\Awf\\Document\\Json', $document);
		$document->setBuffer('{test: true}');
		$document->setName('foobar');
		$document->setUseHashes(false);

		$this->expectOutputString('{test: true}');
		$document->render();

		$contentType = $document->getHTTPHeader('Content-Type');
		$this->assertEquals('application/json', $contentType);

		$contentDisposition = $document->getHTTPHeader('Content-Disposition');
		$this->assertEquals('attachment; filename="foobar.json"', $contentDisposition);
	}
}
 