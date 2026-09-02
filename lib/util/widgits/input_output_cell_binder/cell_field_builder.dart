import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../cell_models/cell.dart';
import '../../cell_models/cell_data_type.dart';
import '../../cell_models/repeater_cell.dart';
import '../../cell_models/modul_screateor.dart';
import '../../validators/required_validator.dart';
import '../../validators/numper_validator.dart';
import '../../validators/email_validator.dart';
import '../../validators/base_validator.dart';
import '../input_form_validation/form_validations.dart';
import '../input_form_validation/widgets/text_form_vlidation.dart';
import '../input_form_validation/widgets/drobdaown_validation.dart';
import 'field.dart';
import 'field_model_binder.dart';

/// مُولد ومُحوّل الخلايا إلى حقول إدخال وعرض متكاملة
/// Cell-to-Field Builder Engine
class CellFieldBuilder {
  /// بناء كائن Field متكامل من كائن Cell وربطه بـ ValidationsForm
  static Field buildField({
    required Cell cell,
    required ValidationsForm form,
    Function(dynamic newValue)? onChanged,
  }) {
    final caption = cell.caption ?? cell.name;
    final field = Field(
      cell.name,
      value: cell.value,
      nameCaption: caption,
      type: cell.type,
      unit: cell.unit,
      options: cell.options,
      isRequired: cell.isRequired,
      hint: cell.hint,
      defaultValue: cell.defaultValue,
    );

    // 1. بناء Header الافتراضي للجداول
    field.header = Text(
      caption,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
    );

    // 2. بناء واجهة الإدخال والتحقق (inputField)
    field.inputField = _buildInputField(cell, field, form, onChanged);

    // 3. بناء واجهة العرض للقراءة (outputField)
    field.outputField = _buildOutputField(cell, field);

    return field;
  }

  /// بناء FeildModelBinder بالكامل من CellModel و ValidationsForm
  static FeildModelBinder buildBinderFromModel({
    required CellModel model,
    required ValidationsForm form,
    Function(String cellName, dynamic newValue)? onFieldChanged,
  }) {
    final binder = FeildModelBinder(cellDataModel: model);
    final cells = model.toCells() ?? [];

    for (final cell in cells) {
      final field = buildField(
        cell: cell,
        form: form,
        onChanged: (val) {
          cell.value = val;
          if (onFieldChanged != null) {
            onFieldChanged(cell.name, val);
          }
        },
      );
      binder.addField(field);
    }

    return binder;
  }

  // ===========================================================================
  // بناء عناصر الإدخال حسب نوع البيانات (Input Field Renderer)
  // ===========================================================================
  static Widget _buildInputField(
    Cell cell,
    Field field,
    ValidationsForm form,
    Function(dynamic newValue)? onChanged,
  ) {
    final caption = cell.caption ?? cell.name;
    final isDark = false; // سيتم توريث الثيم تلقائياً عبر context

    switch (cell.type) {
      // 1. الحقول النصية والرقمية (TextFormValidation)
      case CellDataType.text:
      case CellDataType.multilineText:
      case CellDataType.email:
      case CellDataType.phone:
      case CellDataType.password:
      case CellDataType.integer:
      case CellDataType.decimal:
      case CellDataType.measuredValue:
        final validators = <BaseValidator>[];
        if (cell.isRequired) {
          validators.add(RequiredValidator());
        }
        if (cell.type.isNumeric) {
          validators.add(NumperValidator());
        }
        if (cell.type == CellDataType.email) {
          validators.add(EmailValidator());
        }

        // تحديد أدوات تصفية النصوص (InputFormatters) لمنع الحروف في الحقول الرقمية
        List<TextInputFormatter>? formatters;
        if (cell.type == CellDataType.integer || (cell.type.isNumeric && cell is Cell<int>)) {
          formatters = [FilteringTextInputFormatter.digitsOnly];
        } else if (cell.type == CellDataType.decimal ||
            cell.type == CellDataType.measuredValue) {
          formatters = [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ];
        } else if (cell.type == CellDataType.phone) {
          formatters = [
            FilteringTextInputFormatter.allow(RegExp(r'^[0-9+\s-]*')),
          ];
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: TextFomrFildValidtion(
            controller: field.controller,
            form: form,
            keyData: cell.name,
            labalText: caption,
            baseValidation: validators,
            inputFormatters: formatters,
            isPssword: cell.type == CellDataType.password,
            mulitLine: cell.type == CellDataType.multilineText ? 4 : 1,
            textInputType: cell.type.keyboardType,
            onChange: (v) {
              final trimmed = v.trim();
              dynamic parsedVal;

              if (trimmed.isEmpty) {
                parsedVal = null;
              } else if (cell.type == CellDataType.integer || cell is Cell<int>) {
                parsedVal = int.tryParse(trimmed) ?? (double.tryParse(trimmed)?.toInt());
              } else if (cell.type == CellDataType.decimal || cell is Cell<double>) {
                parsedVal = double.tryParse(trimmed);
              } else if (cell.type == CellDataType.measuredValue) {
                if (cell is Cell<int>) {
                  parsedVal = int.tryParse(trimmed) ?? (double.tryParse(trimmed)?.toInt());
                } else if (cell is Cell<double>) {
                  parsedVal = double.tryParse(trimmed);
                } else {
                  parsedVal = num.tryParse(trimmed) ?? trimmed;
                }
              } else {
                parsedVal = v;
              }

              try {
                cell.value = parsedVal;
              } catch (_) {
                if (parsedVal is double && cell is Cell<int>) {
                  cell.value = parsedVal.toInt();
                } else if (parsedVal is int && cell is Cell<double>) {
                  cell.value = parsedVal.toDouble();
                } else {
                  cell.value = parsedVal;
                }
              }

              if (onChanged != null) onChanged(parsedVal);
            },
            decoration: InputDecoration(
              labelText: cell.isRequired ? '$caption *' : caption,
              hintText: cell.hint,
              prefixIcon: Icon(cell.type.icon, size: 20),
              suffixText: cell.unit,
              suffixStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),
        );

      // 2. القوائم المنسدلة (Dropdown Validation)
      case CellDataType.dropdown:
        final validators = <BaseValidator>[];
        if (cell.isRequired) {
          validators.add(RequiredValidator());
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: DrobDaownValidation(
            form: form,
            keyData: cell.name,
            labalText: caption,
            itemslsit: cell.options ?? [],
            baseValidation: validators,
            decoration: InputDecoration(
              labelText: cell.isRequired ? '$caption *' : caption,
              prefixIcon: Icon(cell.type.icon, size: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
            textStyle: TextStyle(),
          ),
        );

      // 3. المنطق (Boolean / Switch)
      case CellDataType.boolean:
        return _DynamicBooleanSwitchField(
          cell: cell,
          onChanged: onChanged,
        );

      // 4. التواريخ والأوقات (Date Picker)
      case CellDataType.date:
      case CellDataType.dateTime:
      case CellDataType.time:
        return _DynamicDatePickerField(
          cell: cell,
          field: field,
          form: form,
          onChanged: onChanged,
        );

      // 5. الإدخال المتعدد (Repeater)
      case CellDataType.repeater:
        if (cell is RepeaterCell) {
          return _DynamicRepeaterFieldWidget(
            repeaterCell: cell,
            form: form,
            onChanged: onChanged,
          );
        }
        return const SizedBox.shrink();

      default:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: TextFomrFildValidtion(
            controller: field.controller,
            form: form,
            keyData: cell.name,
            labalText: caption,
            baseValidation: cell.isRequired ? [RequiredValidator()] : [],
            decoration: InputDecoration(
              labelText: caption,
              prefixIcon: Icon(cell.type.icon, size: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
    }
  }

  // ===========================================================================
  // بناء عناصر العرض للقراءة فقط (Output Field Renderer)
  // ===========================================================================
  static Widget _buildOutputField(Cell cell, Field field) {
    final caption = cell.caption ?? cell.name;
    final val = cell.value;

    if (val == null || (val is String && val.trim().isEmpty)) {
      return const Text(
        '—',
        style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
      );
    }

    if (cell.type == CellDataType.boolean) {
      final isTrue = val == true || val == 'true';
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isTrue ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: isTrue ? Colors.green : Colors.red,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            isTrue ? 'نعم' : 'لا',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isTrue ? Colors.green.shade700 : Colors.red.shade700,
            ),
          ),
        ],
      );
    }

    if (cell.type == CellDataType.repeater && cell is RepeaterCell) {
      final rows = cell.rows;
      if (rows.isEmpty) {
        return const Text('لا توجد عناصر مضافة',
            style: TextStyle(color: Colors.grey, fontSize: 12));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows.asMap().entries.map((entry) {
          final idx = entry.key;
          final r = entry.value;
          return Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '#${idx + 1}: ' +
                  cell.subCellsSchema
                      .map((sc) =>
                          '${sc.caption ?? sc.name}: ${r[sc.name] ?? "—"}')
                      .join(' | '),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          );
        }).toList(),
      );
    }

    final displayText = cell.unit != null ? '$val ${cell.unit}' : '$val';
    return Text(
      displayText,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    );
  }
}

// =============================================================================
// Helper Widgets for Dynamic Fields (Boolean, Date, Repeater)
// =============================================================================

/// ويدجت إدخال القيم المنطقية (Boolean Switch)
class _DynamicBooleanSwitchField extends StatefulWidget {
  final Cell cell;
  final Function(dynamic)? onChanged;
  const _DynamicBooleanSwitchField({required this.cell, this.onChanged});

  @override
  State<_DynamicBooleanSwitchField> createState() =>
      _DynamicBooleanSwitchFieldState();
}

class _DynamicBooleanSwitchFieldState
    extends State<_DynamicBooleanSwitchField> {
  late bool _val;

  @override
  void initState() {
    super.initState();
    _val = widget.cell.value == true;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final caption = widget.cell.caption ?? widget.cell.name;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.grey.shade300,
        ),
      ),
      child: SwitchListTile(
        title: Text(
          caption,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: widget.cell.hint != null
            ? Text(widget.cell.hint!, style: const TextStyle(fontSize: 12))
            : null,
        secondary: Icon(widget.cell.type.icon, color: Colors.teal),
        value: _val,
        activeColor: Colors.teal,
        onChanged: (newVal) {
          setState(() => _val = newVal);
          widget.cell.value = newVal;
          if (widget.onChanged != null) widget.onChanged!(newVal);
        },
      ),
    );
  }
}

/// ويدجت إدخال التاريخ
class _DynamicDatePickerField extends StatefulWidget {
  final Cell cell;
  final Field field;
  final ValidationsForm form;
  final Function(dynamic)? onChanged;

  const _DynamicDatePickerField({
    required this.cell,
    required this.field,
    required this.form,
    this.onChanged,
  });

  @override
  State<_DynamicDatePickerField> createState() =>
      _DynamicDatePickerFieldState();
}

class _DynamicDatePickerFieldState extends State<_DynamicDatePickerField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.cell.value is DateTime) {
      _selectedDate = widget.cell.value as DateTime;
      widget.field.controller.text =
          DateFormat('yyyy-MM-dd').format(_selectedDate!);
    } else if (widget.cell.value is String && widget.cell.value.isNotEmpty) {
      _selectedDate = DateTime.tryParse(widget.cell.value);
      if (_selectedDate != null) {
        widget.field.controller.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate!);
      }
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        final formatted = DateFormat('yyyy-MM-dd').format(picked);
        widget.field.controller.text = formatted;
        widget.cell.value = formatted;
      });
      if (widget.onChanged != null) widget.onChanged!(widget.cell.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final caption = widget.cell.caption ?? widget.cell.name;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: _pickDate,
        borderRadius: BorderRadius.circular(10),
        child: IgnorePointer(
          child: TextFomrFildValidtion(
            controller: widget.field.controller,
            form: widget.form,
            keyData: widget.cell.name,
            labalText: caption,
            baseValidation: widget.cell.isRequired ? [RequiredValidator()] : [],
            decoration: InputDecoration(
              labelText: widget.cell.isRequired ? '$caption *' : caption,
              prefixIcon: const Icon(Icons.calendar_month_rounded, size: 20),
              suffixIcon: const Icon(Icons.arrow_drop_down),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ويدجت الإدخال المتعدد المتكرر (Repeater / Dynamic Rows Widget)
class _DynamicRepeaterFieldWidget extends StatefulWidget {
  final RepeaterCell repeaterCell;
  final ValidationsForm form;
  final Function(dynamic)? onChanged;

  const _DynamicRepeaterFieldWidget({
    required this.repeaterCell,
    required this.form,
    this.onChanged,
  });

  @override
  State<_DynamicRepeaterFieldWidget> createState() =>
      _DynamicRepeaterFieldWidgetState();
}

class _DynamicRepeaterFieldWidgetState
    extends State<_DynamicRepeaterFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final caption = widget.repeaterCell.caption ?? widget.repeaterCell.name;
    final rows = widget.repeaterCell.rows;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            isDark ? Colors.white.withOpacity(0.03) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white12 : const Color(0xFFCBD5E1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // رأس الـ Repeater مع زر الإضافة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.playlist_add_rounded,
                        color: Colors.teal, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    caption,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${rows.length}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    widget.repeaterCell.addRow();
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(widget.repeaterCell.rows);
                  }
                },
                icon: const Icon(Icons.add_rounded, size: 18),
                label: Text(
                  widget.repeaterCell.addItemLabel ?? 'إضافة عنصر',
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // قائمة الصفوف المضافة
          if (rows.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'لم تتم إضافة أي عناصر بعد. اضغط على الزر أعلاه للبدء.',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rows.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 10),
              itemBuilder: (ctx, rowIndex) {
                final rowData = rows[rowIndex];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        isDark ? Colors.white.withOpacity(0.05) : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDark ? Colors.white10 : Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'عنصر #${rowIndex + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.teal,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded,
                                color: Colors.redAccent, size: 20),
                            tooltip: 'حذف هذا السطر',
                            onPressed: () {
                              setState(() {
                                widget.repeaterCell.removeRow(rowIndex);
                              });
                              if (widget.onChanged != null) {
                                widget.onChanged!(widget.repeaterCell.rows);
                              }
                            },
                          ),
                        ],
                      ),
                      const Divider(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children:
                            widget.repeaterCell.subCellsSchema.map((subCell) {
                          return SizedBox(
                            width: 220,
                            child: TextFormField(
                              initialValue:
                                  rowData[subCell.name]?.toString() ?? '',
                              decoration: InputDecoration(
                                labelText: subCell.caption ?? subCell.name,
                                suffixText: subCell.unit,
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                              ),
                              keyboardType: subCell.type.keyboardType,
                              onChanged: (val) {
                                rowData[subCell.name] = val;
                                widget.repeaterCell
                                    .updateRow(rowIndex, rowData);
                                if (widget.onChanged != null) {
                                  widget.onChanged!(widget.repeaterCell.rows);
                                }
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
