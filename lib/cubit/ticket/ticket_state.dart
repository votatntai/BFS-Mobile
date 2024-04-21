import 'package:flutter_application_1/domain/models/tickets.dart';

class TicketState {}

class GetTicketLoadingState extends TicketState {}

class GetTicketSuccessState extends TicketState {
  final Tickets tickets;
  GetTicketSuccessState(this.tickets);
}

class GetTicketFailedState extends TicketState {
  final String message;
  GetTicketFailedState(this.message);
}

class CreateTicketLoadingState extends TicketState {}

class CreateTicketSuccessState extends TicketState {}

class CreateTicketFailedState extends TicketState {
  final String message;
  CreateTicketFailedState(this.message);
}

class GetTicketByIdLoadingState extends TicketState {}

class GetTicketByIdSuccessState extends TicketState {
  final Ticket ticket;
  GetTicketByIdSuccessState(this.ticket);
}

class GetTicketByIdFailedState extends TicketState {
  final String message;
  GetTicketByIdFailedState(this.message);
}

class UpdateTicketLoadingState extends TicketState {}

class UpdateTicketSuccessState extends TicketState {}

class UpdateTicketFailedState extends TicketState {
  final String message;
  UpdateTicketFailedState(this.message);
}
