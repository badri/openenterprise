<?php

/**
 * @file openenterprise.wysiwyg.inc
 * 
 * This has been split out as it was getting too long and may be reused elsewhere.
 * 
 * Install setup for:
 * Filtered HTML Text Filter
 * WYSIWYG Configuration for Filtered HTML
 * Full HTML Text Filter
 * WYSIWYG Configuration for Full HTML
 * Authenticated role permissions for Filtered HTML format
 */

function openenterprise_wysiwyg_formats() {
  // Filtered HTML Text Filter
  $filtered_html_format = array(
    'format' => 'filtered_html',
    'name' => 'Filtered HTML',
    'weight' => 0,
    'filters' => array(
      // Caption filter
      'caption_filter' => array(
        'weight' => 20,
        'status' => 1,
      ),
      // Line break filter.
      'filter_autop' => array(
        'weight' => 0,
        'status' => 0,
      ),
      // URL filter.
      'filter_url' => array(
        'weight' => 0,
        'status' => 1,
        'settings' => array(
          'filter_url_length' => '72',
        )
      ),
      // HTML filter.
      'filter_html' => array(
        'weight' => 1,
        'status' => 0,
        'settings' => array(
          'allowed_html' => '<a> <img> <br> <em> <p> <strong> <cite> <span> <blockquote> <ul> <ol> <li> <pre> <address> <h2> <h3> <h4> <h5> <h6>',
          'filter_html_help' => 1,
          'filter_html_nofollow' => 0,
        ),
      ),
      // WYSIWYG HTML filter.
      'wysiwyg_filter' => array(
        'weight' => 1,
        'status' => 1,
        'settings' => array(
          'valid_elements' => 'a[!href|target<_blank|title],
div[align<center?justify?left?right],
p[align<center?justify?left?right],
br,span,em,strong,cite,code,blockquote,ul,ol,li,dl,dt,dd
img[!src|alt|width|height|class|typeof],
@[class|style|title]',
          'allow_comments' => 0,
          'nofollow_policy' => 'disabled',
          'style_text' => array(
            'text-align' => 'text-align',
          ),
        ),
      ),
      // Image Resize Filter.
      'image_resize_filter' => array(
        'weight' => 0,
        'status' => 1,
        'settings' => array(
          'link' => 0,
          'link_class' => '',
          'link_rel' => '',
          'image_locations' => array(
            'local' => 'local',
            'remote' => 0,
          ),
        ),
      ),
    ),
  );
  $filtered_html_format = (object) $filtered_html_format;
  filter_format_save($filtered_html_format);

  // WYSIWYG Configuration for Filtered HTML
  $filtered_html_wysiwyg = array(
    'format' => 'filtered_html',
    'editor' => 'tinymce',
    'settings' => array(
      'default' => 1,
      'user_choose' => 0,
      'show_toggle' => 0,
      'theme' => 'advanced',
      'language' => 'en',
      'buttons' => array(
        'default' => array(
          'bold' => 1,
          'italic' => 1,
          'justifyleft' => 1,
          'justifycenter' => 1,
          'justifyright' => 1,
          'bullist' => 1,
          'numlist' => 1,
          'link' => 1,
          'unlink' => 1,
          'image' => 1,
          'cut' => 1,
          'copy' => 1,
          'paste' => 1,
          'removeformat' => 1,
        ),
        'advimage' => array(
          'advimage' => 1,
        ),
        'font' => array(
          'formatselect' => 1,
          'styleselect' => 1,
        ),
        'paste' => array(
          'pastetext' => 1,
          'pasteword' => 1,
        ),
        'captionfilter' => array(
          'captionfilter' => 1, 
        ),
      ),
      'toolbar_loc' => 'top',
      'toolbar_align' => 'left',
      'path_loc' => 'bottom',
      'resizing' => 1,
      'verify_html' => 0,
      'preformatted' => 0,
      'convert_fonts_to_spans' => 1,
      'remove_linebreaks' => 0,
      'apply_source_formatting' => 1,
      'paste_auto_cleanup_on_paste' => 1,
      'block_formats' => 'p,address,pre,h2,h3,h4,h5,h6,div',
      'css_setting' => 'theme',
      'css_path' => '',
      'css_classes' => 'Align Image Right=align-right
Align Image Left=align-left',
    ),
  );
  $filtered_html_wysiwyg['settings'] = serialize($filtered_html_wysiwyg['settings']);
  drupal_write_record('wysiwyg', $filtered_html_wysiwyg);

  // Full HTML Text Filter
  $full_html_format = array(
    'format' => 'full_html',
    'name' => 'Full HTML',
    'weight' => 1,
    'filters' => array(
      // Caption filter
      'caption_filter' => array(
        'weight' => 20,
        'status' => 1,
      ),
      // Line break filter.
      'filter_autop' => array(
        'weight' => 0,
        'status' => 0,
      ),
      // URL filter.
      'filter_url' => array(
        'weight' => 0,
        'status' => 1,
        'settings' => array(
          'filter_url_length' => '72',
        )
      ),
      // URL filter.
      'filter_url' => array(
        'weight' => 0,
        'status' => 1,
      ),
      // HTML filter.
      'filter_html' => array(
        'weight' => 1,
        'status' => 0,
      ),
      // WYSIWYG HTML filter.
      'wysiwyg_filter' => array(
        'weight' => 1,
        'status' => 0,
        'settings' => array(
          'valid_elements' => 'a[!href|target<_blank|title],
div[align<center?justify?left?right],
p[align<center?justify?left?right],
br,span,em,strong,cite,code,blockquote,ul,ol,li,dl,dt,dd
img[!src|alt|width|height|class|typeof],
@[class|style|title]',
          'allow_comments' => 0,
          'nofollow_policy' => 'disabled',
          'style_text' => array(
            'text-align' => 'text-align',
          ),
          'style_layout' => array(
            'float' => 'float',
          ),
        ),
      ),
      // Image Resize Filter.
      'image_resize_filter' => array(
        'weight' => 0,
        'status' => 1,
        'settings' => array(
          'link' => 0,
          'link_class' => '',
          'link_rel' => '',
          'image_locations' => array(
            'local' => 'local',
            'remote' => 0,
          ),
        ),
      ),
    ),
  );
  $full_html_format = (object) $full_html_format;
  filter_format_save($full_html_format);

  // WYSIWYG Configuration for Full HTML
  $full_html_wysiwyg = array(
    'format' => 'full_html',
    'editor' => 'tinymce',
    'settings' => array(
      'default' => 1,
      'user_choose' => 0,
      'show_toggle' => 0,
      'theme' => 'advanced',
      'language' => 'en',
      'buttons' => array(
        'default' => array(
          'bold' => 1,
          'italic' => 1,
          'justifyleft' => 1,
          'justifycenter' => 1,
          'justifyright' => 1,
          'bullist' => 1,
          'numlist' => 1,
          'link' => 1,
          'unlink' => 1,
          'image' => 1,
          'cut' => 1,
          'copy' => 1,
          'paste' => 1,
          'removeformat' => 1,
        ),
        'advimage' => array(
          'advimage' => 1,
        ),
        'font' => array(
          'formatselect' => 1,
          'styleselect' => 1,
        ),
        'paste' => array(
          'pastetext' => 1,
          'pasteword' => 1,
        ),
        'captionfilter' => array(
          'captionfilter' => 1, 
        ),
      ),
      'toolbar_loc' => 'top',
      'toolbar_align' => 'left',
      'path_loc' => 'bottom',
      'resizing' => 1,
      'verify_html' => 0,
      'preformatted' => 0,
      'convert_fonts_to_spans' => 1,
      'remove_linebreaks' => 0,
      'apply_source_formatting' => 1,
      'paste_auto_cleanup_on_paste' => 1,
      'block_formats' => 'p,address,pre,h2,h3,h4,h5,h6,div',
      'css_setting' => 'theme',
      'css_path' => '',
      'css_classes' => 'Align Image Right=align-right
Align Image Left=align-left',
    ),
  );
  $full_html_wysiwyg['settings'] = serialize($full_html_wysiwyg['settings']);
  drupal_write_record('wysiwyg', $full_html_wysiwyg);

  // Enable default permissions for system roles.
  $filtered_html_permission = filter_permission_name($filtered_html_format);
  //user_role_grant_permissions(DRUPAL_ANONYMOUS_RID, array('access content', 'access comments', $filtered_html_permission));
  user_role_grant_permissions(DRUPAL_AUTHENTICATED_RID, array('access content', 'access comments', 'post comments', 'skip comment approval', $filtered_html_permission));  
}