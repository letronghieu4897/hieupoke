import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uichallenge/business_logic/utils/check_data_util.dart';
import 'package:uichallenge/business_logic/utils/column_builder_util.dart';
import 'package:uichallenge/business_logic/utils/format_util.dart';
import 'package:uichallenge/business_logic/utils/row_builder_util.dart';
import 'package:uichallenge/business_logic/utils/scale_text.dart';
import 'package:uichallenge/business_logic/view_models/load_pokemon_detail_viewmodel.dart';
import 'package:uichallenge/services/locator/locator.dart';
import 'package:uichallenge/ui/views/pokemon_evolution.dart';
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
              fontSize: 30,
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
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: widget.color,
              ),
            ),
            Text(
              content ?? '',
              style: TextStyle(
                fontSize: 8,
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
        _content(model?.pokemon?.baseExperience?.toString()?.capitalize(),
            'Base Experience'),
        Container(
          width: 2,
          height: 30,
          color: widget.color,
        ),
        _content('${formatHeightWidth(model?.pokemon?.height)} m', 'Height'),
        Container(
          width: 2,
          height: 30,
          color: widget.color,
        ),
        _content('${formatHeightWidth(model?.pokemon?.weight)} kg', 'Weight'),
      ],
    );
  }

  Widget _buildEvolution(LoadPokemonDetailViewModel viewModel) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PokemonEvolutionScreen(
            id: viewModel?.pokemon?.id?.round(),
          ),
        ),
      ),
      child: Column(
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
      ),
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
                fontSize: 7,
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
                fontSize: 9,
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
        if (checkListAvailable(viewModel.pokemon?.stats))
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

  Widget _buildAbility(LoadPokemonDetailViewModel viewModel) {
    return Column(
      children: [
        Text(
          'Abilities',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: widget.color,
          ),
        ),
        SizedBox(height: 16.0),
        if (checkListAvailable(viewModel.pokemon?.abilities))
          RowBuilder(
            itemBuilder: (context, index) {
              var abilityRes = viewModel?.pokemon?.abilities[index];
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Container(
                    child: Text(
                      abilityRes?.ability?.name?.capitalize(),
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
          ),
      ],
    );
  }

  Widget _buildSprites(LoadPokemonDetailViewModel viewModel) {
    Widget _buildImage(String image) {
      if (image == null) {
        return SizedBox.shrink();
      }
      return Container(
        padding: EdgeInsets.all(8.0),
        width: 60,
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: widget.color),
        ),
        child: FadeInImage.assetNetwork(
            width: 50,
            placeholder: 'assets/images/placeholder.png',
            image: image),
      );
    }

    return Container(
      child: Column(
        children: [
          Text(
            'Sprites',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: widget.color,
            ),
          ),
          SizedBox(height: 16.0),
          Wrap(
            children: [
              _buildImage(viewModel?.pokemon?.sprites?.frontDefault),
              SizedBox(width: 8.0),
              _buildImage(viewModel?.pokemon?.sprites?.backDefault),
              SizedBox(width: 8.0),
              _buildImage(viewModel?.pokemon?.sprites?.frontShiny),
              SizedBox(width: 8.0),
              _buildImage(viewModel?.pokemon?.sprites?.backShiny),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WithAdaptiveMediaQuery(
      child: Material(
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
//                                          SizedBox(height: 32.0),
//                                          _buildEvolution(model),
                                            SizedBox(height: 32.0),
                                            _buildStats(model),
                                            SizedBox(height: 32.0),
                                            _buildAbility(model),
                                            SizedBox(height: 32.0),
                                            _buildSprites(model),
                                            SizedBox(height: 500.0),
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
      ),
    );
  }
}
