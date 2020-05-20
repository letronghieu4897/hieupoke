import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uichallenge/business_logic/utils/check_data_util.dart';
import 'package:uichallenge/business_logic/utils/column_builder_util.dart';
import 'package:uichallenge/business_logic/utils/row_builder_util.dart';
import 'package:uichallenge/business_logic/view_models/load_pokemon_detail_viewmodel.dart';
import 'package:uichallenge/services/locator/locator.dart';
import '../../business_logic/utils/extension_util.dart';

class PokemonDetailScreen extends StatefulWidget {
  final String path;
  final Color color;
  final Color textColor;
  final String image;

  const PokemonDetailScreen(
      {Key key, this.path, this.color, this.textColor, this.image})
      : super(key: key);

  @override
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  LoadPokemonDetailViewModel model =
      serviceLocator<LoadPokemonDetailViewModel>();

  @override
  void initState() {
    model.loadData(widget.path);
    super.initState();
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: widget.color,
      floating: true,
    );
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            model?.pokemon?.name?.capitalize() ?? '...',
            style: TextStyle(
              color: widget.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
          Text(
            '#${model?.pokemon?.id?.round()}',
            style: TextStyle(
              color: widget.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topCenter,
        child: Image.network(
          widget.image,
          width: MediaQuery.of(context).size.width / 2,
        ),
      ),
    );
  }

  Widget _buildTypes() {
    if (!checkListAvailable(model?.pokemon?.types)) {
      return SizedBox.shrink();
    }
    return RowBuilder(
      itemBuilder: (context, index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              child: Text(
                model?.pokemon?.types[index]?.type?.name?.capitalize(),
                style: TextStyle(
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        );
      },
      itemCount: model?.pokemon?.types?.length,
    );
  }

  Widget _buildInfor() {
    Widget _content(String title, String content) {
      return Expanded(
        child: Column(
          children: <Widget>[
            Text(
              title ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: widget.color,
              ),
            ),
            Text(
              content ?? '',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      children: <Widget>[
        _content(model?.pokemon?.species?.name?.capitalize(), 'Species'),
        Container(
          width: 2,
          height: 30,
          color: widget.color,
        ),
        _content(model?.pokemon?.height.toString(), 'Height'),
        Container(
          width: 2,
          height: 30,
          color: widget.color,
        ),
        _content('${model?.pokemon?.weight} Ibs', 'Weight'),
      ],
    );
  }

  Widget _buildEvolution() {
    return Column(
      children: [
        Text(
          'Evolution',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: widget.color,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            Image.asset(
              'assets/images/gastly.png',
              width: MediaQuery.of(context).size.width / 6,
            ),
            Expanded(
              child: Text(
                'Level \n 25',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: widget.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              'assets/images/haunter.png',
              width: MediaQuery.of(context).size.width / 6,
            ),
            Expanded(
              child: Text(
                'Trade',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: widget.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              'assets/images/gengar.png',
              width: MediaQuery.of(context).size.width / 6,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStats(LoadPokemonDetailViewModel viewModel) {
    Widget _content(String title, int value) {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              title ?? '',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: widget.color,
              ),
            ),
          ),
          SizedBox(width: 4.0),
          Expanded(
            flex: 1,
            child: Text(
              value?.toString() ?? '',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: widget.color,
              ),
            ),
          ),
          SizedBox(width: 4.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 8.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: value >= 100
                      ? 0.1
                      : MediaQuery.of(context).size.width *
                          0.5 *
                          ((100 - value) / 100),
                )
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Base Stats',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: widget.color,
          ),
        ),
        SizedBox(height: 16.0),
        if (viewModel.pokemon?.stats != null && viewModel.pokemon?.stats != [])
          ColumnBuilder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _content(
                    viewModel.pokemon?.stats[index]?.stat?.name?.capitalize(),
                    viewModel.pokemon?.stats[index]?.baseStat),
              );
            },
            itemCount: viewModel.pokemon?.stats?.length,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      child: ChangeNotifierProvider<LoadPokemonDetailViewModel>(
        create: (context) => model,
        child: Consumer<LoadPokemonDetailViewModel>(
            builder: (context, model, child) {
          return SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                _buildAppBar(),
                SliverToBoxAdapter(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        _buildName(),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(16.0),
                                        topLeft: Radius.circular(16.0),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(top: 150),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(height: 50),
                                          _buildTypes(),
                                          SizedBox(height: 16.0),
                                          _buildInfor(),
                                          SizedBox(height: 32.0),
                                          _buildEvolution(),
                                          SizedBox(height: 32.0),
                                          _buildStats(model),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _buildImage(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
