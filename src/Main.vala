public class App : Gtk.Application {
  public App() {
    Object(
      application_id: "com.github.andirsun.backme-up",
      flags: ApplicationFlags.FLAGS_NONE
    );
  }

  public override void activate()
    requires(this.active_window != null)
  {
    this.active_window.show_all();
  }

  public override void startup() {
    base.startup();
    new Window(this);
  }

  public static int main(string[] args) {
    return new App().run(args);
  }
}

public class Welcome : Granite.Widgets.Welcome {
  public Welcome() {
    Object(
      title: "Back Me Up!",
      subtitle: "¿Qué desea hacer?"
    );
  }

  construct {
    this.append("document-import", "Importar", "Abrir un archivo de respaldo");
    this.append("document-export", "Exportar", "Crear un archivo de respaldo");

    this.activated.connect((index) => {
      switch (index) {
        case 0:
        case 1:
          print("Si");
          break;
      }
    });
  }
}

public class Header : Gtk.HeaderBar {
  public Header() {
    Object(
      show_close_button: true,
      decoration_layout: ":close"
    );
  }

  construct {
    this.get_style_context().add_class("Header");
  }
}

public class Window : Gtk.ApplicationWindow {
  private Gtk.Stack stack;

  public Window(App app) {
    Object(
      application: app,
      default_width: 500,
      default_height: 400
    );
  }

  construct {
    Gtk.CssProvider styles = new Gtk.CssProvider();
    styles.load_from_path("Styles.css");

    this.get_style_context().add_provider_for_screen(
      this.get_screen(),
      styles,
      Gtk.STYLE_PROVIDER_PRIORITY_USER
    );

    this.set_titlebar(new Header());

    this.stack = new Gtk.Stack();
    this.stack.add_named(new Welcome(), "Welcome");
    this.add(this.stack);
  }
}