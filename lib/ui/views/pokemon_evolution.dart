import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uichallenge/business_logic/models/pokemon_evolution.dart';
import 'package:uichallenge/business_logic/utils/check_data_util.dart';
import 'package:uichallenge/business_logic/view_models/load_pokemon_evolution_viewmodel.dart';
import 'package:uichallenge/services/locator/locator.dart';
import 'package:uichallenge/services/pokemon/pokemon_service.dart';
import '../../business_logic/models/pokemon_detail.dart';

class PokemonEvolutionScreen extends StatefulWidget {
  final int id;

  const PokemonEvolutionScreen({Key key, this.id}) : super(key: key);

  @override
  _PokemonEvolutionScreenState createState() => _PokemonEvolutionScreenState();
}

class _PokemonEvolutionScreenState extends State<PokemonEvolutionScreen> {
  PokemonService _pokemonService = serviceLocator<PokemonService>();

  LoadPokemonEvolutionViewModel model =
      serviceLocator<LoadPokemonEvolutionViewModel>();

  @override
  void initState() {
    model.loadData(widget.id);
    super.initState();
  }

  List<EvolutionParse> parseEvolution(LoadPokemonEvolutionViewModel viewModel) {
    List<EvolutionParse> evolutions = [];
    var evo = viewModel?.pokemonEvolution?.chain;

    do {
      var evoDetails = evo?.evolutionDetails[0];

      evolutions.add(
        EvolutionParse(
          name: evo?.species?.name,
          image: _pokemonService.getImageFromUrl(evo?.species?.url),
          level: evoDetails == null ? 1 : evoDetails?.minLevel,
        ),
      );

      evo = evo?.evolvesTo[0];
    } while (evo != null && evo?.evolvesTo != []);

    if (viewModel?.pokemonEvolution?.chain?.species != null) {
      Species speciesOne = viewModel?.pokemonEvolution?.chain?.species;

      evolutions.add(
        EvolutionParse(
          name: speciesOne?.name,
          image: _pokemonService.getImageFromUrl(speciesOne?.url),
        ),
      );

      if (viewModel?.pokemonEvolution?.chain?.evolvesTo != null &&
          viewModel?.pokemonEvolution?.chain?.evolvesTo?.length != 0) {
        EvolvesTo evolOne = viewModel?.pokemonEvolution?.chain?.evolvesTo[0];

        if (evolOne?.species != null) {
          Species speciesTwo = evolOne.species;

          evolutions.add(
            EvolutionParse(
              name: speciesTwo?.name,
              image: _pokemonService.getImageFromUrl(speciesTwo?.url),
            ),
          );

          if (evolOne?.evolvesTo != null && evolOne?.evolvesTo?.length != 0) {
            EvolvesTo evolTwo = evolOne?.evolvesTo[0];
            if (evolTwo?.species != null) {
              Species speciesThree = evolTwo.species;
              evolutions.add(
                EvolutionParse(
                  name: speciesThree?.name,
                  image: _pokemonService.getImageFromUrl(speciesThree?.url),
                ),
              );
            }
          }
        }
      }
    }
    return evolutions;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      child: ChangeNotifierProvider<LoadPokemonEvolutionViewModel>(
        create: (context) => model,
        child: Consumer<LoadPokemonEvolutionViewModel>(
          builder: (context, model, child) {
            List<EvolutionParse> evolutions = parseEvolution(model);
            if (!checkListAvailable(evolutions)) {
              return SizedBox.shrink();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Image.network(
                      evolutions[index]?.image,
                      width: 100,
                    ),
                    Text(evolutions[index]?.name),
                  ],
                );
              },
              itemCount: evolutions?.length,
            );
          },
        ),
      ),
    );
  }
}

class EvolutionParse extends Equatable {
  final String name;
  final String image;
  final int level;

  EvolutionParse({this.name, this.image, this.level});

  @override
  List<Object> get props => [name, image, level];
}
