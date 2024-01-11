import 'package:flutter/material.dart';
import 'package:tasca_3/models/recepta.dart';

class PantallaMostraRecepta extends StatefulWidget {
  const PantallaMostraRecepta({super.key});

  @override
  State<PantallaMostraRecepta> createState() => _PantallaMostraReceptaState();
}

class _PantallaMostraReceptaState extends State<PantallaMostraRecepta> {
  Recepta? recepta;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    recepta = ModalRoute.of(context)!.settings.arguments as Recepta?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          recipeTopPart(context),
          recipeOverview(),
          ingredients(),
          preparation(),
        ],
      ),
    );
  }

  Padding preparation() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PREPARACIÓ",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          for (int i = 0; i < recepta!.pasAPas.length; i++)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                recepta!.pasAPas[i],
                style: const TextStyle(fontSize: 20),
              ),
            )
        ],
      ),
    );
  }

  Padding ingredients() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "INGREDIENTS",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          for (int i = 0; i < recepta!.ingredients.length; i++)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                recepta!.ingredients[i],
                style: const TextStyle(fontSize: 20),
              ),
            )
        ],
      ),
    );
  }

  Padding recipeOverview() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 16, right: 12, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: Colors.orange,
                size: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "${recepta!.tempsPreparacio} MIN",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.lunch_dining,
                color: Colors.orange,
                size: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "${recepta!.persones} Servings",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.restaurant,
                color: Colors.orange,
                size: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "${recepta!.calories} Cals",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  WillPopScope recipeTopPart(BuildContext context) {
    return WillPopScope(
      //per detectar si tires enrere
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(recepta!.imatge),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black, Colors.transparent],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                navegacioSuperior(context),
                infoRecepta(),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pop(context, recepta);
        return false;
      },
    );
  }

  Column infoRecepta() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              recepta!.nom,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  recepta!.liked = !recepta!.liked;
                });
              },
              icon: Icon(
                Icons.favorite,
                color: recepta!.liked ? Colors.red : Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        Rating(
          valoracio: recepta!.valoracio,
          setRating: (valoracio) {
            setState(() {
              recepta!.valoracio = valoracio;
            });
          },
        ),
      ],
    );
  }

  Row navegacioSuperior(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BackButton(
          color: Colors.white,
        ),
        Expanded(child: Container()),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/pantalla_edita_recepta",
                    arguments: recepta)
                .then((value) {
              if (value is Recepta) {
                setState(() {
                  recepta = value;
                });
              }
            });
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class Rating extends StatelessWidget {
  final int valoracio;
  final Function setRating;

  const Rating({
    super.key,
    required this.valoracio,
    required this.setRating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < valoracio; i++)
          GestureDetector(
            child: const Icon(
              Icons.star,
              color: Colors.orange,
              size: 30,
            ),
            onTap: () => setRating(i + 1),
          ),
        for (int i = valoracio; i < 5; i++)
          GestureDetector(
            child: const Icon(
              Icons.star,
              color: Colors.white,
              size: 30,
            ),
            onTap: () => setRating(i + 1),
          )
      ],
    );
  }
}
