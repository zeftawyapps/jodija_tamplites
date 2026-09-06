library JoDija_tamplites;

// ============================================================================
// 1. الحزم الأساسية الخارجية (Core Foundation Packages)
// ============================================================================
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:provider/provider.dart';
export 'package:intl/intl.dart';
export 'package:flutter_animate/flutter_animate.dart';
export 'package:animate_do/animate_do.dart';
export 'package:path_provider/path_provider.dart';
export 'package:sqflite/sqflite.dart';
export 'package:sqflite_common_ffi/sqflite_ffi.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:dio/dio.dart' hide FormData;
export 'package:image_picker/image_picker.dart';
export 'package:image_cropper/image_cropper.dart';
export 'package:uuid/uuid.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:go_router/go_router.dart';
export 'package:get_it/get_it.dart';

// ============================================================================
// 2. إعدادات المشروع والاتصال (Project Configuration & HTTP Connector)
// ============================================================================
export 'project_configrations/app_configration.dart';
export 'project_configrations/http_connector.dart';

// ============================================================================
// 3. نظام الثيمات والتصميم والألوان (Themes, Colors, Decorations & Assets)
// ============================================================================
export 'theams/colors/colors.dart';
export 'theams/theams/theams.dart';
export 'theams/assets/iamges.dart';
export 'theams/decorations/docorations.dart';
export 'theams/decorations/dimenstions.dart';
export 'theams/decorations/text_styles.dart';

// ============================================================================
// 4. قوالب لوحة التحكم والشاشات التكيفية (Adaptive App Shell & Dashboard Templates)
// ============================================================================
// Main App Shell Launcher & Examples
export 'tampletes/screens/routed_contral_panal/laaunser.dart';
export 'tampletes/screens/routed_contral_panal/examples_adaptive_app_shell.dart';
export 'tampletes/screens/routed_contral_panal/example_animation_usage.dart';

// App Shell Models & Configurations
export 'tampletes/screens/routed_contral_panal/models/app_bar_config.dart';
export 'tampletes/screens/routed_contral_panal/models/app_shell_data.dart';
export 'tampletes/screens/routed_contral_panal/models/route_item.dart';
export 'tampletes/screens/routed_contral_panal/models/sidebar_header_config.dart';

// App Shell Providers & State Management
export 'tampletes/screens/routed_contral_panal/providers/sidebar_provider.dart';
export 'tampletes/screens/routed_contral_panal/providers/settings_provider.dart';
export 'tampletes/screens/routed_contral_panal/providers/status_provider.dart';

// App Shell Themes, Mixins & Utilities
export 'tampletes/screens/routed_contral_panal/theam/theam.dart';
export 'tampletes/screens/routed_contral_panal/mixins/app_shell_mixin.dart';
export 'tampletes/screens/routed_contral_panal/utiles/routes.dart';
export 'tampletes/screens/routed_contral_panal/utiles/side_bar_navigation_router.dart';
export 'tampletes/screens/routed_contral_panal/utiles/side_bar_router_provider.dart';
export 'tampletes/screens/routed_contral_panal/utiles/settings_manager.dart';
export 'tampletes/screens/routed_contral_panal/utils/screen_utils.dart';
export 'tampletes/screens/routed_contral_panal/utils/app_shell_utils.dart';

// App Shell Screens & Content Screens
export 'tampletes/screens/routed_contral_panal/screens/main_screen.dart';
export 'tampletes/screens/routed_contral_panal/screens/login_screen.dart';
export 'tampletes/screens/routed_contral_panal/screens/splash_screen.dart';
export 'tampletes/screens/routed_contral_panal/screens/content/dashboard_screen.dart';
export 'tampletes/screens/routed_contral_panal/screens/content/analytics_screen.dart';
export 'tampletes/screens/routed_contral_panal/screens/content/profile_screen.dart';
export 'tampletes/screens/routed_contral_panal/screens/content/settings_screen.dart';
export 'tampletes/screens/routed_contral_panal/screens/content/error_screen.dart';
export 'tampletes/screens/routed_contral_panal/screens/content/custom_content_screen.dart';

// App Shell Widgets
export 'tampletes/screens/routed_contral_panal/widgets/sidebar_widget.dart';
export 'tampletes/screens/routed_contral_panal/widgets/sidebar_item_widget.dart';
export 'tampletes/screens/routed_contral_panal/widgets/sidebar_group_item_widget.dart';
export 'tampletes/screens/routed_contral_panal/widgets/collapsed_sidebar_widgets.dart';
export 'tampletes/screens/routed_contral_panal/widgets/drower_widget.dart';
export 'tampletes/screens/routed_contral_panal/widgets/app_drawer_widget.dart';
export 'tampletes/screens/routed_contral_panal/widgets/non_routed_page.dart';

// ============================================================================
// 5. محرك الخلايا ونماذج البيانات (Cell Engine & Dynamic Data Models)
// ============================================================================
export 'util/cell_models/cell.dart';
export 'util/cell_models/cell_data_type.dart';
export 'util/cell_models/repeater_cell.dart';
export 'util/cell_models/row_cells.dart';
export 'util/cell_models/modul_screateor.dart';
export 'util/cell_models/data-operations.dart';

// ============================================================================
// 6. التخزين المحلي وقواعد البيانات (Local Storage, SQLite & CRUD)
// ============================================================================
export 'util/local_storage/data_model.dart';
export 'util/local_storage/base_data_model.dart';
export 'util/local_storage/i_crud.dart';
export 'util/local_storage/base_crud_repository.dart';
export 'util/local_storage/local_data_helper.dart';

// ============================================================================
// 7. إدارة الحالة ومصادر البيانات (Data Source BLoC & Remote State)
// ============================================================================
export 'util/data_souce_bloc/remote_base_model.dart';
export 'util/data_souce_bloc/base_state.dart';
export 'util/data_souce_bloc/base_bloc.dart';
export 'util/data_souce_bloc/crud_bloc.dart';
export 'util/data_souce_bloc/feature_data_source_state.dart';

// ============================================================================
// 8. عناصر الإدخال والربط التلقائي (Input & Output Cell Binder)
// ============================================================================
export 'util/widgits/input_output_cell_binder/field.dart';
export 'util/widgits/input_output_cell_binder/field_model_binder.dart';
export 'util/widgits/input_output_cell_binder/cell_field_builder.dart';
export 'util/widgits/input_output_cell_binder/intpu_cell_binder.dart';
export 'util/widgits/input_output_cell_binder/IFeild_binder.dart';
export 'util/widgits/input_output_cell_binder/widgets/data_table_cell_binder.dart';

// ============================================================================
// 9. التحقق من صحة النماذج (Form Validation & Validation Widgets)
// ============================================================================
export 'util/widgits/input_form_validation/form_validations.dart';
export 'util/widgits/input_form_validation/input_validation_item.dart';
export 'util/widgits/input_form_validation/lable_desplty.dart';
export 'util/widgits/input_form_validation/widgets/text_form_vlidation.dart';
export 'util/widgits/input_form_validation/widgets/drobdaown_validation.dart';
export 'util/widgits/input_form_validation/widgets/dateTime_text_form_field_validation.dart';
export 'util/widgits/input_form_validation/widgets/refrance_text_form_field_validation.dart';

// ============================================================================
// 10. أدوات التحقق المخصصة (Validators)
// ============================================================================
export 'util/validators/base_validator.dart';
export 'util/validators/required_validator.dart';
export 'util/validators/numper_validator.dart';
export 'util/validators/email_validator.dart';
export 'util/validators/password_validator.dart';
export 'util/validators/datevalidation.dart';

// ============================================================================
// 11. حقول الإدخال النصية والتاريخ (Standard Input Fields)
// ============================================================================
export 'util/widgits/input_text/input_text_field.dart';
export 'util/widgits/input_text/dropDown_text_feild.dart';
export 'util/widgits/input_text/dateTime_input_text_field.dart';
export 'util/widgits/input_text/refrance_input_text_field.dart';

// ============================================================================
// 12. ودجات القوائم والمجموعات والجداول (Collections & Data Grid Widgets)
// ============================================================================
export 'util/widgits/collections_widgets/data_grid_table.dart';
export 'util/widgits/collections_widgets/group_list_view.dart';
export 'util/widgits/collections_widgets/group_grid_view.dart';
export 'util/widgits/collections_widgets/list_view_model.dart';
export 'util/widgits/collections_widgets/grid_view_model.dart';

// ============================================================================
// 13. ودجات BLoC المخصصة للبيانات (Data Source BLoC Widgets)
// ============================================================================
export 'util/widgits/data_source_bloc_widgets/data_source_bloc_builder.dart';
export 'util/widgits/data_source_bloc_widgets/data_source_bloc_listner.dart';
export 'util/widgits/data_source_bloc_widgets/data_source_bloc_consurmer.dart';
export 'util/widgits/bloc_provider.dart';

// ============================================================================
// 14. ودجات وإدارة الصور (Image Widgets & Image BLoC)
// ============================================================================
export 'util/widgits/images_widgets/image_picker_widget.dart';
export 'util/widgits/images_widgets/image_loader.dart';
export 'util/widgits/images_widgets/logo.dart';
export 'util/widgits/images_widgets/image_model.dart';
export 'util/widgits/images_widgets/imag_bloc.dart';
export 'util/widgits/images_widgets/add_image.dart';

// ============================================================================
// 15. عارضات ومزودات الشاشات (Screen Viewers & Notifiers)
// ============================================================================
export 'util/widgits/screen_provider/screen_notfier.dart';
export 'util/widgits/screen_provider/screen_viewer.dart';
export 'util/widgits/screen_bloc_provider/screen_notfier.dart';
export 'util/widgits/screen_bloc_provider/screen_viewer.dart';

// ============================================================================
// 16. التبويبات والقوائم المنبثقة (Tabs & Pop-up Menus)
// ============================================================================
export 'util/widgits/taps/tap_widget.dart';
export 'util/widgits/taps/tap_itme.dart';
export 'util/widgits/taps/tap_item_interface.dart';
export 'util/widgits/pob_up_menues/pubUpmenu.dart';
export 'util/widgits/pob_up_menues/items.dart';

// ============================================================================
// 17. إعدادات التطبيق العامة (Application Global Settings)
// ============================================================================
export 'util/app_settings/provider.dart';
export 'util/app_settings/settings_model.dart';
export 'util/app_settings/settings_inherted.dart';

// ============================================================================
// 18. التخزين المشترك والجلسة (SharedPreferences & User Storage)
// ============================================================================
export 'util/shardeprefrance/shardPrfrance.dart';
export 'util/shardeprefrance/shard_check.dart';
export 'util/shardeprefrance/shardUserModel.dart';
export 'util/shardeprefrance/user_data_stored.dart';

// ============================================================================
// 19. الترجمة واللغات (Localization & Internationalization)
// ============================================================================
export 'util/localization/loaclized_init.dart';
export 'util/localization/loclization/app_localizations.dart';
export 'util/localization/loclization/laoclization.inits.dart';

// ============================================================================
// 20. الملاحة والتوجيه (Navigation & Routing Services)
// ============================================================================
export 'util/navigations/INavigation_service.dart';
export 'util/navigations/navigation_service.dart';
export 'util/navigations/genrating_routes.dart';
export 'util/navigations/animation_types.dart';
export 'util/navigations/web_route.dart';

// ============================================================================
// 21. تحديد التبعيات وحاقن الخدمات (Dependency Injection)
// ============================================================================
export 'util/depenacy_locator.dart';

// ============================================================================
// 22. شاشات وتخطيط المشروع الأساسي (Project Screen & Screen Types)
// ============================================================================
export 'util/main-screen/project-screen.dart';
export 'util/main-screen/screen-type.dart';

// ============================================================================
// 23. نماذج العرض ومجموعات البيانات (View Data Models & Data Group Models)
// ============================================================================
export 'util/view_data_model/base_data_model.dart';
export 'util/view_data_model/data_group_model.dart';

// ============================================================================
// 24. دوال ومساعدات عامة (Utility Functions, Logging & JSON Helpers)
// ============================================================================
export 'util/functions/launchers.dart';
export 'util/functions/date_time.dart';
export 'util/functions/show_dialog.dart';
export 'util/conslol-logs/conslot-log.dart';
export 'util/jsonengen/json_asset_reader.dart';
export 'util/jsonengen/json_file_manger.dart';
