<?php
/**
 * @link https://www.humhub.org/
 * @copyright Copyright (c) 2018 HumHub GmbH & Co. KG
 * @license https://www.humhub.com/licences
 *
 */

use yii\bootstrap\Html;

/* @var $this \humhub\components\View */
/* @var $options [] */
/* @var $selection [] */
/* @var $items [] */
?>
<div class="form-group">
    <?= Html::dropDownList(null, $selection, $items, $options) ?>
</div>
