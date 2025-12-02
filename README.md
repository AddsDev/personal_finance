
# Personal Finance App
## Finanzas Fácil 🤑

**Personal Finance App** es una aplicación móvil desarrollada en Flutter diseñada para facilitar la gestión de finanzas personales. Permite a los usuarios registrar ingresos y gastos, categorizarlos y visualizar estadísticas detalladas sobre su comportamiento financiero mediante gráficos interactivos.

El proyecto está estructurado como un **Monorepositorio (Monorepo)**, lo que facilita la escalabilidad, la reutilización de código y la separación de responsabilidades por features.

## 🏗️ Arquitectura

Este proyecto sigue los principios de **Clean Architecture** combinada con una estructura modular gestionada por paquetes locales. Se utiliza el patrón de diseño **BLoC** para la gestión del estado, asegurando una separación clara entre la interfaz de usuario y la lógica de negocio.

### Estructura del Monorepo

El proyecto se divide en paquetes independientes ubicados en la carpeta `packages/`:

* **📱 apps/personal\_finance\_app**: La aplicación principal que integra todas las funcionalidades.
* **🛠️ packages/core**: Contiene utilidades compartidas, manejo de errores (`Failure`) y configuraciones base.
* **🎨 packages/ui\_kit**: Sistema de diseño (Design System). Contiene átomos, moléculas y organismos (botones, inputs, tarjetas) y la definición del tema (colores, tipografía) para asegurar consistencia visual.
* **🔐 packages/features/auth**: Módulo encargado de la autenticación (Login, Registro, Firebase Auth).
* **💸 packages/features/transactions**: Módulo principal para la gestión de transacciones (CRUD), categorías y lógica de negocio financiera.
* **📡 packages/features/connectivity**: Módulo transversal para verificar el estado de la conexión a internet.

-----

## 📦 Paquetes y Dependencias

A continuación, se detallan las dependencias clave, justificando su elección en base a criterios de mantenibilidad, popularidad y seguridad:

### Gestión de Estado y Arquitectura

* **flutter\_bloc** `^9.1.1`.
* **get\_it** `^9.1.1`.
* **fpdart** `^1.2.0`.

### Backend y Servicios

* **firebase\_core, firebase\_auth, cloud\_firestore**: Backend-as-a-Service (BaaS) Seleccionado.
* **firebase\_app\_check**.

### Navegación y UI

* **go\_router** `^17.0.0`.
* **fl\_chart** `^0.71.0`: Es mantenida activamente y permite dibujar las estadísticas financieras sin depender de webviews pesadas.

### Herramientas de Desarrollo

* **melos** `^7.0.0`: Gestióm de monorepositorios.

-----

## 🚀 Pasos para clonar el repositorio

```bash
git clone https://github.com/AddsDev/personal_finance
cd personal_finance
```

## 🏃 Pasos para ejecutar la app

Dado que es un monorepo, es necesario realizar un proceso de "bootstrap" para enlazar los paquetes locales antes de ejecutar la aplicación.

1.  **Instalar Melos (si no lo tienes):**

    ```bash
    dart pub global activate melos
    ```

2.  **Inicializar el Monorepo (Bootstrap):**
    Este paso instala las dependencias de todos los paquetes y crea los enlaces simbólicos necesarios.

    ```bash
    melos bootstrap
    ```

3.  **Configuración de entorno:**

    * Asegúrate de tener configurado los archivos de Firebase (`google-services.json` para Android y `GoogleService-Info.plist` para iOS) en `apps/personal_finance_app`.

4.  **Ejecutar la aplicación:**
    Puedes usar el comando estándar de Flutter o el script definido en Melos:

    ```bash
    melos run run-app
    ```

    *O manualmente:*

    ```bash
    cd apps/personal_finance_app
    flutter run --device-id chrome
    ```

-----

## 🧪 Ejecución de Tests

El proyecto utiliza `melos` para orquestar la ejecución de pruebas en todos los módulos.

### Unit Test

Para ejecutar las pruebas unitarias en todos los paquetes que contengan tests:

```bash
melos run test:unit
```

*Este comando ejecutará `flutter test` en paralelo para optimizar el tiempo.*

### Unit Test & Coverage

Para ejecutar las pruebas y generar reportes de cobertura:
> Nota: requiere tener `lcov` instalado en tu sistema


Si deseas ejecutar el chequeo de calidad completo:

```bash
melos run quality:check
```

-----

## 🛠️ Mejoras Pendientes

Se han identificado áreas de mejora en el código actual para futuras iteraciones:

* **Validaciones de Dominio (Value Objects):** Implementar validaciones más estrictas en la capa de dominio en lugar de solo en la UI (Login/Registro).
* **Manejo de Errores en UI:** Mejorar la retroalimentación al usuario en el `TransactionBloc` cuando ocurre un error al cargar transacciones que actualmente carga una lista vacía en `onError`.
* **Caché:** Implementar lógica de invalidación de caché en `TransactionsRepository` para optimizar lecturas.
* **Atomic Design:** Refactorizar widgets complejos en `StatsPage` para seguir estrictamente la estructura de Atomic Design y pasarlo a UI Kit.
* **Income Stats:** Implementar el filtrado y visualización de gráficos para "Ingresos".
* **Seguridad:** Mover claves sensibles a variables de entorno o configuración remota.

-----

## ✍️ Autor

* **[AddsDev](https://github.com/AddsDev)**