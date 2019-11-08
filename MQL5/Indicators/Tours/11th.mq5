
void OnStart() {
  MqlRates rates[];

  int copies = CopyRates(NULL, 0, 0, 100, rates);

  if (copies <= 0) {
    Print("Error coping price data ", GetLastError());
  } else {
    Print("Copied ", ArraySize(rates), " bars");
  }
}