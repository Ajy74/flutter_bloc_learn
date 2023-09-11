//events are always add in bloc

abstract class InternetEvent {}

class InternetLostEvent extends InternetEvent{}

class InternetGainedEvent extends InternetEvent{}