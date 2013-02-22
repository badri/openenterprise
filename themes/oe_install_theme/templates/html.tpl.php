<!DOCTYPE html>
<html lang="<?php print $language->language; ?>">
<head>
  <title><?php print $head_title; ?></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0"/>
  <meta name="p:domain_verify" content="9e65938441a8c80816feb7f9f4bc3331" />
  <link rel="alternate" type="application/rss+xml" href="http://feeds.feedburner.com/leveltenblog" title="LevelTen Blog">
  
  <?php print $head; ?>  
  <?php print $styles; ?>
  <?php print $scripts; ?>
  <!-- HTML5 element support for IE6-8 -->
  <!--[if lt IE 9]>
    <script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
  <!--[if IE 7]>
  <link rel="stylesheet" href="<?php print base_path() . drupal_get_path('theme', 'levelten'); ?>/bootstrap/css/fontello-ie7.css?1360343972">
  <![endif]-->
</head>
<body class="<?php print $classes; ?>" <?php print $attributes;?>>
  <div id="wrapper">
    <?php print $page_top; ?>
    <?php print $page; ?>
    <?php print $page_bottom; ?>
  </div>
  <script type="text/javascript">
  setTimeout(function(){var a=document.createElement("script");
  var b=document.getElementsByTagName("script")[0];
  a.src=document.location.protocol+"//dnn506yrbagrg.cloudfront.net/pages/scripts/0011/7283.js?"+Math.floor(new Date().getTime()/3600000);
  a.async=true;a.type="text/javascript";b.parentNode.insertBefore(a,b)}, 1);
  </script>
</body>
</html>
