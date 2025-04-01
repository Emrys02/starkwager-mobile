import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starkwager/core/constants/assets.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/features/feature.dart';
import 'package:starkwager/theme/app_theme.dart';

void showProofUploadWidget(BuildContext context) {
  if (context.isMobile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ProofUploadBottomSheet(),
    );
  } else {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        elevation: 0,
        child: ProofUploadDialog(),
      ),
    );
  }
}

class ProofUploadBottomSheet extends StatefulWidget {
  const ProofUploadBottomSheet({super.key});

  @override
  State<ProofUploadBottomSheet> createState() => _ProofUploadBottomSheetState();
}

class _ProofUploadBottomSheetState extends State<ProofUploadBottomSheet> {
  final TextEditingController _noteController = TextEditingController();
  int _characterCount = 0;
  final int _maxCharacters = 500;

  @override
  void initState() {
    super.initState();
    _noteController.addListener(_updateCharacterCount);
  }

  @override
  void dispose() {
    _noteController.removeListener(_updateCharacterCount);
    _noteController.dispose();
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {
      _characterCount = _noteController.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: context.uploadDialog,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 5),
              _buildDescription(),
              SizedBox(height: 8),
              _buildDivider(),
              SizedBox(height: 20),
              _buildUploadArea(),
              SizedBox(height: 30),
              _buildNoteSection(),
              SizedBox(height: 24),
              _buildActionButtons(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(),
        Text(
          'uploadProof'.tr(),
          style: AppTheme.of(context).titleLarge20,
        ),
        Spacer(),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.close,
            size: 24,
            color: context.primaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'uploadapictureorvideo'.tr(),
        textAlign: TextAlign.center,
        style: AppTheme.of(context).bodyMedium14.copyWith(
              color: context.subTitleTextColor,
            ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: DottedLine(
        dashLength: 4,
        dashGapLength: 8,
        lineThickness: 1,
        dashColor: context.dividerColor,
      ),
    );
  }

  Widget _buildUploadArea() {
    return DottedBorder(
      dashPattern: [6, 8],
      strokeWidth: 2,
      color: context.dividerColor,
      borderType: BorderType.RRect,
      radius: Radius.circular(16),
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.uploadDialog,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image and video icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: -0.3,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: context.rotateColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppIcons.upload1,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                            context.buttonTextColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: 0.3,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: context.rotateColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppIcons.upload2,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                            context.buttonTextColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'SelectGallery'.tr(),
              style: AppTheme.of(context).titleLarge20,
            ),
            SizedBox(height: 8),
            Text(
              'selectYourProof'.tr(),
              style: AppTheme.of(context).bodyMedium14.copyWith(
                    color: context.subTitleTextColor,
                  ),
            ),
            SizedBox(height: 24),
            PrimaryButton(
                buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                      color: context.buttonTextColor,
                    ),
                height: 56,
                width: 84,
                buttonText: 'select'.tr(),
                buttonColor: context.snapProofColor,
                onPressed: () {},
                isActive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "addNote".tr(),
          style: AppTheme.of(context).bodyMedium14.copyWith(
              fontWeight: FontWeight.w500, color: context.primaryTextColor),
        ),
        SizedBox(height: 12),
        Container(
          height: 72,
          decoration: BoxDecoration(
            color: context.textField,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _noteController,
            maxLines: 1,
            maxLength: _maxCharacters,
            style: AppTheme.of(context).bodyMedium14,
            decoration: InputDecoration(
              hintText: 'wagerstrk'.tr(),
              hintStyle: AppTheme.of(context).bodyExtraLarge18.copyWith(
                    color: context.textHintColor,
                  ),
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.symmetric(vertical: 30),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, right: 8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$_characterCount/$_maxCharacters',
              style: AppTheme.of(context).textSmallMedium.copyWith(
                    color: context.textHintColor,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryButton(
            buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                  color: context.buttonTextColor,
                ),
            height: 56,
            width: 121,
            buttonText: 'snapProof'.tr(),
            buttonColor: context.snapProofColor,
            onPressed: () {},
            isActive: true),
        SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 56,
            width: 182,
            child: PrimaryButton(
              buttonText: 'Upload'.tr(),
              buttonColor: context.primaryButtonColor,
              onPressed: () {},
              isActive: true,
              height: 56,
            ),
          ),
        )
      ],
    );
  }
}

class ProofUploadDialog extends StatefulWidget {
  const ProofUploadDialog({super.key});

  @override
  State<ProofUploadDialog> createState() => _ProofUploadDialogState();
}

class _ProofUploadDialogState extends State<ProofUploadDialog> {
  final TextEditingController _noteController = TextEditingController();
  int _characterCount = 0;
  final int _maxCharacters = 500;

  @override
  void initState() {
    super.initState();
    _noteController.addListener(_updateCharacterCount);
  }

  @override
  void dispose() {
    _noteController.removeListener(_updateCharacterCount);
    _noteController.dispose();
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {
      _characterCount = _noteController.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: 691,
        maxWidth: 400,
      ),
      decoration: BoxDecoration(
        color: context.uploadDialog,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  Text(
                    'uploadProof'.tr(),
                    style: AppTheme.of(context).titleLarge20,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: context.primaryTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'uploadapictureorvideo'.tr(),
                  textAlign: TextAlign.center,
                  style: AppTheme.of(context).bodyMedium14.copyWith(
                        color: context.subTitleTextColor,
                      ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: DottedLine(
                  dashLength: 4,
                  dashGapLength: 8,
                  lineThickness: 1,
                  dashColor: context.dividerColor,
                ),
              ),
              SizedBox(height: 20),
              DottedBorder(
                dashPattern: [6, 8],
                strokeWidth: 2,
                color: context.dividerColor,
                borderType: BorderType.RRect,
                radius: Radius.circular(16),
                padding: EdgeInsets.zero,
                child: Container(
                  width: 352,
                  decoration: BoxDecoration(
                    color: context.uploadDialog,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image and video icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: -0.3,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: context.rotateColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppIcons.upload1,
                                  width: 24,
                                  height: 24,
                                  colorFilter: ColorFilter.mode(
                                      context.buttonTextColor, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ),
                          Transform.rotate(
                            angle: 0.3,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: context.rotateColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppIcons.upload2,
                                  width: 24,
                                  height: 24,
                                  colorFilter: ColorFilter.mode(
                                      context.buttonTextColor, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'SelectGallery'.tr(),
                        style: AppTheme.of(context).titleLarge20,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'selectYourProof'.tr(),
                        style: AppTheme.of(context).bodyMedium14.copyWith(
                              color: context.subTitleTextColor,
                            ),
                      ),
                      SizedBox(height: 24),
                      PrimaryButton(
                          buttonTextStyle:
                              AppTheme.of(context).textMediumMedium.copyWith(
                                    color: context.buttonTextColor,
                                  ),
                          height: 56,
                          width: 84,
                          buttonText: 'select'.tr(),
                          buttonColor: context.snapProofColor,
                          onPressed: () {},
                          isActive: true),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "addNote".tr(),
                  style: AppTheme.of(context).bodyMedium14.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.primaryTextColor),
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 72,
                decoration: BoxDecoration(
                  color: context.textField,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _noteController,
                  maxLines: 1,
                  maxLength: _maxCharacters,
                  style: AppTheme.of(context).bodyMedium14,
                  decoration: InputDecoration(
                    hintText: 'wagerstrk'.tr(),
                    hintStyle: AppTheme.of(context).bodyExtraLarge18.copyWith(
                          color: context.textHintColor,
                        ),
                    border: InputBorder.none,
                    counterText: '',
                    contentPadding: EdgeInsets.symmetric(vertical: 30),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$_characterCount/$_maxCharacters',
                    style: AppTheme.of(context).textSmallMedium.copyWith(
                          color: context.textHintColor,
                        ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryButton(
                      buttonTextStyle:
                          AppTheme.of(context).textMediumMedium.copyWith(
                                color: context.buttonTextColor,
                              ),
                      height: 56,
                      width: 121,
                      buttonText: 'snapProof'.tr(),
                      buttonColor: context.snapProofColor,
                      onPressed: () {},
                      isActive: true),
                  SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      width: 182,
                      child: PrimaryButton(
                        buttonText: 'Upload'.tr(),
                        buttonColor: context.primaryButtonColor,
                        onPressed: () {},
                        isActive: true,
                        height: 56,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
