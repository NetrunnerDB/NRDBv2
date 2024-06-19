import Controller from '@ember/controller';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';
import { Board, PLAYER, ENEMY } from './checkers';

export default class AdvancedSearchRoute extends Controller {
  @tracked animate = false;
  @tracked acceptUserInput = true;
  @tracked board;

  constructor(...args) {
    super(...args);

    // Set up the initial board state
    this.board = new Board();
    this.board.addPieceAtPosition(PLAYER, 3, 4);
    this.board.addPieceAtPosition(ENEMY, 4, 3);
    this.board.updateAllPiecesValidMoves();
  }

  get player() {
    return this.board.player;
  }

  get moves() {
    return this.board.player.moves;
  }

  get takes() {
    return this.board.player.takes;
  }

  get enemies() {
    return this.board.enemies;
  }

  @action tileClicked(x, y) {
    // Check the move is valid
    if (!this.acceptUserInput) {
      return;
    }
    // These are (should be) be mutually exclusive
    let isMove = this.player.isValidMove(x, y);
    let isTake = this.player.isValidTake(x, y);
    if (!isMove && !isTake) {
      return;
    }

    // Debounce
    this.acceptUserInput = false;

    // Move player
    this.board.movePlayerTo(x, y);
    // if (isTake) {
    //   let [takeX, takeY] = this.getTakeTarget(x, y);
    //   this.removeEnemyAt(takeX, takeY);
    // }
    // Move enemies
    this.animate = false;
    this.board.resetAllPiecesSources();
    this.aiStep();
    this.animateEnemies();

    // Set up UI for next turn
    this.board.updatePlayersValidMoves();

    // Force frontend to update (board is tracked)
    this.board = this.board;
  }

  // Helper function for determining if a list of tiles contains a given tile
  containsTile(tiles, x, y) {
    let tile = tiles.find(([_x, _y]) => x == _x && y == _y);
    return typeof tile != 'undefined';
  }

  aiStep() {
    // Cache enemies
    let enemies = this.enemies;

    // let enemyMoves = this.enemies.map((enemy) => [
    //   enemy,
    //   this.getEnemyMoveTargets(enemy),
    // ]);
    // // Check if any enemy can take the player
    // let lethalEnemy = enemyMoves.findIndex(
    //   ([_, moves]) => moves.takes.length > 0,
    // );
    // if (lethalEnemy >= 0) {
    //   let enemy = enemyMoves[lethalEnemy][0];
    //   let [x, y] = enemyMoves[lethalEnemy][1].takes[0];
    //   this.enemies[lethalEnemy] = {
    //     x: x,
    //     y: y,
    //     sourceX: enemy.x,
    //     sourceY: enemy.y,
    //   };
    //   return;
    // }
    // Move all enemies towards the player
    // this.enemies.map((enemy) => ({
    //   x: this.enemies[0].x,
    //   y: this.enemies[0].y,
    //   sourceX: this.enemies[0].x,
    //   sourceY: this.enemies[0].y,
    // }));
  }

  animateEnemies() {
    clearTimeout(this.inputCooldownId);
    this.animate = true;
    this.inputCooldownId = setTimeout(() => {
      this.acceptUserInput = true;
    }, 500);
  }
}
