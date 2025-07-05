(* C2PP
  ***************************************************************************

  Digikoo

  Copyright 2012-2025 Patrick Prémartin under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://digikoo.gamolf.fr/

  Project site :
  https://github.com/DeveloppeurPascal/Digikoo-v2-Delphi

  ***************************************************************************
  File last update : 2025-07-03T10:43:49.005+02:00
  Signature : 158a7efdec9d12b8cb890cd760230cb02eac838f
  ***************************************************************************
*)

unit uTxtAboutDescription;

interface

function GetTxtAboutDescription(const Language: string;
  const Recursif: boolean = false): string;

implementation

// For the languages codes, please use 2 letters ISO codes
// https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes

uses
  System.SysUtils,
  uConsts;

const
  CTxtEN = '''
Digikoo offers all fans of numbers and Sudoku the chance to play with their neurons. It's a great way to keep your mind sharp.

The rule is simple: put the same number only once per row and column on grids ranging from 2x2 to 9x9 squares.

*****************
* Credits

This application was developed by Patrick Prémartin in Delphi.

The game's graphics are courtesy of Kenney, Pictogrammers and CEI. They are used under license.

Background sounds are from the GSP 500 Noises compilation released on CD-Rom in 1995.

The background music is by Erin and Ginny Culp. Used under license, its reuse outside this video game is not authorized without prior written consent.

*****************
* Publisher info

This video game is published by OLF SOFTWARE, a company registered in Paris (France) under the reference 439521725.

****************
* Personal data

This program is autonomous in its current version. It does not depend on the Internet and communicates nothing to the outside world.

We have no knowledge of what you do with it.

No information about you is transmitted to us or to any third party.

We use no cookies, no tracking, no stats on your use of the application.

***************
* User support

If you have any questions or require additional functionality, please leave us a message on the application''s website or on its code repository.

To find out more, visit https://digikoo.gamolf.fr

''';
   CTxtFR = '''
Digikoo propose à tous les amateurs de chiffres et de Sudoku de jouer avec leurs neurones. Un très bon exercice pour garder un esprit au top.

La règle est simple : ne mettre qu'une seule fois le même chiffre par ligne et colonne sur des grilles s'enchainant de 2x2 à 9x9 cases.

*****************
* Remerciements

Cette application a été développée par Patrick Prémartin en Delphi.

Les éléments graphiques du jeu proviennent de Kenney, Pictogrammers et le CEI. Ils sont utilisés sous licence.

Les sons d'ambiance proviennent de la compilation GSP 500 Noises diffusée sur CD-Rom en 1995.

La musique de fond est de Erin et Ginny Culp. Utilisée sous licence, sa réutilisation en dehors de ce jeu vidéo n'est pas autorisée sans accord écrit préalable.

*****************
* Info éditeur

Ce jeu vidéo est éditée par OLF SOFTWARE, société enregistrée à Paris (France) sous la référence 439521725.

****************
* Données personnelles

Ce programme est autonome dans sa version actuelle. Il ne dépend pas d'Internet et ne communique rien au monde extérieur.

Nous n'avons aucune connaissance de ce que vous faites avec lui.

Aucune information vous concernant n'est transmise à nous ou à des tiers.

Nous n'utilisons pas de cookies, pas de tracking, pas de statistiques sur votre utilisation de l'application.

***************
* Assistance aux utilisateurs

Si vous avez des questions ou si vous avez besoin de fonctionnalités supplémentaires, veuillez nous laisser un message sur le site web de l'application ou sur son dépôt de code.

Pour en savoir plus, visitez https://digikoo.gamolf.fr

''';
  // CTxtIT = '';
  // CTxtDE = '';
  // CTxtJP = '';
  // CTxtPT = '';
  // CTxtES = '';

function GetTxtAboutDescription(const Language: string;
  const Recursif: boolean): string;
var
  lng: string;
begin
  lng := Language.tolower;
  if (lng = 'en') then
    result := CTxtEN
  else if (lng = 'fr') then // France
    result := CTxtFR
  else if not Recursif then
    result := GetTxtAboutDescription(CDefaultLanguage, true)
  else
    raise Exception.Create('Unknow description for language "' +
      Language + '".');
end;

end.
