<?php

/*
 * Implements hook_preprocess_html().
 */
function rubik_custom_preprocess_html(&$vars) {
  if (theme_get_setting('rubik_custom_inline_field_descriptions')) {
    $vars['classes_array'][] = 'rubik-inline-field-descriptions';
  }
}
