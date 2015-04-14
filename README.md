# Custom [Drupal 7](http://drupal.org) installation profile.

Custom installation profile for quicker development of new Drupal websites.

The following actions are executed upon installation:

- Text formats created: `Filtered HTML` and `Full HTML`.
- A simple child theme based on [Rubik](http://drupal.org/project/rubik) is enabled and set as administrator theme. Child theme enables you to make necessary modifications without touching the theme itself.
- All necessary default blocks (help, content) are assigned to proper regions in both - front-end and back-end themes
- Node type created: `Page`. Not promoted to front page, hidden author info and with comments disabled.
- Create new role for administrators and grant all permissions to it.
- Remove the "Find content" shortcut link, which is duplicated when the `Toolbar` core module is enabled together with `Shortcut`.
- Add some most used links to the shortcut menu: `Content types`, `Views`, `Menus`, `Blocks`, `PHP` (`devel/php`), `Performance`.

#### Variables and additional configuration

- Allow visitor account creation with administrative approval.
- Increase the default number of database log messages to 1.000.000.
- Extend the shortcut limit from 7 to 12 links.
- Switch off automatic cron run, triggered during regular page loads.
- Views: disable "Show advanced help warning".
- Views: disable "Automatically update preview on changes".
- Views: disable "Show information and statistics (...)".
- Pathauto: transliterate all URLs prior to creating alias.
- Pathauto: set custom URL rules for different content types. Overriding default `content/[node:title]` with `[node:content-type]/[node:title]` as defaults and just `[node:title]` for pages.

### Included modules

- [Admin Menu](http://drupal.org/project/admin_menu) with [Adminimal Admin Menu](http://drupal.org/project/adminimal_admin_menu) theme
- [Backup Migrate](http://drupal.org/project/backup_migrate)
- [Chaos Tools](http://drupal.org/project/ctools)
- [Devel](http://drupal.org/project/devel)
- [Entity](http://drupal.org/project/entity)
- [Filefield Sources](http://drupal.org/project/filefield_sources)
- [Filefield Sources Plupload](http://drupal.org/project/filefield_sources_plupload)
- [Globalredirect](http://drupal.org/project/globalredirect)
- [Libraries API](http://drupal.org/project/libraries)
- [Module Filter](http://drupal.org/project/module_filter)
- [Pathauto](http://drupal.org/project/pathauto)
- [Plupload](http://drupal.org/project/plupload)
- [Rules](http://drupal.org/project/rules)
- [Token](http://drupal.org/project/token)
- [Transliteration](http://drupal.org/project/transliteration)
- [Views](http://drupal.org/project/views)
- [WYSIWYG](http://drupal.org/project/wysiwyg)

### Included themes

- [Rubik admin theme](http://drupal.org/project/rubik). Note: the profile will automatically use a custom child theme of Rubik, to make any necessary modifications easier.
- [Tao base theme](http://drupal.org/project/tao) (required by Rubik)

<hr>

By: [topsitemakers.com](http://www.topsitemakers.com).
