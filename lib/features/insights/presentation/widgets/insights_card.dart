<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
>>>>>>> Stashed changes
// features/insights/presentation/widgets/insights_card.dart

import 'package:flutter/material.dart';

<<<<<<< Updated upstream
class InsightsCard extends StatelessWidget {
=======
class InsightsCard extends StatefulWidget {
>>>>>>> Stashed changes
  final String title;
  final String content;
  final IconData icon;
  final Color color;

  const InsightsCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    this.color = Colors.blue,
  });

  @override
<<<<<<< Updated upstream
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
=======
  State<InsightsCard> createState() => _InsightsCardState();
}

class _InsightsCardState extends State<InsightsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for entrance animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Scale animation for entrance
    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Fade animation for entrance
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    // Slide animation for entrance (from bottom)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start entrance animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: _buildCardContent(),
>>>>>>> Stashed changes
        ),
      ),
    );
  }
<<<<<<< Updated upstream
}
=======

  /// Build the main card content with interactive feedback
  Widget _buildCardContent() {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 16.0),

        // Transform scale on tap for feedback
        transform: Matrix4.identity()
          ..scale(_isPressed ? 0.98 : 1.0),

        decoration: BoxDecoration(
          // Gradient background based on color parameter
          gradient: LinearGradient(
            colors: [
              Colors.white,
              widget.color.withOpacity(0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          borderRadius: BorderRadius.circular(20),

          // Border with accent color
          border: Border.all(
            color: widget.color.withOpacity(0.15),
            width: 1.5,
          ),

          // Elevated shadow that changes on press
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(_isPressed ? 0.1 : 0.15),
              blurRadius: _isPressed ? 8 : 16,
              offset: Offset(0, _isPressed ? 2 : 6),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(_isPressed ? 0.03 : 0.06),
              blurRadius: _isPressed ? 4 : 12,
              offset: Offset(0, _isPressed ? 1 : 4),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Optional: Add tap handler for card interaction
                // Can be used to navigate or show details
              },
              borderRadius: BorderRadius.circular(20),
              splashColor: widget.color.withOpacity(0.1),
              highlightColor: widget.color.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== Header Row: Icon + Title =====
                    Row(
                      children: [
                        _buildIconContainer(),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTitle(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ===== Content Text =====
                    _buildContent(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build icon container with gradient background and glow effect
  Widget _buildIconContainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // Gradient background for icon
        gradient: LinearGradient(
          colors: [
            widget.color.withOpacity(0.9),
            widget.color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius: BorderRadius.circular(14),

        // Glow effect shadow
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: widget.color.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        widget.icon,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  /// Build title with gradient text effect
  Widget _buildTitle() {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          widget.color,
          widget.color.withOpacity(0.7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Required for ShaderMask
          letterSpacing: 0.3,
          height: 1.2,
        ),
      ),
    );
  }

  /// Build content text with optimized readability
  Widget _buildContent() {
    return Text(
      widget.content,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[700],
        height: 1.7,
        letterSpacing: 0.2,
      ),
    );
  }
}
>>>>>>> Stashed changes
>>>>>>> Stashed changes
