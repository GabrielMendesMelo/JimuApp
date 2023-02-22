import 'package:flutter/material.dart';

/// se [iconeAberto] for nulo, [iconeFechado] também deve ser nulo e vice-versa

class JimuCard extends StatefulWidget {
  final double? height;
  final double? width;
  final String? titulo;
  final String? subtitulo;
  final Widget? iconeAberto;
  final Widget? iconeFechado;
  final bool aberto;
  final List<Widget>? children;
  const JimuCard({
    this.height,
    this.width,
    this.titulo,
    this.subtitulo,
    this.iconeAberto,
    this.iconeFechado,
    this.aberto = false,
    this.children,
    super.key,
  });

  @override
  State<JimuCard> createState() => _JimuCardState();
}

class _JimuCardState extends State<JimuCard> {
  late bool _aberto;

  @override
  void initState() {
    _aberto = widget.aberto;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _jimuCardErros();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          radius: 80,
          onTap: () {
            setState(() {
              _aberto = !_aberto;
            });
          },
          child: _child(),
        ),
      ),
    );
  }

  Widget _child() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: widget.height ?? 80,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _titulo(),
                    _subtitulo(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  if (_aberto)
                    Column(
                      children: widget.children ?? <Widget>[],
                    ),
                  if (_aberto)
                    const Icon(
                      Icons.arrow_drop_up_outlined,
                      size: 50,
                    )
                  else
                    const Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 50,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titulo() {
    if (widget.titulo != null) {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Text(
          widget.titulo!,
          style: Theme.of(context).textTheme.headlineSmall,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    return const SizedBox();
  }

  Widget _subtitulo() {
    if (widget.subtitulo != null) {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Text(
          widget.subtitulo!,
          style: Theme.of(context).textTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    return const SizedBox();
  }

  void _jimuCardErros() {
    if ((widget.iconeAberto != null && widget.iconeFechado == null) ||
        widget.iconeAberto == null && widget.iconeFechado != null) {
      throw ArgumentError(
          'se iconeAberto for nulo, iconeFechado também deve ser nulo e vice-versa');
    }
  }
}
