<?php

/**
 * @file
 * Enables modules and site configuration for a custom site installation.
 *
 * Created by: Topsitemakers
 * http://www.topsitemakers.com/
 */

/*
 * Define minimum execution time required to operate.
 */
define('DRUPAL_MINIMUM_MAX_EXECUTION_TIME', 60);

/**
 * Implements hook_install_tasks().
 */
function custom_install_tasks($install_state) {
  $tasks = array();
  $tasks['custom_task_add_menu_items'] = array(
    'type' => 'normal',
    'run' => INSTALL_TASK_RUN_IF_REACHED,
  );
  $tasks['custom_task_add_default_pages'] = array(
    'type' => 'normal',
    'run' => INSTALL_TASK_RUN_IF_REACHED,
  );

  return $tasks;
}

/**
 * Add most used links.
 */
function custom_task_add_menu_items() {
  // Remove all default shortcut links because they are useless.
  $shortcut_links = db_select('menu_links', 'l')
    ->fields('l', array('mlid'))
    ->condition('menu_name', 'shortcut-set-1')
    ->execute()
    ->fetchAll();
  foreach ($shortcut_links as $shortcut_link) {
    menu_link_delete($shortcut_link->mlid);
  }
  // Configure the links we will add to other menus (main menu and shortcut).
  $links = array(
    // Home link in the main menu.
    array(
      'link_title' => st('Home'),
      'link_path'  => '<front>',
      'menu_name'  => 'main-menu',
      'weight'     => 0,
    ),
    array(
      'link_title' => st('PHP'),
      'link_path'  => 'devel/php',
      'menu_name'  => 'shortcut-set-1',
      'weight'     => 0,
    ),
    array(
      'link_title' => st('Variables'),
      'link_path'  => 'devel/variable',
      'menu_name'  => 'shortcut-set-1',
      'weight'     => 1,
    ),
  );
  // Save links.
  foreach ($links as $link) {
    menu_link_save($link);
  }

  // Update the menu router information.
  menu_rebuild();
}

/**
 * Create 403 and 404 pages.
 */
function custom_task_add_default_pages() {
  // Common details.
  $page = new stdClass();
  $page->type = 'page';
  $page->language = LANGUAGE_NONE;
  node_object_prepare($page);
  $page->status = NODE_PUBLISHED;
  $page->uid = 1;
  $page->body[LANGUAGE_NONE][0]['format'] = 'filtered_html';
  // Home page.
  $home = clone $page;
  $home->title = 'Home';
  $home->body[LANGUAGE_NONE][0]['value'] = 'Placeholder';
  // 403.
  $access_denied = clone $page;
  $access_denied->title = 'Access Denied';
  $access_denied->body[LANGUAGE_NONE][0]['value'] = t('You do not have enough permissions to access this page. Please <a href="@login">login</a> to continue.', array('@login' => url('user/login')));
  // 404.
  $not_found = clone $page;
  $not_found->title = 'Page Not Found';
  $not_found->body[LANGUAGE_NONE][0]['value'] = t('The page you requested has not been found. Click <a href="@home">here</a> to go back to the home page.', array('@home' => url('<front>')));
  // Save pages.
  node_save($home);
  node_save($access_denied);
  node_save($not_found);
  // Set them up as default pages on 403/404 errors.
  variable_set('site_frontpage', 'node/' . $home->nid);
  variable_set('site_403', 'node/' . $access_denied->nid);
  variable_set('site_404', 'node/' . $not_found->nid);
}

/**
 * Implements hook_form_FORM_ID_alter() for install_configure_form().
 *
 * Allows the profile to alter the site configuration form.
 */
function custom_form_install_configure_form_alter(&$form, $form_state) {
  // Prepare some variables to be used as default values of the final form.
  $server_name = $_SERVER['SERVER_NAME'];
  // Check if there is a dot in the server name. This is aimed for local
  // development environments, for example if the site is running at localhost.
  // In order to create a valid email address, the '.com' is appended.
  // This is added just to make creating a new dev site faster.
  if (!strpos($server_name, '.')) {
    $server_name = $server_name . '.com';
  }
  $admin_email = 'admin@' . $server_name;

  // Pre-populate the site name with the server name.
  $form['site_information']['site_name']['#default_value'] = $_SERVER['SERVER_NAME'];
  // Set the default admin email address to "admin@domain.com".
  $form['site_information']['site_mail']['#default_value'] = $admin_email;
  // Set the default admin username and email address.
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  $form['admin_account']['account']['mail']['#default_value'] = $admin_email;
  // Set default country to US.
  $form['server_settings']['site_default_country']['#default_value'] = 'US';
}

/**
 * Implements hook_install_tasks_alter().
 */
function custom_install_tasks_alter(&$tasks, $install_state){
  global $install_state;
  // Skip the language selection screen and set the language to English by
  // default.
  $tasks['install_select_locale']['display'] = FALSE;
  $tasks['install_select_locale']['run']     = INSTALL_TASK_SKIP;
  $install_state['parameters']['locale']     = 'en';
}
