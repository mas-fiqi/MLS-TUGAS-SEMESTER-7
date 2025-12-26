import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/theme/theme.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String? startUrl; // From Navigation context, if provided
  final String? startTitle; 

  const VideoPlayerScreen({super.key, this.startUrl, this.startTitle});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  
  // Master Link (Default)
  // https://youtu.be/LcDjP3cdk0g?si=lMfzavx2OB3Fzqqt
  static const String _masterLink = "https://youtu.be/LcDjP3cdk0g";

  // Data Playlist (Colors: Blue, Green, Orange, Purple)
  final List<Map<String, dynamic>> _videos = [
    {
      "title": "Prinsip Desain Visual",
      "id": "poZtdyC24P4", // Mapped from user list
      "duration": "12:30",
      "color": Color(0xFFBBDEFB), // Blue
      "icon_color": Color(0xFF1976D2),
    },
    {
      "title": "Typography dalam UI",
      "id": "W5LPcpIRLzs",
      "duration": "08:45",
      "color": Color(0xFFC8E6C9), // Green
      "icon_color": Color(0xFF388E3C),
    },
    {
      "title": "Color Theory",
      "id": "RuNPg-HuEyY",
      "duration": "15:20",
      "color": Color(0xFFFFE0B2), // Orange
      "icon_color": Color(0xFFF57C00),
    },
     {
      "title": "Layouting Dasar",
      "id": "yCB144mK_xc",
      "duration": "10:15",
      "color": Color(0xFFE1BEE7), // Purple
      "icon_color": Color(0xFF7B1FA2),
    },
  ];

  String _currentTitle = "Pengantar User Interface Design";
  String _currentDesc = "Video ini menjelaskan konsep dasar UI Design dan bagaimana menerapkannya dalam proyek nyata.";
  String _currentId = "";

  @override
  void initState() {
    super.initState();
    
    // Logic: Use StartUrl if valid, else Master Link
    String initialUrl = widget.startUrl ?? _masterLink;
    _currentId = YoutubePlayer.convertUrlToId(initialUrl) ?? YoutubePlayer.convertUrlToId(_masterLink)!;

    // Update Text if we started with specific video from navigation, 
    // BUT user prompt asked for specific static Title "Pengantar User Interface Design" defaults?
    // I will stick to dynamic if provided, but default to user Req if not.
    if (widget.startTitle != null) {
        _currentTitle = widget.startTitle!;
        _currentDesc = "Sedang memutar: ${widget.startTitle}";
    }

    _controller = YoutubePlayerController(
      initialVideoId: _currentId,
      flags: const YoutubePlayerFlags(
        autoPlay: false, // User Requested FALSE
        mute: false,
        enableCaption: true, 
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playVideo(int index) {
    setState(() {
      _currentId = _videos[index]['id'];
      _currentTitle = _videos[index]['title'];
      _currentDesc = "Sedang memutar: ${_videos[index]['title']}. Durasi: ${_videos[index]['duration']}";
    });
    _controller.load(_videos[index]['id']);
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: kPrimaryColor,
        aspectRatio: 16/9,
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Video - User Interface Design", style: TextStyle(color: Colors.white, fontSize: 16)),
            backgroundColor: Color(0xFFBA68C8), // Purple Header like screenshot (approx)
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. The Player
              player,

              // 2. Content Below
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        _currentTitle,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _currentDesc,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        "Video Lain Nya",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 16),

                      // Playlist
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _videos.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final video = _videos[index];
                          return InkWell(
                            onTap: () => _playVideo(index),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.all(16), // Large padding
                              decoration: BoxDecoration(
                                color: video['color'], // Specific Color
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  // Play Icon in Circle
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: video['icon_color'], width: 1.5),
                                    ),
                                    child: Icon(Icons.play_circle_outline, color: video['icon_color'], size: 20),
                                  ),
                                  const SizedBox(width: 16),
                                  
                                  // Text Info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          video['title'],
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          video['duration'],
                                          style: TextStyle(color: Colors.black54, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // 3 Dots Menu
                                  const Icon(Icons.more_vert, color: Colors.black45),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
