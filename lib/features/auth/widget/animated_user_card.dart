import 'package:flutter/material.dart';

class AnimatedUserCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final IconData icon;
  final Color color1;
  final Color color2;
  final VoidCallback onTap;
  final int delay;

  const AnimatedUserCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.icon,
    required this.color1,
    required this.color2,
    required this.onTap,
    this.delay = 0,
  });

  @override
  State<AnimatedUserCard> createState() => _AnimatedUserCardState();
}

class _AnimatedUserCardState extends State<AnimatedUserCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fade = Tween<double>(begin: 0, end: 1).animate(_controller);

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _fade,
        child: Card(
          elevation: 6.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [widget.color1, widget.color2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(widget.icon, size: 30, color: widget.color1),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CairoPlay',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: widget.onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: widget.color1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(widget.buttonText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
