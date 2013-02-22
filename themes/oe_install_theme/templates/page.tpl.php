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
      <div class="visible-phone mobile-menu">
        <a class="toggle btn btn-primary" href="javascript:void(0);">Menu <i class="icon-menu"></i></a>
      </div>
      <nav id="menu" class="span9 pull-right" role="navigation">
        <?php print render($page['menu']); ?>
        <div class="menu-indicator top hidden-phone"></div>
        <div class="menu-indicator bottom hidden-phone"></div>
      </nav>
    </div>
  </div>
</header>
<?php
  $featured = render($page['featured']);
  if ($featured):
?>
<div id="featured" role="banner">
  <div class=" container">
    <div class="row-fluid">
      <div class="span12">
        <?php print render($page['featured']); ?>
      </div>
    </div>
  </div>
</div>
<?php
  endif;
  $main_classes = array();
  if ($featured) {
    $main_classes[] = 'has-feature';
  }
  if ($title) {
    $main_classes[] = 'has-page-title';
  }
?>
<div id="main"<?php if ($main_classes): ?> class="<?php print implode(' ', $main_classes); ?>"<?php endif; ?>>
  <div class=" container">
    <div class="row-fluid">
      <header role="banner" id="page-header">
        <?php if ( $site_slogan ): ?>
          <p class="lead"><?php print $site_slogan; ?></p>
        <?php endif; ?>
        <?php print render($page['header']); ?>
      </header> <!-- /#header -->
    </div>
    <div class="row-fluid">
      <?php if ($page['sidebar_first']): ?>
        <aside class="span3" role="complementary">
          <?php print render($page['sidebar_first']); ?>
        </aside>  <!-- /#sidebar-first -->
      <?php endif; ?>  
      <section class="<?php print _bootstrap_content_span($columns); ?>">  
        <?php if ($page['highlighted']): ?>
          <div class="highlighted hero-unit"><?php print render($page['highlighted']); ?></div>
        <?php endif; ?>
        <a id="main-content"></a>
        <?php print render($title_prefix); ?>
        <?php if ($title && !drupal_is_front_page()): ?>
          <h1 class="page-title"><?php print $title; ?></h1>
        <?php endif; ?>
        <?php print render($title_suffix); ?>
        <?php print $messages; ?>
        <?php if ($tabs && !drupal_is_front_page()): ?>
          <?php print render($tabs); ?>
        <?php endif; ?>
        <?php if ($page['help']): ?> 
          <div class="well"><?php print render($page['help']); ?></div>
        <?php endif; ?>
        <?php if ($action_links && !drupal_is_front_page()): ?>
          <ul class="action-links"><?php print render($action_links); ?></ul>
        <?php endif; ?>
        <?php print render($page['content']); ?>
      </section>
      <?php if ($page['sidebar_second']): ?>
        <aside class="span3" role="complementary">
          <?php print render($page['sidebar_second']); ?>
        </aside>  <!-- /#sidebar-second -->
      <?php endif; ?>
    </div>
  </div>
</div>
<footer id="footer">
  <div class="container">
    <div class="row-fluid">
      <?php print render($page['footer']); ?>
    </div>
  </div>
</footer>
