// import 'package:example/pages/home.dart';
import 'package:example/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:saturne_pro_core/saturne_pro_core.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 400));
  await Highlighter.initialize(['dart']);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: SaturneProDesignSystem.lightMode,
      home: const Home(),
    );
  }
}

class Playground extends StatefulWidget {
  const Playground({super.key});

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  int _selectedTabIndex = 0;
  bool _hideTabs = false;
  final List<TabItem> _tabItems = [
    const TabItem(label: 'Sécurité sociale'),
    const TabItem(label: 'Coordonneés'),
    const TabItem(label: 'Contact'),
    const TabItem(label: 'Droits'),
    const TabItem(label: 'Mutuelle ( optionelle )'),
    const TabItem(label: 'Assuré'),
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _hideTabs = _scrollController.position.pixels > 30;
    });
    print('Scroll position: ${_scrollController.position.pixels}');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: CustomBottomNavBar(
          items: [
            BottomNavBarItemData(
              label: 'Accueil',
              icon: SaturneProIcons.estate,
              isSelected: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            BottomNavBarItemData(
              label: 'Teletransmission',
              icon: SaturneProIcons.receiptAlt,
              isSelected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            BottomNavBarItemData(
              label: 'Courses',
              icon: SaturneProIcons.clipboardAlt,
              isSelected: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            BottomNavBarItemData(
              label: 'Propositions',
              icon: SaturneProIcons.channel,
              isSelected: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
            BottomNavBarItemData(
              label: 'Profile',
              icon: SaturneProIcons.user,
              isSelected: _selectedIndex == 4,
              onTap: () => _onItemTapped(4),
            ),
          ],
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            CustomAppBar(
              title: 'Nouveau patient',
              useSafeArea: false,
              onBackTapped: () {
                print('hollaaaaa!!!');
              },
              trailingWidget: Builder(
                builder: (context) {
                  return CustomIconButton(
                    icon: SaturneProIcons.questionCircle,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        clipBehavior: Clip.hardEdge,
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return SectionLayout.withActionButtons(
                            height: 700,
                            titleLines: ['Connexion à votre compte'],
                            useSafeArea: false,
                            description:
                                "Connectez-vous pour accéder à vos trajets optimisés et gérer vos BT facilement.",
                            content: SizedBox(),
                            onBackTapped: () {
                              Navigator.pop(context);
                            },
                            actionButtonsLayout: ActionButtonsLayout.row,
                            mainButtonTitle: 'Main Button',
                            onMainButtonTapped: () {},
                            secondaryButtonTitle: 'Skip',
                            onSecondaryButtonTapped: () {},
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            AppBarTabs(
              tabItems: _tabItems,
              onTabChanged: _onTabChanged,
              isScrollable: true,
              hidden: _hideTabs,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(ds.spacing.l),
                child: Transform.translate(
                  offset: Offset(0, _hideTabs ? .0 : -55.6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OptionsWidget.nonSelectable(
                        title: 'pas encore sélectionné',
                        flagLabel: 'Moyen de Paiement',
                        leadingIcon: SaturneProIcons.creditCard,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
