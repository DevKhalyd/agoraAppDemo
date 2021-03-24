import 'package:flutter/material.dart';

///Default to vertical
class Space extends StatelessWidget {
  const Space(this.space, {this.isHorizontal = false});

  final double space;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) => isHorizontal
      ? SizedBox(
          width: _getSpace(context) * space,
        )
      : SizedBox(
          height: _getSpace(context) * space,
        );

  double _getSpace(BuildContext context) => isHorizontal
      ? MediaQuery.of(context).size.width
      : MediaQuery.of(context).size.height;
}

class FutureBuildCustom<T> extends StatelessWidget {
  final Future<T> future;
  final Widget onNoData;
  final Widget onLoading;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot)
      onResponse;

  const FutureBuildCustom({
    @required this.future,
    this.onResponse,
    this.onNoData,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.hasData) {
            if (onResponse == null) return CenterText('Data');

            return onResponse(context, snapshot);
          }

          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return onNoData ??
                IconDescription(Icons.block, 'No hay datos para mostrar');
          } else {
            return onLoading ?? CircularProgressCustom();
          }
        },
      );
}

class IconDescription extends StatelessWidget {
  final IconData icon;
  final String msg;

  const IconDescription(this.icon, this.msg);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: MediaQuery.of(context).size.width * 0.225,
            color: Colors.grey,
          ),
          Space(0.01),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}

class CircularProgressCustom extends StatelessWidget {
  const CircularProgressCustom({this.color = Colors.orange});
  final Color color;

  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(color),
        ),
      );
}

class ListViewCustom<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, int) builder;
  final bool shrinkWrap, reverse;
  final ScrollController controller;

  const ListViewCustom(this.items,
      {this.builder,
      this.controller,
      this.shrinkWrap = false,
      this.reverse = false});

  @override
  Widget build(BuildContext context) => ListView.builder(
      controller: controller,
      reverse: reverse,
      shrinkWrap: shrinkWrap,
      itemCount: items?.length ?? 0,
      itemBuilder: builder ??
          (_, i) {
            return ListTile(
              title: Text('Item $i'),
            );
          });
}

class CenterText extends StatelessWidget {
  const CenterText(this.text, {this.textAlign = TextAlign.center});

  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) => Center(
        child: Text(
          text,
          textAlign: textAlign,
        ),
      );
}

class StreamBuilderCustom<T> extends StatelessWidget {
  final Stream<T> stream;

  ///When the `stream emits null`
  final Widget onNoData;

  ///When the `stream Connection == !Connection.Done`
  final Widget onLoading;

  ///When the `stream emits a non-null value`
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot)
      onResponse;

  const StreamBuilderCustom({
    @required this.stream,
    this.onResponse,
    this.onNoData,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<T>(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          final infoWidget = (String msg) => IconDescription(Icons.block, msg);

          if (snapshot.hasData && !snapshot.hasError) {
            if (onResponse == null) return CenterText('There is data');

            return onResponse(context, snapshot);
          }

          if (!snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done ||
              snapshot.hasError)
            return onNoData ?? infoWidget('No hay datos para mostrar');

          if (ConnectionState.waiting == snapshot.connectionState)
            return onLoading ?? CircularProgressCustom();

          return infoWidget('Ha ocurrido un error, intente de nuevo más tarde');
        },
      );
}
