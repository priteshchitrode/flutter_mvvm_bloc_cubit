/// Represents the different lifecycle states of a UI screen.
///
/// This enum is primarily used inside `UIState<T>`
/// to determine how the UI should render.
///
/// States:
///
/// - INITIAL → Default state before any action is triggered.
/// - LOADING → Indicates an ongoing async operation (API call, processing).
/// - SUCCESS → Indicates successful data retrieval or operation completion.
/// - ERROR   → Indicates a failure state with an associated ErrorType.
///
/// Example usage:
///
///   if (state.dataType.status == Status.LOADING) {
///     return const CircularProgressIndicator();
///   }
///
///   if (state.dataType.status == Status.SUCCESS) {
///     return DataWidget(data: state.dataType.data);
///   }
///
///   if (state.dataType.status == Status.ERROR) {
///     return ErrorWidget(
///       state.dataType.errorType?.getText(context),
///     );
///   }
///
enum Status {
  INITIAL,
  LOADING,
  SUCCESS,
  ERROR,
}
