<?php

/**
 * @link https://www.humhub.org/
 * @copyright Copyright (c) 2015 HumHub GmbH & Co. KG
 * @license https://www.humhub.com/licences
 */

namespace humhub\modules\content\assets;

use humhub\assets\CoreExtensionAsset;
use humhub\components\assets\AssetBundle;

/**
 * Asset for core content resources.
 *
 * @since 1.2
 * @author buddha
 */
class ContentAsset extends AssetBundle
{
     /**
     * @inheritdoc
     */
    public $sourcePath = '@content/resources';

     /**
     * @inheritdoc
     */
    public $js = [
        'js/humhub.content.js'
    ];

    public $depends = [
        CoreExtensionAsset::class
    ];
}
