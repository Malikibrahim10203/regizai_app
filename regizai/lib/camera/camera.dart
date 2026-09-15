import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:regizai/event/event_pref.dart';
import 'package:regizai/mock/mock_data.dart';
import 'package:regizai/mock/offline_service.dart';
import 'package:regizai/model/response_api.dart';
import 'package:regizai/pages/preview.dart';
import 'package:regizai/theme/app_theme.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> with SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  late AnimationController _animController;
  late Animation<double> _scanAnimation;

  String _userId = "usr_01";
  bool _isFlashOn = false;
  bool _isCameraReady = false;
  bool _isScanning = false;
  String _selectedFoodSample = "Bakso";

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _initUser();
    _initCamera();
  }

  void _initAnimation() {
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanAnimation = Tween<double>(begin: 0.1, end: 0.9).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  void _initUser() async {
    final user = await OfflineService.getCurrentUser();
    if (mounted) {
      setState(() {
        _userId = user.id ?? "usr_01";
      });
    }
  }

  void _initCamera() async {
    if (widget.cameras != null && widget.cameras!.isNotEmpty) {
      try {
        _cameraController = CameraController(
          widget.cameras![0],
          ResolutionPreset.high,
          enableAudio: false,
        );
        await _cameraController!.initialize();
        if (mounted) {
          setState(() {
            _isCameraReady = true;
          });
        }
      } catch (e) {
        debugPrint("Camera initialize error: $e");
      }
    }
  }

  void _processScan([String? foodName]) async {
    if (_isScanning) return;
    setState(() => _isScanning = true);

    final targetName = foodName ?? _selectedFoodSample;

    // Simulate AI inference delay (e.g. 1.2 seconds)
    await Future.delayed(const Duration(milliseconds: 1200));

    XFile dummyFile = XFile("assets/img/${targetName.toLowerCase()}.png");
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        dummyFile = await _cameraController!.takePicture();
      } catch (_) {}
    }

    final apiResponse = OfflineService.simulateAiScan(targetName);

    if (mounted) {
      setState(() => _isScanning = false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(
            picture: dummyFile,
            apiResponse: apiResponse,
            id: _userId,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Camera Viewfinder or Simulated Canvas
          Positioned.fill(
            child: (_cameraController != null && _isCameraReady)
                ? CameraPreview(_cameraController!)
                : _buildSimulatedCameraView(),
          ),

          // 2. Scanning Overlay with Animated Radar Line
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _scanAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: _ScanOverlayPainter(scanPosition: _scanAnimation.value),
                );
              },
            ),
          ),

          // 3. Top Action Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.auto_awesome_rounded, color: Color(0xFF34D399), size: 16),
                        SizedBox(width: 6),
                        Text(
                          "AI Scanner Aktif",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                        color: _isFlashOn ? Colors.amber : Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() => _isFlashOn = !_isFlashOn);
                        if (_cameraController != null && _isCameraReady) {
                          _cameraController!.setFlashMode(
                            _isFlashOn ? FlashMode.torch : FlashMode.off,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Sample Food Selector Sheet (Great for Testing / Offline Demo)
          Positioned(
            left: 20,
            right: 20,
            bottom: 110,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.65),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.fastfood_rounded, color: AppColors.accentMint, size: 16),
                      SizedBox(width: 6),
                      Text(
                        "Pilih Sampel Makanan Untuk Dideteksi:",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: MockData.foods.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final food = MockData.foods[index];
                        final isSelected = _selectedFoodSample == food.name;
                        return InkWell(
                          onTap: () {
                            setState(() => _selectedFoodSample = food.name);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : Colors.white12,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? Colors.white : Colors.transparent,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                food.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 5. Bottom Capture Shutter Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Center(
              child: GestureDetector(
                onTap: _isScanning ? null : () => _processScan(),
                child: Container(
                  width: 76,
                  height: 76,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                    ),
                    child: _isScanning
                        ? const Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimulatedCameraView() {
    return Container(
      color: const Color(0xFF1E1E2D),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white10,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/img/${_selectedFoodSample.toLowerCase()}.png",
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.fastfood_rounded,
                    size: 60,
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Mengarahkan Kamera ke: $_selectedFoodSample",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 4),
            const Text(
              "Ketuk tombol shutter di bawah untuk memindai gizi",
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanOverlayPainter extends CustomPainter {
  final double scanPosition;

  _ScanOverlayPainter({required this.scanPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final scanRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2 - 30),
      width: size.width * 0.75,
      height: size.width * 0.75,
    );

    // Darkened border outside the frame
    final backgroundPaint = Paint()..color = Colors.black.withOpacity(0.4);
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()..addRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(24))),
      ),
      backgroundPaint,
    );

    // Corner Brackets Paint
    final cornerPaint = Paint()
      ..color = const Color(0xFF34D399)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const cornerLength = 28.0;

    // Top-Left
    canvas.drawLine(scanRect.topLeft, scanRect.topLeft + const Offset(cornerLength, 0), cornerPaint);
    canvas.drawLine(scanRect.topLeft, scanRect.topLeft + const Offset(0, cornerLength), cornerPaint);

    // Top-Right
    canvas.drawLine(scanRect.topRight, scanRect.topRight + const Offset(-cornerLength, 0), cornerPaint);
    canvas.drawLine(scanRect.topRight, scanRect.topRight + const Offset(0, cornerLength), cornerPaint);

    // Bottom-Left
    canvas.drawLine(scanRect.bottomLeft, scanRect.bottomLeft + const Offset(cornerLength, 0), cornerPaint);
    canvas.drawLine(scanRect.bottomLeft, scanRect.bottomLeft + const Offset(0, -cornerLength), cornerPaint);

    // Bottom-Right
    canvas.drawLine(scanRect.bottomRight, scanRect.bottomRight + const Offset(-cornerLength, 0), cornerPaint);
    canvas.drawLine(scanRect.bottomRight, scanRect.bottomRight + const Offset(0, -cornerLength), cornerPaint);

    // Animated Scanning Line
    final lineY = scanRect.top + (scanRect.height * scanPosition);
    final linePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          const Color(0xFF34D399).withOpacity(0.8),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(scanRect.left, lineY - 2, scanRect.width, 4))
      ..strokeWidth = 3.0;

    canvas.drawLine(
      Offset(scanRect.left + 8, lineY),
      Offset(scanRect.right - 8, lineY),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScanOverlayPainter oldDelegate) =>
      oldDelegate.scanPosition != scanPosition;
}
