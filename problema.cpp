#include <iostream>
#include <map>
#include <vector>
using namespace std;
struct Index
{
  int fila;
  int col;
};
void movement(vector<vector<int>>& matrix, Index movement) 
{
  matrix[movement.fila][movement.col] += 1;
  if (matrix[movement.fila][movement.col] == 10)
  {
    matrix[movement.fila][movement.col] = 0;
  }
  if (movement.fila < 2)
  {
    matrix[movement.fila + 1][movement.col] += 1;
    if (matrix[movement.fila + 1][movement.col] == 10)
    {
      matrix[movement.fila + 1][movement.col] = 0;
    }
  }
  if (movement.col < 2)
  {
    matrix[movement.fila][movement.col + 1] += 1;
    if (matrix[movement.fila][movement.col + 1] == 10)
    {
      matrix[movement.fila][movement.col + 1] = 0;
    }
  }
  if (movement.fila > 0)
  {
    matrix[movement.fila - 1][movement.col] += 1;
    if (matrix[movement.fila - 1][movement.col] == 10)
    {
      matrix[movement.fila - 1][movement.col] = 0;
    }
  }
  if (movement.col > 0)
  {
    matrix[movement.fila][movement.col - 1] += 1;
    if (matrix[movement.fila][movement.col - 1] == 10)
    {
      matrix[movement.fila][movement.col - 1] = 0;
    }
  }

}
void printMatrix(const std::vector<std::vector<int>>& matriz)
{
  for (int i = 0; i < matriz.size(); i++)
    {
      for (int j = 0; j < matriz[i].size(); j++)
        {
          cout << matriz[i][j] << " ";
        }
      cout << endl;
    }
}
int main()
{
  std::map<char, Index> mapa;
  mapa['a'] = {0, 0};
  mapa['b'] = {0, 1};
  mapa['c'] = {0, 2};
  mapa['d'] = {1, 0};
  mapa['e'] = {1, 1};
  mapa['f'] = {1, 2};
  mapa['g'] = {2, 0};
  mapa['h'] = {2, 1};
  mapa['i'] = {2, 2};
  string movimientos; 
  int cases = 0;
  while(getline(cin, movimientos)) 
  {
    cout << "Case #" << cases + 1 << ":" << endl;
    vector<vector<int>> matrix(3, vector<int>(3, 0));
    if (!movimientos.empty())
    {
      for (char c: movimientos)
      {
        movement(matrix, mapa[c]);
      }
      printMatrix(matrix);
    }
    else
    {
      printMatrix(matrix);
    }
    cases++;
  }
  return 0;
}
