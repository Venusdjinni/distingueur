import 'package:distingueur/models/persistence.dart';
import 'package:distingueur/models/persistenceDao.dart';
import 'package:distingueur/notifier.dart';
import 'package:distingueur/widgets/item_address.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class AddressesScreen extends StatefulWidget {
  static final Notifier notifier = Notifier();

  const AddressesScreen({Key? key}) : super(key: key);

  @override
  _AddressesScreenState createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  ScrollController _scrollController = ScrollController();
  final persistenceDao = PersistenceDao();

  @override
  void initState() {
    super.initState();
    print("ici");
    WidgetsBinding.instance!.addPostFrameCallback((_){
    setState(() {});
    });
    //AddressesScreen.notifier.addListener(onEvent);
  }

  void onEvent() {
    // raffraichit la liste à chaque appel
    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Distingueur"),
        actions: [
          IconButton(
            onPressed: onSearch,
            icon: Icon(Icons.search),
            tooltip: "Rechercher",
          )
        ],
      ),
      body: //_getMessageList(),
      FutureBuilder<DataSnapshot>(
        future: persistenceDao.getMessageQuery().once(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            print('${snapshot.error}');
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).disabledColor,
                    size: 48.0,
                  ),
                  SizedBox(height: 8.0,),
                  Text(
                    "Une erreur est survenue",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Theme.of(context).disabledColor
                    ),
                  )
                ],
              ),
            );
          }
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          List<Address> addresses = [];
          snapshot.data!.value.forEach((k,v) {
            addresses.add(
                Address(
                    as: v['as'],
                    id: 10,
                    rd: v['rd'],
                    site: v['site'])
            );
          });
          if (addresses.isEmpty)
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.format_list_bulleted_outlined,
                    color: Theme.of(context).disabledColor,
                    size: 48.0,
                  ),
                  SizedBox(height: 8.0,),
                  Text(
                    "Aucune entrée dans le registre",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Theme.of(context).disabledColor
                    ),
                  )
                ],
              ),
            );
          return ListView.separated(
            itemBuilder: (_, i) => AddressItem(address: addresses[i]),
            separatorBuilder: (_, i) => Divider(
              height: 0,
              thickness: 0.5,
            ),
            itemCount: addresses.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onNewAddress,
        child: Icon(Icons.add_circle_outline_outlined),
      ),
    );
  }

  void onSearch() {
    showSearch(
      context: context,
      delegate: AddressesSearch(),
    );
  }

  void onNewAddress() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => _NewAddressDialogScreen(), fullscreenDialog: true));
  }

  @override
  void dispose() {
    AddressesScreen.notifier.removeListener(onEvent);
    super.dispose();
  }
}

class AddressesSearch extends SearchDelegate<Address?> {
  AddressesSearch() : super(searchFieldLabel: "Chercher une entrée");

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          this.query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => this.close(context, null),
    );
  }

  Widget _buildSearch(String query) {
    if (query.isEmpty) return SizedBox();

    return FutureBuilder<List<Address>>(
      future: Database.instance.searchAddresses(query),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<Address> results = snapshot.data!;
          return ListView.separated(
            itemBuilder: (_, i) => AddressItem(address: results[i]),
            separatorBuilder: (_, i) => Divider(
              height: 0,
              thickness: 0.5,
            ),
            itemCount: results.length,
            shrinkWrap: true,
          );
        }
        // on n'affiche rien si la liste est vide ou aucune donnée
        else
          return SizedBox();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearch(this.query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearch(this.query);
  }
}

class _NewAddressDialogScreen extends StatefulWidget {
  const _NewAddressDialogScreen({Key? key}) : super(key: key);

  @override
  _NewAddressDialogScreenState createState() => _NewAddressDialogScreenState();
}

class _NewAddressDialogScreenState extends State<_NewAddressDialogScreen> {
  TextEditingController _siteController = TextEditingController(),
      _asController = TextEditingController(),
      _rdController = TextEditingController();
  FocusNode _asNode = FocusNode(), _rdNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nouvelle entrée"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          TextField(
            controller: _siteController,
            decoration: InputDecoration(hintText: "Nom du site"),
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(_asNode),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: _asController,
            focusNode: _asNode,
            decoration: InputDecoration(
                hintText: "AS (Autonomous System)", counterText: ""),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            maxLength: 5,
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(_rdNode),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: _rdController,
            focusNode: _rdNode,
            decoration: InputDecoration(
                hintText: "RD (Route Distinguisher)", counterText: ""),
            keyboardType: TextInputType.number,
            maxLength: 4,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onSaveAddress,
        child: Icon(Icons.done),
      ),
    );
  }

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void onSaveAddress() async {
    // vérifications
    if (_siteController.text.trim().isEmpty) {
      showToast("Entrez le nom du site");
      return;
    }
    if (_asController.text.trim().isEmpty) {
      showToast("Entrez le AS");
      return;
    }
    if (_rdController.text.trim().isEmpty) {
      showToast("Entrez le RD");
      return;
    }
    if (int.tryParse(_asController.text.trim()) == null) {
      showToast("Entrez un AS valide");
      return;
    }
    if (int.tryParse(_rdController.text.trim()) == null) {
      showToast("Entrez un RD valide");
      return;
    }

    int as = int.parse(_asController.text.trim());
    int rd = int.parse(_rdController.text.trim());

    if (as < 0 || 65535 < as) {
      showToast("Entrez un AS entre 0 et 65535");
      return;
    }
    if (rd < 0 || 8000 < rd) {
      showToast("Entrez un RD entre 0 et 8000");
      return;
    }
    // verification du rd
    if (await Database.instance.rdIsUsed(_rdController.text.trim())) {
      showToast("Ce RD est déjà utilisé");
      return;
    }
    final persistenceDao = PersistenceDao();
    persistenceDao.saveMessage({
      "site": _siteController.text.trim(),
      "as": _asController.text.trim(),
      "rd": _rdController.text.trim(),
    });
    Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (_) => AddressesScreen()));
    // enregistrement de l'adresse
    /*Database.instance.saveAddress(
      site: _siteController.text.trim(),
      as: _asController.text.trim(),
      rd: _rdController.text.trim(),
    ).then((value) {
      // notification de maj de la bd
      AddressesScreen.notifier.notifyListeners();
      // on rentre à la page précédente
      Navigator.of(context).pop();
    }).catchError((e) {
      print('$e');
    });*/
  }

  @override
  void dispose() {
    _siteController.dispose();
    _asController.dispose();
    _rdController.dispose();
    super.dispose();
  }
}
