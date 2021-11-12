import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OpenCV application'),
      ),
      body: Observer(
        builder: (context) {
          if (controller.state == HomeState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50,
                  ),
                  SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      text: "Ocorreu ao iniciar o aplicativo",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    onPressed: () => controller.init(),
                    child: Text(
                      "Tentar Novamente",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Carregue aqui sua imagem",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                //botões de seleção de imagem
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //Carregar imagem do telefone
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  height: 130,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListView(
                                        shrinkWrap: true,
                                        children: [
                                          ListTile(
                                            leading: Icon(
                                              Icons.camera_alt_outlined,
                                            ),
                                            title: Text("Camera"),
                                            onTap: () {
                                              Modular.to.pop();
                                              controller.loadImageFromCamera();
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.photo_library_outlined,
                                            ),
                                            title: Text("Galeria"),
                                            onTap: () {
                                              Modular.to.pop();
                                              controller.loadImageFromGallery();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            "Carregar imagem",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                //Seção de exibição das imagens
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //Imagem original
                    Observer(
                      builder: (_) {
                        if (controller.image != null) {
                          return SizedBox(
                            height: 300,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black45, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.file(controller.image),
                              ),
                            ),
                          );
                        } else {
                          if (controller.state != HomeState.erroLoadImage) {
                            return SizedBox(
                              height: 300,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text("Aguardando Imagem"),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 300,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    "Ocorreu um erro ao carregar a imagem, tente novamente",
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    //Seletor de filtros
                    SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Filtros",
                                ),
                                controller: controller.controllerFilters,
                                readOnly: true,
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    builder: (context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                        //height: 130,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.filters.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(
                                                controller.filters[index],
                                              ),
                                              onTap: () {
                                                Modular.to.pop();
                                                controller.state =
                                                    HomeState.readyToProcess;
                                                controller.applyFilter(
                                                  controller.filters[index],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Imagem Processada
                    Observer(
                      builder: (_) {
                        if (controller.processedImage != null) {
                          return SizedBox(
                            height: 300,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black45, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: controller.processedImage,
                              ),
                            ),
                          );
                        } else {
                          if (controller.state == HomeState.errorProcess) {
                            return SizedBox(
                              height: 300,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    "Ocorreu um erro no processamento, tente novamente",
                                  ),
                                ),
                              ),
                            );
                          } else if (controller.state == HomeState.loading) {
                            return SizedBox(
                              height: 300,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 20),
                                      Text("Processando Imagem"),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 300,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black45, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    "Aguardando inicio do processamento",
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
