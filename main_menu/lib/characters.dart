

/*
* == Characters =================================================
*
* name: String
* spriteDir: String
* speed: int
* resistance: int
* attack speed: int
* abilities: list<Ability>
*
* ===============================================================
*/



class Characters {

  late String _name;
  late String _spriteDir;
  late List<int> _stats;
  late List<int> _initialstats;
  //late List<Ability> _abilities;

  Characters(this._name, this._spriteDir, this._stats, this._initialstats);

  void reset(){
    setStats(_initialstats);
  }

  void setStats(List<int> newstats){
    for(int i=0; i<_stats.length; i++){
      _stats[i] = newstats[i];
    }
  }

  List<int> getStats(){
    return _stats;
  }

}