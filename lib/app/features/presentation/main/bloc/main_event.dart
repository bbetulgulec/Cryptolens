abstract class MainEvent {
  const MainEvent();
}

class MainTabChanged extends MainEvent {
  final int index;
  const MainTabChanged(this.index);
}

class Logout extends MainEvent {
  const Logout();
}
