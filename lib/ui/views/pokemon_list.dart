import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uichallenge/business_logic/utils/color_util.dart';
import 'package:uichallenge/business_logic/utils/lazy_load_refresh_indicator.dart';
import 'package:uichallenge/business_logic/utils/scale_text.dart';
import 'package:uichallenge/business_logic/view_models/fetch_pokemon_list_viewmodel.dart';
import 'package:uichallenge/services/locator/locator.dart';
import 'package:uichallenge/services/pokemon/pokemon_service.dart';
import 'package:uichallenge/ui/views/pokemon_detail.dart';
import '../../business_logic/utils/extension_util.dart';

enum ListType { grid, list }

class PokemonListScreen extends StatefulWidget {
  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  FetchPokemonListViewModel model = serviceLocator<FetchPokemonListViewModel>();

  PokemonService pokemonService = serviceLocator<PokemonService>();

  bool _isLoading = false;
  int numberInLine = 2;
  double _fontSize = 12;
  double heightLine = 50;
  ListType listType = ListType.grid;
  double paddingGrid = 16.0;

  void _changeListType() {
    if (listType == ListType.grid) {
      setState(() {
        listType = ListType.list;
      });
    } else {
      setState(() {
        listType = ListType.grid;
      });
    }
  }

  void setOneImage() {
    setState(() {
      numberInLine = 1;
      _fontSize = 18;
      heightLine = 200;
      paddingGrid = 16.0;
    });
    Navigator.pop(context);
  }

  void setTwoImages() {
    setState(() {
      numberInLine = 2;
      _fontSize = 10;
      heightLine = 50;
      paddingGrid = 14.0;
    });
    Navigator.pop(context);
  }

  void setThreeImages() {
    setState(() {
      numberInLine = 3;
      _fontSize = 8;
      heightLine = 40;
      paddingGrid = 12.0;
    });
    Navigator.pop(context);
  }

  void setFourImages() {
    setState(() {
      numberInLine = 4;
      _fontSize = 6;
      heightLine = 40;
      paddingGrid = 10.0;
    });
    Navigator.pop(context);
  }

  void setFiveImages() {
    setState(() {
      numberInLine = 5;
      _fontSize = 4;
      heightLine = 20;
      paddingGrid = 6.0;
    });
    Navigator.pop(context);
  }

  void setSixImages() {
    setState(() {
      numberInLine = 6;
      _fontSize = 2;
      heightLine = 10;
      paddingGrid = 4.0;
    });
    Navigator.pop(context);
  }

  void setSevenImages() {
    setState(() {
      numberInLine = 7;
      _fontSize = 1;
      heightLine = 0;
      paddingGrid = 2.0;
    });
    Navigator.pop(context);
  }

  void setEightImages() {
    setState(() {
      numberInLine = 8;
      _fontSize = 1;
      heightLine = 0;
      paddingGrid = 2.0;
    });
    Navigator.pop(context);
  }

  void setNineImages() {
    setState(() {
      numberInLine = 9;
      _fontSize = 1;
      heightLine = 0;
      paddingGrid = 2.0;
    });
    Navigator.pop(context);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Widget _buildIconButton(
          Function event,
          int numberLineButton,
        ) {
          return Container(
            decoration: BoxDecoration(
              color:
                  numberInLine == numberLineButton ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            height: 60,
            width: 60,
            child: Center(
              child: InkWell(
                onTap: () => event(),
                child: Text(
                  '$numberLineButton',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)), //this right here
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(setOneImage, 1),
                  _buildIconButton(setTwoImages, 2),
                  _buildIconButton(setThreeImages, 3),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(setFourImages, 4),
                  _buildIconButton(setFiveImages, 5),
                  _buildIconButton(setSixImages, 6),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(setSevenImages, 7),
                  _buildIconButton(setEightImages, 8),
                  _buildIconButton(setNineImages, 9),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  Color darkColor(Color color) {
    if (color == null) {
      return Colors.black;
    }
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - 5).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  void _onLoadMore() async {
    setState(() {
      _isLoading = true;
    });
    final completer = Completer<void>();
    model.loadData(completer: completer);
    await completer.future;
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });
    final completer = Completer<void>();
    model.loadData(isRefresh: true, completer: completer);
    await completer.future;
    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildErrorTile() {
    return InkWell(
      onTap: () => _onLoadMore(),
      child: Container(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.red,
            ),
            child: Icon(
              Icons.arrow_downward,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return SizedBox(
      height: 64,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildList() {
    return LazyLoadRefreshIndicator(
      isLoading: _isLoading,
      child: ChangeNotifierProvider<FetchPokemonListViewModel>(
        create: (context) => model,
        child: Consumer<FetchPokemonListViewModel>(
          builder: (context, model, child) {
            if (listType == ListType.grid) {
              return _gridBuilder(model);
            }
            return _listBuilder(model);
          },
        ),
      ),
      onEndOfPage: () => _onLoadMore(),
      onRefresh: () => _onRefresh(),
    );
  }

  Widget _gridBuilder(FetchPokemonListViewModel model) {
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: numberInLine,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == model.pokemons.length - 1) {
          if (_isLoading) {
            return _loadingWidget();
          }

          return _buildErrorTile();
        }
        return FutureBuilder<Color>(
          future: getImagePalette(
            NetworkImage(
              pokemonService.getImageFromUrl(model?.pokemons[index].url),
            ),
          ),
          builder: (context, data) => InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PokemonDetailScreen(
                  path: pokemonService.getPath(model?.pokemons[index].url),
                  color: data?.data,
                  textColor: Colors.white,
                  image: pokemonService
                      .getImageFromUrl(model?.pokemons[index].url),
                ),
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: heightLine,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: data?.data?.withOpacity(0.75),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      model?.pokemons[index].name?.capitalize(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkColor(
                          data?.data,
                        ),
                        fontSize: _fontSize,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '#${index + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkColor(
                          data?.data,
                        ),
                        fontSize: _fontSize,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(paddingGrid * 2 - paddingGrid / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: data?.data?.withOpacity(0.5),
                    border: Border.all(color: data?.data ?? Colors.grey[200]),
                  ),
                  child: FadeInImage.assetNetwork(
                    image: pokemonService
                        .getImageFromUrl(model?.pokemons[index].url),
                    placeholder: 'assets/images/placeholder.png',
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: model?.pokemons?.length,
    );
  }

  Widget _listBuilder(FetchPokemonListViewModel model) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        if (index == model.pokemons.length - 1) {
          print(_isLoading);
          if (_isLoading) {
            return _loadingWidget();
          }

          return _buildErrorTile();
        }
        return FutureBuilder<Color>(
          future: getImagePalette(
            NetworkImage(
              pokemonService.getImageFromUrl(model?.pokemons[index].url),
            ),
          ),
          builder: (context, data) {
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonDetailScreen(
                    path: pokemonService.getPath(model?.pokemons[index].url),
                    color: data?.data,
                    textColor: Colors.white,
                    image: pokemonService
                        .getImageFromUrl(model?.pokemons[index].url),
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  color: data?.data?.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: data?.data ?? Colors.grey[200]),
                ),
                child: ListTile(
                  leading: FadeInImage.assetNetwork(
                    image: pokemonService
                        .getImageFromUrl(model?.pokemons[index]?.url),
                    placeholder: 'assets/images/placeholder.png',
                  ),
                  title: Text(
                    model?.pokemons[index]?.name,
                    style: TextStyle(
                      color: darkColor(
                        data?.data,
                      ),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('#${index + 1}'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            );
          },
        );
      },
      itemCount: model?.pokemons?.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WithAdaptiveMediaQuery(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Pokemon',
            style: GoogleFonts.bungee(),
          ),
          actions: [
            if (listType == ListType.grid)
              IconButton(
                icon: Icon(Icons.apps),
                onPressed: () => _showDialog(),
              ),
            IconButton(
              icon: Icon(
                  listType == ListType.grid ? Icons.view_list : Icons.grid_on),
              onPressed: () => _changeListType(),
            ),
          ],
        ),
        body: _buildList(),
      ),
    );
  }
}
