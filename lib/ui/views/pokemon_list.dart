import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uichallenge/business_logic/utils/color_util.dart';
import 'package:uichallenge/business_logic/utils/lazy_load_refresh_indicator.dart';
import 'package:uichallenge/business_logic/view_models/fetch_pokemon_list_viewmodel.dart';
import 'package:uichallenge/services/locator/locator.dart';
import 'package:uichallenge/services/pokemon/pokemon_service.dart';
import 'package:uichallenge/ui/views/pokemon_detail.dart';
import '../../business_logic/utils/extension_util.dart';

class PokemonListScreen extends StatefulWidget {
  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  FetchPokemonListViewModel model = serviceLocator<FetchPokemonListViewModel>();

  PokemonService pokemonService = serviceLocator<PokemonService>();

  bool _isLoading = false;
  int numberInLine = 2;
  double _fontSize = 14;
  double heightLine = 50;

  void setOneImage() {
    setState(() {
      numberInLine = 1;
      _fontSize = 18;
      heightLine = 200;
    });
    Navigator.pop(context);
  }

  void setTwoImages() {
    setState(() {
      numberInLine = 2;
      _fontSize = 14;
      heightLine = 50;
    });
    Navigator.pop(context);
  }

  void setThreeImages() {
    setState(() {
      numberInLine = 3;
      _fontSize = 10;
      heightLine = 40;
    });
    Navigator.pop(context);
  }

  void setFourImages() {
    setState(() {
      numberInLine = 4;
      _fontSize = 8;
      heightLine = 40;
    });
    Navigator.pop(context);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)), //this right here
          title: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                    child: InkWell(
                      onTap: () => setOneImage(),
                      child: Icon(
                        Icons.looks_one,
                        size: 100,
                        color: numberInLine == 1 ? Colors.green : Colors.grey,
                      ),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    child: InkWell(
                      onTap: () => setTwoImages(),
                      child: Icon(
                        Icons.looks_two,
                        size: 100,
                        color: numberInLine == 2 ? Colors.green : Colors.grey,
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    child: InkWell(
                      onTap: () => setThreeImages(),
                      child: Icon(
                        Icons.looks_3,
                        size: 100,
                        color: numberInLine == 3 ? Colors.green : Colors.grey,
                      ),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    child: InkWell(
                      onTap: () => setFourImages(),
                      child: Icon(
                        Icons.looks_4,
                        size: 100,
                        color: numberInLine == 4 ? Colors.green : Colors.grey,
                      ),
                    ),
                  )),
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
          return GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numberInLine,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0),
            itemBuilder: (BuildContext context, int index) {
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
                builder: (context, data) => InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PokemonDetailScreen(
                        path:
                            pokemonService.getPath(model?.pokemons[index].url),
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
                              borderRadius: BorderRadius.circular(4.0),
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
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0 * 2 - 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: data?.data?.withOpacity(0.5),
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
        }),
      ),
      onEndOfPage: () => _onLoadMore(),
      onRefresh: () => _onRefresh(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pokemon'),
        actions: [
          IconButton(
            icon: Icon(Icons.apps),
            onPressed: () => _showDialog(),
          )
        ],
      ),
      body: _buildList(),
    );
  }
}
