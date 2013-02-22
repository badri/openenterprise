<!DOCTYPE html>
<html lang="<?php print $language->language; ?>">
<head>
  <title><?php print $head_title; ?></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0"/>
  <meta name="p:domain_verify" content="9e65938441a8c80816feb7f9f4bc3331" />
  <link rel="alternate" type="application/rss+xml" href="http://feeds.feedburner.com/leveltenblog" title="LevelTen Blog">
  
  <?php print $head; ?>  
  <!--[if lt IE 9]><script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
  <?php print $styles; ?>
  <?php print $scripts; ?>
</head>
<body class="<?php print $classes; ?>" <?php print $attributes;?>>
  <div id="wrapper">
    <header id="header" role="header">
      <div class="navigation-inner container">
        <div class="row-fluid">
          <div id="logo" class="span3 pull-left">
            <?php if ($logo): ?>
              <a href="<?php print $front_page; ?>" title="<?php print t('Home'); ?>">
                <img src="<?php print $logo; ?>" alt="<?php print t('Home'); ?>" />
              </a>
            <?php endif; ?>
            <?php if ($site_name): ?>
              <h1 id="site-name">
                <a href="<?php print $front_page; ?>" title="<?php print t('Home'); ?>" class="brand"><?php print $site_name; ?></a>
              </h1>
            <?php endif; ?>
          </div>
          <?php if ($sidebar_first): ?>
          <aside id="sidebar-first" class="span9" role="complementary">
            <?php print $sidebar_first; ?>
          </aside>  <!-- /#sidebar-first -->
          <?php endif; ?>  
        </div>
      </div>
    </header>
    <div id="main">
      <div class=" container">
        <div class="row-fluid">
          <section id="content" class="region-content span12">  
            <i class="icon-drupal floating-icon"></i>
            <a id="main-content"></a>
            <?php if ($title): ?>
              <h1 class="page-title"><?php print $title; ?></h1>
            <?php endif; ?>
            <?php if ($messages): ?>
              <?php print $messages; ?>
            <?php endif; ?>
            <?php if ($help): ?>
              <div id="help">
                <?php print $help; ?>
              </div>
            <?php endif; ?>
            <?php print $content; ?>
          </section>
        </div>
      </div>
    </div>
    <footer id="footer">
      <div class="container">
        <div class="row-fluid">
          <div class="span4">
            OpenEnterprise is a distribution from <a href="http://www.leveltendesign.com" target="_blank">LevelTen Interactive</a>. Copyright &copy; <?php print date('Y'); ?>. All rights reserved.
          </div>
          <div class="span4"></div>
          <div class="span4">
            Drupal is a <a href="http://drupal.com/trademark" target="_blank">registered trademark</a><br />of <a href="http://buytaert.net" target="_blank">Dries Buytaert</a>.
          </div>
        </div>
      </div>
    </footer>
  </div>
</body>
</html>