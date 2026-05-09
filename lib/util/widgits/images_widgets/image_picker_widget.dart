import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:typed_data';

/// أنواع التحقق من أبعاد الصورة
enum DimensionRule {
  min, // لا تقل عن (الأدنى)
  max, // لا تزيد عن (الأقصى)
  exact, // تساوي تماماً
}

/// نموذج لحفظ بيانات الصورة المختارة
class ImageFileModel {
  final XFile? xFile;
  final File? file;
  final Uint8List? bytes;
  final String? networkUrl;
  final int? fileSizeInBytes;
  final int? width;
  final int? height;

  ImageFileModel({
    this.xFile,
    this.file,
    this.bytes,
    this.networkUrl,
    this.fileSizeInBytes,
    this.width,
    this.height,
  });

  bool get hasImage =>
      xFile != null || file != null || bytes != null || networkUrl != null;

  /// حجم الملف بالكيلوبايت
  double? get fileSizeInKB =>
      fileSizeInBytes != null ? fileSizeInBytes! / 1024 : null;

  /// حجم الملف بالميجابايت
  double? get fileSizeInMB =>
      fileSizeInBytes != null ? fileSizeInBytes! / (1024 * 1024) : null;

  /// نص مقروء لحجم الملف
  String get readableFileSize {
    if (fileSizeInBytes == null) return 'غير معروف';
    if (fileSizeInBytes! < 1024) return '${fileSizeInBytes} بايت';
    if (fileSizeInBytes! < 1024 * 1024)
      return '${fileSizeInKB!.toStringAsFixed(2)} كيلوبايت';
    return '${fileSizeInMB!.toStringAsFixed(2)} ميجابايت';
  }
}

/// Widget محسّن لاختيار الصور مع دعم الويب والموبايل.
/// An enhanced widget for picking images with Web and Mobile support.
class ImagePecker extends StatefulWidget {
  /// دالة يتم استدعاؤها عند اختيار صورة.
  /// Callback triggered when an image is selected.
  final Function(ImageFileModel imageModel) onImageSelected;

  /// الصورة الافتراضية (placeholder).
  /// The default placeholder image asset.
  final String placeholderAsset;

  /// رابط الصورة من الشبكة (إن وجد).
  /// The network image URL (if available).
  final String? networkImage;

  /// الارتفاع.
  /// The height of the image widget.
  final double height;

  /// العرض.
  /// The width of the image widget.
  final double width;

  /// شكل الحاوية (مستطيل أو دائرة).
  /// The shape of the image container (e.g., BoxShape.rectangle).
  final BoxShape shape;

  /// لون الخلفية.
  /// The background color.
  final Color backgroundColor;

  /// لون أيقونة الإضافة (اختياري، يفتراض لون السمة الأساسي).
  /// The add icon color (optional, defaults to primary theme color).
  final Color? iconColor;

  /// حجم الأيقونة.
  /// The icon size.
  final double iconSize;

  /// إطار الحاوية (Border).
  /// The container border.
  final BoxBorder? border;

  /// استدارة الحواف (يعمل فقط مع BoxShape.rectangle).
  /// The border radius (only works with BoxShape.rectangle).
  final BorderRadius? borderRadius;

  /// الظلال (Shadows).
  /// The box shadow list.
  final List<BoxShadow>? boxShadow;

  /// نص توضيحي يظهر أسفل الصورة.
  /// Helper text displayed below the image.
  final String? helperText;

  /// إمكانية التقاط صورة بالكاميرا (للموبايل فقط).
  /// Whether camera selection is enabled (mobile only).
  final bool enableCamera;

  /// إمكانية قص الصورة بعد اختيارها.
  /// Whether to show the crop tool after selecting an image.
  final bool enableCrop;

  /// نسبة العرض للارتفاع عند القص (null = حر).
  /// The crop aspect ratio (null for free ratio).
  final double? cropAspectRatio;

  /// الحد الأقصى لحجم الصورة بالميجابايت (null = بدون حد).
  /// The maximum file size in megabytes (null for no limit).
  final double? maxFileSizeMB;

  /// هل يتم إظهار حجم الملف تحت الصورة.
  /// Whether to show the file size below the image.
  final bool showFileSize;

  /// العرض المطلوب للمقاس.
  /// The required width for validation.
  final int? requiredWidth;

  /// الارتفاع المطلوب للمقاس.
  /// The required height for validation.
  final int? requiredHeight;

  /// قاعدة التحقق من الأبعاد (أدنى، أقصى، أو تماماً).
  /// The dimension validation rule (min, max, or exact).
  final DimensionRule dimensionRule;

  /// هل التحقق من المقاسات "صارم" (يرفض الصورة إذا لم تطابق).
  /// Whether dimension validation is strict (rejects if it doesn't match).
  final bool isStrict;

  const ImagePecker({
    Key? key,
    /// دالة اختيار الصورة.
    /// Image selection callback.
    required this.onImageSelected,
    /// مسار الصورة الافتراضية.
    /// Placeholder asset path.
    required this.placeholderAsset,
    /// مسار صورة الشبكة.
    /// Network image url.
    this.networkImage,
    /// الارتفاع.
    /// Height.
    this.height = 200,
    /// العرض.
    /// Width.
    this.width = double.infinity,
    /// شكل الحاوية.
    /// Container shape.
    this.shape = BoxShape.rectangle,
    /// لون الخلفية.
    /// Background color.
    this.backgroundColor = Colors.white,
    /// لون الأيقونة.
    /// Icon color.
    this.iconColor,
    /// حجم الأيقونة.
    /// Icon size.
    this.iconSize = 40,
    /// إطار الحاوية.
    /// Border.
    this.border,
    /// استدارة الحواف.
    /// Border radius.
    this.borderRadius,
    /// الظلال.
    /// Box shadow.
    this.boxShadow,
    /// نص مساعد.
    /// Helper text.
    this.helperText,
    /// تمكين الكاميرا.
    /// Enable camera.
    this.enableCamera = true,
    /// تمكين القص.
    /// Enable crop.
    this.enableCrop = true,
    /// نسبة القص المخصصة.
    /// Crop aspect ratio.
    this.cropAspectRatio,
    /// الحد الأقصى للحجم.
    /// Maximum file size.
    this.maxFileSizeMB,
    /// إظهار الحجم.
    /// Show file size.
    this.showFileSize = true,
    /// العرض المطلوب.
    /// Required width.
    this.requiredWidth,
    /// الارتفاع المطلوب.
    /// Required height.
    this.requiredHeight,
    /// قاعدة قياس الأبعاد.
    /// Dimension rule.
    this.dimensionRule = DimensionRule.min,
    /// هل هو صارم.
    /// Is strict validation.
    this.isStrict = false,
  }) : super(key: key);

  @override
  State<ImagePecker> createState() => _ImagePeckerState();
}

class _ImagePeckerState extends State<ImagePecker> {
  final ImagePicker _picker = ImagePicker();
  ImageFileModel? _currentImage;
  bool _showOptions = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // إذا كان هناك صورة شبكة، احفظها
    if (widget.networkImage != null && widget.networkImage!.isNotEmpty) {
      _currentImage = ImageFileModel(networkUrl: widget.networkImage);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _isLoading = true;
      _showOptions = false;
    });

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (pickedFile != null) {
        // احسب حجم الصورة الأصلية
        final int originalFileSize = await pickedFile.length();
        final double fileSizeMB = originalFileSize / (1024 * 1024);

        print('📏 حجم الصورة الأصلية: ${(fileSizeMB).toStringAsFixed(2)} MB');

        // تحقق من الحد الأقصى للحجم
        if (widget.maxFileSizeMB != null &&
            fileSizeMB > widget.maxFileSizeMB!) {
          setState(() => _isLoading = false);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '⚠️ حجم الصورة ${fileSizeMB.toStringAsFixed(2)} MB\n'
                  'الحد الأقصى ${widget.maxFileSizeMB} MB',
                ),
                backgroundColor: Colors.orange,
                duration: Duration(seconds: 4),
              ),
            );
          }
          return;
        }

        // إذا كان Crop مفعّل (للموبايل فقط)
        XFile? finalFile = pickedFile;
        if (widget.enableCrop && !kIsWeb) {
          finalFile = await _cropImage(pickedFile);
          if (finalFile == null) {
            // المستخدم ألغى عملية Crop
            setState(() => _isLoading = false);
            return;
          }
        }

        // احسب حجم الصورة النهائي
        final int finalFileSize = await finalFile.length();
        final Uint8List finalBytes = await finalFile.readAsBytes();

        // دائماً استخرج المقاسات (الأبعاد) للصورة المختارة
        final decodedImage = await decodeImageFromList(finalBytes);
        final int actualWidth = decodedImage.width;
        final int actualHeight = decodedImage.height;

        print('📐 أبعاد الصورة المختارة: $actualWidth × $actualHeight');

        // تحقق من المقاسات (الأبعاد) المطلوبة إذا كانت موجودة
        if (widget.requiredWidth != null || widget.requiredHeight != null) {
          bool isInvalid = false;
          String errorMsg = '';

          final int reqW = widget.requiredWidth ?? 0;
          final int reqH = widget.requiredHeight ?? 0;

          String ruleText = '';
          bool wFailed = false;
          bool hFailed = false;

          switch (widget.dimensionRule) {
            case DimensionRule.min:
              ruleText = 'الحد الأدنى';
              if (widget.requiredWidth != null && actualWidth < reqW)
                wFailed = true;
              if (widget.requiredHeight != null && actualHeight < reqH)
                hFailed = true;
              break;
            case DimensionRule.max:
              ruleText = 'الحد الأقصى';
              if (widget.requiredWidth != null && actualWidth > reqW)
                wFailed = true;
              if (widget.requiredHeight != null && actualHeight > reqH)
                hFailed = true;
              break;
            case DimensionRule.exact:
              ruleText = 'المقاس المطلوب';
              if (widget.requiredWidth != null && actualWidth != reqW)
                wFailed = true;
              if (widget.requiredHeight != null && actualHeight != reqH)
                hFailed = true;
              break;
          }

          if (wFailed || hFailed) {
            isInvalid = true;
            String requiredStr =
                '${widget.requiredWidth ?? "?"} × ${widget.requiredHeight ?? "?"}';
            String actualStr = '$actualWidth × $actualHeight';

            errorMsg = 'أبعاد الصورة غير متوافقة مع الشروط.\n\n'
                '• $ruleText المسموح: $requiredStr px\n'
                '• الأبعاد المختارة حالياً: $actualStr px';
          }

          if (isInvalid) {
            if (widget.isStrict) {
              setState(() => _isLoading = false);
              if (mounted) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red),
                        SizedBox(width: 8),
                        Text('مقاس الصورة غير متوافق'),
                      ],
                    ),
                    content: Text(
                      '$errorMsg.\n\nيرجى اختيار صورة تطابق الشروط المطلوبة.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('حسناً'),
                      ),
                    ],
                  ),
                );
              }
              return;
            } else {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('⚠️ تنبيه: $errorMsg'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            }
          }
        }

        ImageFileModel imageModel;

        if (kIsWeb) {
          // للويب: استخدم bytes
          imageModel = ImageFileModel(
            xFile: finalFile,
            bytes: finalBytes,
            fileSizeInBytes: finalFileSize,
            width: actualWidth,
            height: actualHeight,
          );
        } else {
          // للموبايل: استخدم File
          final file = File(finalFile.path);
          imageModel = ImageFileModel(
            xFile: finalFile,
            file: file,
            fileSizeInBytes: finalFileSize,
            width: actualWidth,
            height: actualHeight,
          );
        }

        setState(() {
          _currentImage = imageModel;
          _isLoading = false;
        });

        print('✅ حجم الصورة النهائي: ${imageModel.readableFileSize}');
        widget.onImageSelected(imageModel);
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في اختيار الصورة: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Crop الصورة (للموبايل فقط)
  Future<XFile?> _cropImage(XFile imageFile) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: widget.cropAspectRatio != null
            ? CropAspectRatio(ratioX: widget.cropAspectRatio!, ratioY: 1.0)
            : null,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'قص الصورة',
            toolbarColor: widget.iconColor ?? Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: widget.cropAspectRatio != null,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
          IOSUiSettings(
            title: 'قص الصورة',
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        return XFile(croppedFile.path);
      }
      return null;
    } catch (e) {
      print('⚠️ خطأ في Crop: $e');
      return imageFile; // ارجع الصورة الأصلية في حالة خطأ
    }
  }

  Widget _buildImage() {
    // إذا كان هناك صورة محلية (تم اختيارها)
    if (_currentImage?.bytes != null) {
      return Image.memory(
        _currentImage!.bytes!,
        fit: BoxFit.cover,
        width: widget.width,
        height: widget.height,
      );
    } else if (_currentImage?.file != null) {
      return Image.file(
        _currentImage!.file!,
        fit: BoxFit.cover,
        width: widget.width,
        height: widget.height,
      );
    }
    // إذا كان هناك صورة من الشبكة
    else if (_currentImage?.networkUrl != null &&
        _currentImage!.networkUrl!.isNotEmpty) {
      return Image.network(
        _currentImage!.networkUrl!,
        fit: BoxFit.cover,
        width: widget.width,
        height: widget.height,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }
    // الصورة الافتراضية
    else {
      return _buildPlaceholder();
    }
  }

  Widget _buildPlaceholder() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Image.asset(
        widget.placeholderAsset,
        fit: BoxFit.contain,
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _showOptions = !_showOptions;
            });
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              shape: widget.shape,
              borderRadius: widget.shape == BoxShape.rectangle
                  ? widget.borderRadius
                  : null,
              border: widget.border ??
                  Border.all(
                    color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                    width: 2,
                  ),
              boxShadow: widget.boxShadow,
            ),
            child: Stack(
              children: [
                // الصورة
                ClipRRect(
                  borderRadius: widget.shape == BoxShape.rectangle
                      ? (widget.borderRadius ?? BorderRadius.zero)
                      : BorderRadius.circular(widget.height / 2),
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: widget.iconColor ??
                                Theme.of(context).primaryColor,
                          ),
                        )
                      : _buildImage(),
                ),

                // أيقونة الإضافة
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: widget.iconColor ?? Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                      size: widget.iconSize * 0.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // خيارات اختيار الصورة
        if (_showOptions)
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // الكاميرا (للموبايل فقط)
                if (!kIsWeb && widget.enableCamera) ...[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: Icon(Icons.camera_alt),
                      label: Text('كاميرا'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            widget.iconColor ?? Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                ],

                // المعرض
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: Icon(Icons.photo_library),
                    label: Text('معرض'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          widget.iconColor ?? Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // نص توضيحي
        if (widget.helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.helperText!,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),

        // عرض حجم الملف
        if (widget.showFileSize && _currentImage?.fileSizeInBytes != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: (widget.iconColor ?? Theme.of(context).primaryColor)
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.insert_drive_file,
                    size: 14,
                    color: widget.iconColor ?? Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 4),
                  Text(
                    _currentImage!.readableFileSize,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: widget.iconColor ?? Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

        // عرض الأبعاد المطلوبة
        if (widget.requiredWidth != null && widget.requiredHeight != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.aspect_ratio,
                  size: 14,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
                SizedBox(width: 4),
                Text(
                  () {
                    String prefix = 'المقاس المطلوب:';
                    if (widget.dimensionRule == DimensionRule.min)
                      prefix = 'الحد الأدنى للمقاس:';
                    if (widget.dimensionRule == DimensionRule.max)
                      prefix = 'الحد الأقصى للمقاس:';
                    if (widget.dimensionRule == DimensionRule.exact)
                      prefix = 'المقاس المطلوب تماماً:';
                    return '$prefix ${widget.requiredWidth} × ${widget.requiredHeight}';
                  }(),
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

        // عرض أبعاد الصورة المختارة حالياً
        if (_currentImage?.width != null && _currentImage?.height != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo_size_select_actual,
                  size: 14,
                  color: isDark ? Colors.green[300] : Colors.green[700],
                ),
                SizedBox(width: 4),
                Text(
                  'أبعاد الصورة المختارة: ${_currentImage!.width} × ${_currentImage!.height}',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? Colors.green[300] : Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
